import 'package:flutter/material.dart';

import 'dotted_border.dart';

class ClickableSquare extends StatelessWidget {
  final VoidCallback onTap;

  ClickableSquare({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: DottedBorderPainter(
          color: Colors.black,
          radius: 16.0,  // Circular radius
          dashLength: 8.0,  // Longer dashed lines
          dashGap: 4.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Center(
            child: Icon(
              Icons.add_circle,
              size: 30.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
