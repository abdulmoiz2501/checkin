import 'package:flutter/material.dart';

void showCustomSnackbar(BuildContext context, Color backgroundColor, String message) {
  final snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0), // Adjust padding to ensure proper spacing
            child: Text(
              message,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'SFProDisplay',
                fontSize: 12,
              ),
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
          child: Text(
            'Dismiss',
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'SFProDisplay',
              fontSize: 12,
              decoration: TextDecoration.underline, // Underline the dismiss text
            ),
          ),
        ),
      ],
    ),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(10),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0), // Adjust padding for smaller height
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
