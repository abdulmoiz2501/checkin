import 'package:checkin/constants/colors.dart';
import 'package:flutter/material.dart';

import '../constants/ScreenUtils.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientLeft, gradientRight],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.6, 1],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200 * ScreenUtil.textScaleFactor,
                child: Image.asset('assets/logo_splash.png'),
              ),
              SizedBox(
                width: 200 * ScreenUtil.textScaleFactor,
                child: Image.asset('assets/logo_splash_mirror.png'), // Add your second image here
              ),
            ],
          ),
        ),
      ),
    );
  }
}
