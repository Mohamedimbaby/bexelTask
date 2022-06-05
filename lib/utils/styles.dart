import 'package:flutter/cupertino.dart';

TextStyle text (
{
required double fontSize ,
required Color color ,
  required FontWeight weight,
  double? height

}
){
  return TextStyle(
    fontSize: fontSize,
    color: color,
    fontWeight: weight,
    height: height ?? 1.2
  );
}
