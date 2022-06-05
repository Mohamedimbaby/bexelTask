import 'dart:io';

import 'package:bexel_task/data/product.dart';
import 'package:bexel_task/db_connector/product_database.dart';
import 'package:bexel_task/utils/cities.dart';
import 'package:bexel_task/utils/colors.dart';
import 'package:bexel_task/utils/dimensions.dart';
import 'package:bexel_task/utils/images.dart';
import 'package:bexel_task/utils/styles.dart';
import 'package:bexel_task/widgets/header_section.dart';
import 'package:bexel_task/widgets/snack_bar_show.dart';
import 'package:bexel_task/widgets/text-field_widget.dart';
import 'package:floating_chat_button/floating_chat_button.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:realm/src/results.dart';
import 'package:rxdart/rxdart.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  late RealmResults<Product> products ;
  TextEditingController nameController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController expiryController = TextEditingController();

  BehaviorSubject<String> selectedCity= BehaviorSubject();
  BehaviorSubject<bool> isActive= BehaviorSubject();
  BehaviorSubject<String> imagePath= BehaviorSubject();
  BehaviorSubject<RealmResults<Product>> productsSubject= BehaviorSubject<RealmResults<Product>>();

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
     ProductDatabase.setDBConfiguration();
     products =ProductDatabase.getAllProduct();

     productsSubject.sink.add(products);
     isActive.sink.add(false);
     imagePath.sink.add("");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingChatButton(
        chatIconBorderColor: mainColor,
        chatIconWidget: Container(
          height: Dimensions.width * .15,
          width: Dimensions.width * .15,
            color: mainColor,
            child: const Icon(Icons.add , color: Colors.white,size: 30,)),
        onTap: (_) {
          clearValues();
           showingBottomSheet(true);
          },
      ),
      body: StreamBuilder<RealmResults<Product>>(
        stream: productsSubject.stream,
        builder: (context, snapshot) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  buildHeaderSection(context, "Products"),
                  productsSubject.value.isNotEmpty ?
                  SizedBox(
                    height: Dimensions.height * .7,
                    child: ListView.builder(
                      itemCount: productsSubject.value.length,
                        itemBuilder: (context, index) {
                      return buildProductItem(productsSubject.value[index]);
                    }),
                  ):
                      SizedBox(
                        height: Dimensions.height * .7,
                        child: Center(
                          child:  Text("There is no Products ", style: text(fontSize: 22, color: mainColor, weight: FontWeight.w700),),),
                      )
                ],
              ),
            ),

          );
        }
      ),
    );
  }


  Widget buildProductItem(Product product) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 20 , vertical: 15),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 3,
            spreadRadius: 4,
            offset:const Offset(2,2),
              color: Colors.grey.shade200
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
            Expanded(
              flex: 19,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.file(File(product.imageFile) , width: Dimensions.width *.3,
                      height: 100,
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(width: Dimensions.width * .03,),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16,),
                        Text(product.name , style: text(fontSize: 22, color: mainColor, weight: FontWeight.w500),),
                        const SizedBox(height: 4,),
                        Text(product.details  , style: text(fontSize: 18, color: Colors.grey.shade600, weight: FontWeight.w300)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: Dimensions.width * .03,),
            Expanded(
              flex: 1,
              child: Column(
                children:  [
                  const SizedBox(height: 16,),
                  GestureDetector(
                      onTap: (){
                        showDialog(context: context,
                            builder: (c){
                          return Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)
                            ),
                            child: Container(
                              height: Dimensions.height * .23,
                              padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                              decoration:  BoxDecoration(
                                color: Colors.white,
                                  borderRadius: BorderRadius.circular(32)

                              ),
                              child: Column(
                                children:  [
                                  const SizedBox(height:  12,),
                                  Text("Warning !!" ,
                                    style: text(fontSize: 22, color: mainColor, weight: FontWeight.w700),
                                  ),
                                  const SizedBox(height:  20,),
                                  Text("Are you sure you want to delete this product ? " ,
                                  style: text(fontSize: 22, color: mainColor, weight: FontWeight.w700),
                                  ),
                                  const SizedBox(height:  16,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FlatButton(onPressed: (){
                                      Navigator.pop(context);
                                    }, child: Text("No" , style: text(fontSize: 18, color: mainColor, weight: FontWeight.w700),)),

                                    FlatButton(
                                        onPressed: ()async{
                                      ProductDatabase.deleteProduct(product);
                                      Navigator.pop(context);
                                      showSnackBar(context,"Product deleted successfully ");
                                      productsSubject.sink.add(ProductDatabase.getAllProduct());

                                    }, child: Text("Yes" , style: text(fontSize: 18, color: secondColor, weight: FontWeight.w700),)),

                                  ],
                                )
                                ],
                              ),
                            ),
                          );
                        }
                        );
                      },
                      child: Icon(Icons.delete , color: mainColor,)),
                  const SizedBox(height: 8,),
                  GestureDetector(
                      onTap: () {
                        assignProductValues(product);
                        showingBottomSheet(false,product: product);
                      },
                      child : Icon(Icons.update , color: secondColor,)),
                ],
              ),
            )
          ],

      ),
    );
  }


