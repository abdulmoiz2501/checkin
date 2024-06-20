import 'package:checkin/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientCircle extends StatelessWidget {
  final double size;
  final String assetPath;

  GradientCircle({required this.size, required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [gradientLeft, gradientRight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Image.asset(
          assetPath,
          width: size * 0.5,
          height: size * 0.5,
        ),
      ),
    );
  }
}

