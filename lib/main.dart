import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'View/SplashScreen.dart';
import 'View/walkThrough1.dart';
import 'View/walkThrough2.dart';
import 'View/walkThrough3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home:  WalkThrough1(),
    );
  }
}
