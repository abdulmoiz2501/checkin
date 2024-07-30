import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';

class NewConnectionScreen extends StatelessWidget {
  const NewConnectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF2B3036),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Emoji
              Image.asset(
                'assets/emoji.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 20),
              // Text
              Text(
                'You have a new',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w200,
                  fontFamily: 'SFProDisplay',
                  color: Colors.white,
                ),
              ),
              const Text(
                'connection!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SFProDisplay',
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              // Avatar Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Left Avatar
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/ava_1.png'),
                  ),
                  const SizedBox(width: 20),
                  // Check-in Logo
                  Image.asset(
                    'assets/checking_in.png',
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(width: 20),
                  // Right Avatar
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/ava_2.png'),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Send a message button
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle send a message
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    padding: EdgeInsets.zero,
                    shadowColor: Colors.transparent,
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [gradientLeft, gradientRight],
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Send a message",
                        style: TextStyle(
                          color: textInvertColor,
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Continue browsing button
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Handle continue browsing
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Color(0xFF2B3036),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(color: Colors.white, width: 2),
                    ),
                  ),
                  child: const Text(
                    'Continue browsing',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SFProDisplay',
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
