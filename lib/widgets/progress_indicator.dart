import 'package:flutter/material.dart';
import '../constants/colors.dart'; // Make sure to import your colors file if you have custom colors

class CustomCircularProgressIndicator extends StatelessWidget {


  const CustomCircularProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: gradientLeft,
      ),
    );
  }
}