List<String> selectedCities = [];
  Widget buildCityItem(String e) {
    return StreamBuilder<String>(
      stream: selectedCity.stream,
      builder: (context, snapshot) {
        return GestureDetector(
          onTap: (){
            if(!selectedCities.contains(e)) {
              selectedCities.add(e);
            }
            else {
              selectedCities.remove(e);
            }
            selectedCity.sink.add(e);

          },
          child: Container(
            padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            margin:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color:!selectedCities.contains(e) ?  background : secondColor),
            child: Text(e , style: !selectedCities.contains(e) ?
            text(fontSize: 16, color: Colors.black, weight: FontWeight.w200) :
            text(fontSize: 16, color: Colors.white, weight: FontWeight.w300)
              ,),
          ),
        );
      }
    );
  }
  void loadImages() async {
    //add a button then in onPressed do this
    final ImagePicker _picker = ImagePicker();
    // Pick an image
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

// getting a directory path for saving
    final Directory directory = await getApplicationDocumentsDirectory();
    final File newImage = await File(image!.path).copy('${directory.path}/image1.png');
    // Capture a photo
    imagePath.sink.add(newImage.path);


  }
  @override
  void dispose() {
    isActive.close();
    nameController.dispose();
    expiryController.dispose();
    detailsController.dispose();
    selectedCity.close();
    imagePath.close();
    productsSubject.close();
    ProductDatabase.closeConnection();
    super.dispose();
  }

  void showingBottomSheet(  bool isAdding , {Product? product}) {
    showBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        context: context, builder: (context){
      return Container(
        height: Dimensions.height * .77,
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow:  [
              BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 2,
                  color: Colors.black12, offset: Offset(2, 2)
              )
            ],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            )
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),

              child: Column(
                children: [
                  const  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 8,
                        width: 100,
                        decoration: BoxDecoration(color: Colors.grey.shade200 , borderRadius: BorderRadius.circular(16)),),
                    ],
                  ),
                  const SizedBox(height: 30,),
                  buildTextField(
                      nameController,
                      width: MediaQuery.of(context).size.width,
                      height:MediaQuery.of(context).size.height,
                      hintText: "Product name" , fieldColor:const Color(0xffF3F3F3), textColor:const Color(0xffBEC9D6),styleColor:  mainColor ,
                      validator: (String? name){
                        if(name!.isEmpty ){
                          return "Product name is required";
                        }
                        return null;
                      }
                  ),
                  const SizedBox(height: 20,),
                  buildTextField(
                      detailsController,
                      width: MediaQuery.of(context).size.width,
                      height:MediaQuery.of(context).size.height,
                      hintText: "Product Description" , fieldColor:const Color(0xffF3F3F3), textColor:const Color(0xffBEC9D6),styleColor:  mainColor,
                      validator: (String? name){
                        if(name!.isEmpty ){
                          return "Product details is required";
                        }
                        return null;
                      }),
                  const SizedBox(height: 20,),
                  GestureDetector(
                    onTap: ()async{
                      DateTime? showDateResult = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime.now(), lastDate: DateTime(2025));
                      if(showDateResult != null) {
                        expiryController.text =
                        "${showDateResult.day }-${showDateResult.month }-${showDateResult.year }";
                      }

                    },
                    child: buildTextField(
                        expiryController,
                        width: MediaQuery.of(context).size.width,
                        height:MediaQuery.of(context).size.height,
                        hintText: "Product Expiry date" , fieldColor:const Color(0xffF3F3F3), textColor:const Color(0xffBEC9D6),styleColor:  mainColor,
                        validator: (String? name){
                          if(name!.isEmpty ){
                            return "Product Expiry date is required";
                          }
                          return null;
                        },
                        isEnabled: false
                    ),
                  ),
                  const SizedBox(height: 20,),
                  StreamBuilder<String>(
                      stream: imagePath.stream,
                      builder: (context, snapshot) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(child: Text(imagePath.value == "" ? "You have to select an image":imagePath.value, style: text(fontSize: 16, color:imagePath.value == "" ? Colors.redAccent : mainColor, weight: FontWeight.w500),)),
                            GestureDetector(
                              onTap: (){
                                loadImages();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                                decoration: BoxDecoration(
                                    color: background,
                                    borderRadius: BorderRadius.circular(8)

                                ),
                                child: Image.asset(pickImage, width: Dimensions.height * .05,
                                  height: Dimensions.height * .04,),
                              ),
                            ),
                          ],
                        );
                      }
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Is this product an active Product ? ", style: text(fontSize: 16, color: mainColor, weight: FontWeight.w500),),
                      StreamBuilder<bool>(
                          stream: isActive.stream,
                          builder: (context, snapshot) {
                            return Checkbox(
                                activeColor: secondColor,
                                value: isActive.value, onChanged: (value){
                              setState(() {
                                isActive.sink.add( value!);
                              });
                            });
                          }
                      )
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Wrap(
                    children:cities.map((e) => buildCityItem(e)).toList(),
                  ),
                  const SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      if(_formKey.currentState!.validate() ){
                        if( imagePath.value !=""){
                          if(isAdding )
                        {  ProductDatabase.insertProduct(
                              Product(productsSubject.value.length  ,
                                  detailsController.text,
                                  nameController.text  ,
                                  expiryController.text,
                                  isActive.value,
                                  imagePath.value,
                                  availability: selectedCities )
                          );
                        }
                          else {
                            ProductDatabase.updateProduct(product! ,
                                Product(product.id  ,
                                    detailsController.text,
                                    nameController.text  ,
                                    expiryController.text,
                                    isActive.value,
                                    imagePath.value,
                                    availability: selectedCities )
                            );
                          }
                          clearValues();
                          Navigator.pop(context);
                          productsSubject.sink.add(ProductDatabase.getAllProduct());

                        }
                        else {
                          showSnackBar(context,  "Image is not selected");
                        }

                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(color: mainColor, borderRadius: BorderRadius.circular(32) ),
                      child: Text(isAdding ? "Save" : "Update" ,style: text(fontSize: 24, color: Colors.white, weight: FontWeight.w700),),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void clearValues() {
    detailsController.text = "";
    nameController.text = "";
    expiryController.text = "";
    selectedCities = [];
    imagePath.sink.add("");
    isActive.sink.add(false);
  }

  void assignProductValues(Product product) {
    nameController.text = product.name;
    detailsController.text = product.details;
    expiryController.text = product.expiryDate;
    imagePath.sink.add(product.imageFile);
    isActive.sink.add(product.isActive);
    selectedCities.addAll( product.availability);
  }





}
