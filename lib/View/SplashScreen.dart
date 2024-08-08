import 'dart:async';
import 'package:checkin/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => WalkThrough1()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [gradientLeft, gradientRight],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.6, 1],
          ),
        ),
        child: Lottie.asset(
          'assets/animation/Splashscreen_logo_Animation.json',
          fit: BoxFit.cover,
        ),
        // child: Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       SizedBox(
        //         width: 200 * ScreenUtil.textScaleFactor,
        //         child: Image.asset('assets/logo_splash.png'),
        //       ),
        //       SizedBox(
        //         width: 200 * ScreenUtil.textScaleFactor,
        //         child: Image.asset('assets/logo_splash_mirror.png'),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
