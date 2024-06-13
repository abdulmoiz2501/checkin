import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ScreenUtil {
  static double get width => Get.width;
  static double get height => Get.height;
  static double get textScaleFactor => Get.textScaleFactor;
  static EdgeInsets get padding => Get.mediaQuery.padding;
  static EdgeInsets get viewPadding => Get.mediaQuery.viewPadding;
  static EdgeInsets get viewInsets => Get.mediaQuery.viewInsets;
  static Orientation? get orientation => Get.context?.orientation;

  // Example method to calculate responsive size based on screen width
  static double responsiveWidth(double percentage) {
    return Get.width * percentage;
  }

  // Example method to calculate responsive size based on screen height
  static double responsiveHeight(double percentage) {
    return Get.height * percentage;
  }
}
