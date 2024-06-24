import 'dart:async';
import 'package:checkin/constants/colors.dart';
import 'package:flutter/material.dart';

import '../constants/ScreenUtils.dart';
import 'walkthrough1.dart'; // Import your WalkThrough1 screen

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Set a timer to navigate to WalkThrough1 after 2 seconds
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WalkThrough1()), // Replace with your WalkThrough1 screen
      );
    });
  }

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
