
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../constants/colors.dart';

class VenueHomeEmpty extends StatelessWidget {
  const VenueHomeEmpty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Remove default back button
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                // Handle tap
                print("Check out tapped");
              },
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: <Color>[gradientLeft, gradientRight],
                  ).createShader(bounds);
                },
                child: const Text(
                  '  Check out',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SFProDisplay',
                    color: Colors.white, // This color is just for the mask
                  ),
                ),
              ),
            ),
          ],
        ),
        leadingWidth: 120,
        title: const Text(
          'Forrester\'s',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'SFProDisplay',
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Image.asset('assets/bell.png'), // Path to your bell icon
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset('assets/settings.png'), // Path to your settings icon
            onPressed: () {},
          ),
        ],
      ),


      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0), // Adjust vertical padding as needed
            child: ToggleSwitch(
              minWidth: 100.0,
              initialLabelIndex: 3,
              cornerRadius: 20.0,
              activeFgColor: Colors.black,
              inactiveBgColor: Colors.grey[200],
              //inactiveFgColor: Colors(0xFF7A7D81),
              totalSwitches: 4,
              labels: ['Men', 'Women', 'Non binary', 'Everyone'],
              customTextStyles: const [
                TextStyle(fontFamily: 'SFProDisplay', fontSize: 12),

              ],
              activeBgColors: [
                [Colors.white, Colors.white],
                [Colors.white, Colors.white],
                [Colors.white, Colors.white],
                [Colors.white, Colors.white],
              ],
              radiusStyle: true,
              onToggle: (index) {
                print('switched to: $index');
              },
            ),
          ),
          Spacer(),
          // Centered content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/checking_in.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Looks like it's just you for now. \n Hang tight!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SFProDisplay',
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Don't worry though, more users could pop in at any moment.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'SFProDisplay',
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),

    );
  }
}
