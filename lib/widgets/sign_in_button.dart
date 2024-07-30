import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
typedef ButtonPressedCallback = void Function();
Widget customButton({
  required Color backgroundColor,
  required String iconAssetPath,
  required String buttonText,
  required Color textColor, // Specify the text color
  required ButtonPressedCallback onPressed, // Specify the destination widget for navigation
}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      elevation: 0, // Remove shadow
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      minimumSize: Size(double.infinity, 60), // Set the minimum size to increase height
    ),
    child: Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Image.asset(
              iconAssetPath,
              width: 24, // Adjust the width of the logo
              height: 24, // Adjust the height of the logo
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: textColor,
                  fontFamily: 'SFProDisplay',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
