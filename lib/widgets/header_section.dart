import 'package:bexel_task/utils/colors.dart';
import 'package:bexel_task/utils/dimensions.dart';
import 'package:bexel_task/utils/styles.dart';
import 'package:flutter/material.dart';

buildHeaderSection(BuildContext context , String title) {
  return Container(
    height: Dimensions.height * .23,
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    decoration: BoxDecoration(
      color: mainColor ,
      borderRadius: const BorderRadius.only(bottomLeft:Radius.circular(64) , bottomRight: Radius.circular(64) ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            const SizedBox(width: 8,),
            Text(title, style: text(fontSize: 22, color: Colors.white, weight: FontWeight.w700),),
          ],
        ),
        SizedBox(height: Dimensions.height * .03,),
        Flexible(
          child: Text("This product app will help you to manage your stock , with less effort and you can maintain and follow up your goods , exporting you data ",
            style: text(fontSize: 18, color: Colors.white, weight: FontWeight.w300, height: 1.4),),
        ),
      ],
    ),
  );
}
