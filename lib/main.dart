import 'package:bexel_task/ui/home_screen.dart';
import 'package:bexel_task/utils/colors.dart';
import 'package:bexel_task/utils/dimensions.dart';
import 'package:bexel_task/utils/images.dart';
import 'package:bexel_task/utils/styles.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
@override
  initState() {
    super.initState();
}
  @override
  Widget build(BuildContext context) {
    Dimensions.setDimensions(MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

    return Scaffold(
      backgroundColor: mainColor,
      body: Stack (
        children: [
          Container(
            width: Dimensions.width,
            height: Dimensions.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: Dimensions.height * .06,),
                Image.asset(logo,),
                 SizedBox(height: Dimensions.height * .035,),
                 Text(
                  'Welcome Product App',
                   style:  text(fontSize: 24, color: Colors.white, weight: FontWeight.w500),
                ),
                 SizedBox(height: Dimensions.height * .18,),

              ],
            ),

          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child : GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return HomeScreen();
                  }));
                },
                child: Container(
                  height: Dimensions.height * .07,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40 , vertical: 30),
                  decoration: BoxDecoration(
                      color:secondColor,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                            color: secondColor.withOpacity(.5) ,
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset:const Offset(1,1)
                        )
                      ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Proceed" ,style: text(fontSize: 18, color: Colors.white, weight: FontWeight.w500),),
                      const SizedBox(width: 30,),
                      const Icon(Icons.arrow_forward_ios_outlined , color: Colors.white24,),
                      const Icon(Icons.arrow_forward_ios_outlined , color: Colors.white38),
                      const Icon(Icons.arrow_forward_ios_outlined , color: Colors.white,)
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
