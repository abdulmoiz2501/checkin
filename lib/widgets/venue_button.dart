import 'package:checkin/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientButtonWithIcon extends StatelessWidget {
  final String text;
  final String assetPath;
  final Color leftGradient;
  final Color rightGradient;
  final VoidCallback onPressed;

  GradientButtonWithIcon({
    required this.text,
    required this.assetPath,
    required this.leftGradient,
    required this.rightGradient,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 42,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientLeft, gradientRight],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(30.0),
        ),
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              assetPath,
              width: 20, // Adjust the icon size as needed
              height: 20, // Adjust the icon size as needed
            ),
            SizedBox(width: 8),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                fontFamily: 'SFProDisplay',
              ),
            ),
          ],
        ),
      ),
    );
  }
}