import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationTesting extends StatelessWidget {
  const AnimationTesting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          height: 300,
          'assets/animation/like_animation.json',
          repeat: true,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
