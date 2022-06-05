import 'dart:convert';
import 'dart:io';
import 'package:bexel_task/utils/dimensions.dart';
import 'package:bexel_task/utils/styles.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import 'package:bexel_task/data/product.dart';
import 'package:bexel_task/db_connector/product_database.dart';
import 'package:bexel_task/ui/products_screen.dart';
import 'package:bexel_task/ui/status_screen.dart';
import 'package:bexel_task/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:realm/realm.dart';
import 'package:rxdart/rxdart.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  BehaviorSubject<int> selectedIndex = BehaviorSubject<int>();
  @override
  initState(){
    selectedIndex.sink.add(0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: selectedIndex.stream,
      builder: (context, snapshot) {
        return SafeArea(
          child: Scaffold(
            body: buildScreen(selectedIndex.value, context ),
            bottomNavigationBar:Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: Colors.black.withOpacity(.1),
                  )
                ],
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                  child: GNav(
                    rippleColor: Colors.grey.shade800,
                    hoverColor: Colors.grey.shade100,
                    gap: 8,
                    activeColor: secondColor,
                    iconSize: 24,
                    padding:const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    duration:const Duration(milliseconds: 400),
                    tabBackgroundColor: secondColor.withOpacity(.2),
                    color: mainColor,
                    tabs: const [
                      GButton(
                        icon: Icons.home,
                        text: 'Home',
                      ),
                      GButton(
                        icon: Icons.shop_2_outlined,
                        text: 'Products',
                      ),
                      GButton(
                        icon: Icons.import_export,
                        text: 'Export',
                      ),

                    ],
                    selectedIndex: selectedIndex.value,
                    onTabChange: (index) {
                      selectedIndex.sink.add(index);
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      }
    );
  }

  buildScreen(int index, context) {
    switch(index){
      case 0 :
        return buildHomeScreen();
      case 1 :
        return buildProductScreen();
      case 2 :
        return buildExportScreen(context);


    }

  }

  buildHomeScreen() {
    return const StatusScreen();
  }
  buildProductScreen() {
    return const ProductsScreen();
  }
  String toJson(Product item){
    Map<String , dynamic > map = {
      "name" : item.name,
      "details" : item.details,
      "image" : item.imageFile,
      "expiry" : item.expiryDate,
      "isActive" : item.isActive,
      "availability" : item.availability,
    };
    return jsonEncode(map);
  }
  buildExportScreen(context) {
    ProductDatabase.setDBConfiguration();
    List  allProducts = [];
    RealmResults <Product >results =ProductDatabase.getAllProduct();
    results.forEach((item) {
      allProducts.add(toJson(item));
    });
    return Container(
      child: Center(
        child: RaisedButton(
          onPressed: ()async{
            File file = await writeJson(jsonEncode(allProducts));
              await OpenFile.open(file.path);
            showDialog(context: context,
                builder: (c){
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32)
                    ),
                    child: Container(
                      height: Dimensions.height * .26,
                      padding: const EdgeInsets.symmetric(horizontal: 20 , vertical: 10),
                      decoration:  BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32)

                      ),
                      child: Column(
                        children:  [
                          const SizedBox(height:  12,),
                          Text("Confirming !!" ,
                            style: text(fontSize: 22, color: mainColor, weight: FontWeight.w700),
                          ),
                          const SizedBox(height:  20,),
                          Text("your file saved at Downloads folder _productsDB_ " ,
                            style: text(fontSize: 22, color: mainColor, weight: FontWeight.w700),
                          ),
                          const SizedBox(height:  16,),
                          Row(
                            children: [
                              Expanded(
                                child: FlatButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text("ok" , style: text(fontSize: 18, color: mainColor, weight: FontWeight.w700),)),
                              ),


                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
            );
          },
          child: const Text("Export"),
        ),
      ),
    );
  }

  Future<File> get _localFile async {
    String path =  "/storage/emulated/0/Download";
    return File('$path/productDB.txt');
  }
  Future<File> writeJson(String Json) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString(Json);
  }
}
