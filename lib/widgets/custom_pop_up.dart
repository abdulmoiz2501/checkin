import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../constants/colors.dart';

void showCustomPopup({
  required BuildContext context,
  required String headingText,
  required String subText,
  required String buttonText,
  required String belowButtonText,
  required VoidCallback onButtonPressed,
  required VoidCallback onBelowButtonPressed,
  required VoidCallback onGuidelinesPressed,
  required bool showGuidelines,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Center(
          child: Text(
            headingText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'SFProDisplay',
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: subText.split('guidelines')[0],
                  style: TextStyle(fontFamily: 'SFProDisplay', color: Colors.grey),
                  children: [
                    if(showGuidelines)
                    TextSpan(
                      text: 'guidelines',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        color: Colors.grey,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = onGuidelinesPressed,
                    ),
                    TextSpan(
                      text: subText.split('guidelines').length > 1 ? subText.split('guidelines')[1] : '',
                      style: TextStyle(fontFamily: 'SFProDisplay', color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                onButtonPressed();
                Navigator.of(context).pop();

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                elevation: 0, // Remove shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [gradientLeft, gradientRight],
                  ),
                  borderRadius: BorderRadius.circular(25),

                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  alignment: Alignment.center,
                  child: Text(
                    buttonText,
                    style: TextStyle(
                      color: textInvertColor,
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            GestureDetector(

              onTap: onBelowButtonPressed,
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [gradientLeft, gradientLeft],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Text(
                  belowButtonText,
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    color: Colors.white,
                   fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
