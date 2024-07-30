import 'package:flutter/material.dart';



const gradientLeft =  Color(0xFFF83600);
const gradientRight = Color(0xFFFE8C00);
const textMainColor = Color(0xFFF83600);
const textBlackColor = Color(0xFF21262D);
const textInvertColor = Color(0xFFFFFFFF);
const hintTextColor = Color(0xFFD3D4D5);


class MyColors {
  static Map<int, Color> grey = {
    500: Color(0xFF666666),
  };
}
Color getColorFromIndex(Map<int, Color> colorMap, int index) {
  return colorMap[index] ?? Colors.black; // Return default black if the index is not found
}

