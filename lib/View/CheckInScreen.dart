import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../constants/colors.dart';
import '../controllers/check_in_controller.dart';
import 'VenueHomeEmpty.dart';
import 'VenueHomePopulated.dart';

class CheckinScreen extends StatefulWidget {
  const CheckinScreen({Key? key}) : super(key: key);

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the next screen after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Get.to(
          () => VenueHomePopulated()); // Update this to your actual next screen
    });
  }

  @override
  Widget build(BuildContext context) {
    final CheckInController checkInController = Get.find();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/checking_in.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 20),
                // Hold tight text
                const Text(
                  'Hold tight!',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'SFProDisplay',
                  ),
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: 'We are ',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontFamily: 'SFProDisplay',
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Checkin',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          foreground: Paint()
                            ..shader = LinearGradient(
                              colors: <Color>[gradientLeft, gradientRight],
                            ).createShader(
                                const Rect.fromLTWH(100.0, 20.0, 200.0, 70.0)),
                        ),
                      ),
                      const TextSpan(
                        text: ' you in!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors
                              .black, // Black color for this part of the text
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 20),
                // Circle with emoji and text below
                Column(
                  children: [
                    // Image.asset('assets/checkin_loader.png', width: 100, height: 120),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Lottie.asset(
                          'assets/animation/checkIn-animation.json',
                          fit: BoxFit.cover),
                    ),
                    SizedBox(height: 10),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return LinearGradient(
                              colors: <Color>[gradientLeft, gradientRight],
                            ).createShader(bounds);
                          },
                          child: Container(
                            width: 87,
                            height: 87,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            //border: Border.all(color: Colors.white, width: 1), // Inner white border
                            image: DecorationImage(
                              image: NetworkImage(
                                  checkInController.venueImage.value),
                              //image: AssetImage('assets/no_image.png'), // Path to your emoji asset
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: Image.asset(
                            'assets/lit.png',
                            width: 24,
                            height: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      checkInController.venueTitle.value,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SFProDisplay',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
