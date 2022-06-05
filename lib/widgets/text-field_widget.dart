import 'package:bexel_task/utils/colors.dart';
import 'package:flutter/material.dart';

Widget buildTextField(TextEditingController controller, {required String hintText,required double width ,required double height , Color? fieldColor, Color? textColor ,Color? styleColor ,required String? Function (String? ) validator , bool? isEnabled })
{
  return Container(
//Type TextField
    width: width ,
    height: 70,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),

    ),
    child: TextFormField(
      enabled: isEnabled ?? true,
      controller: controller,

      decoration: InputDecoration(
        errorMaxLines: 1,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        enabledBorder: OutlineInputBorder(
            borderSide:const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(16)
        ),
        disabledBorder: OutlineInputBorder(
            borderSide:const BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(16)
        ),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor),
            borderRadius: BorderRadius.circular(16)
        ),
        errorBorder: OutlineInputBorder(
            borderSide:const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(16)
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderSide:const BorderSide(color: Colors.red),
            borderRadius: BorderRadius.circular(16)
        ),
        hintText: hintText, // pass the hint text parameter here
        hintStyle: TextStyle(color: textColor),
      ),
      validator: validator,
      style: TextStyle(color: styleColor , fontWeight: FontWeight.w900),
    ),
  );
}