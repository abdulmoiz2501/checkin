import 'package:checkin/View/OtpScreen_Login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/colors.dart';
import '../widgets/sign_in_button.dart';
import 'OtpScreen_Signup.dart';

class Signin extends StatelessWidget {
  const Signin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SizedBox(
            width: 20, // Specify the desired width
            height: 20, // Specify the desired height
            child: Image.asset('assets/back_arrow.png'), // Load your SVG image
          ),
          // Load your SVG image
          onPressed: () {
            Get.back();
            // Action when the leading icon is pressed
            print("Leading icon pressed");
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.053),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome back',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'SFProDisplay',
                color: textBlackColor,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              'Sign in with your phone number',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontFamily: 'SFProDisplay',
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),

            Container(
              height: 60, // Adjust the height as needed
              decoration: BoxDecoration(
                border: Border.all(color: hintTextColor), // Lighter grey outline
                borderRadius: BorderRadius.circular(10), // Rounded corners
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 2.0), // Adjust padding as needed
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Enter your phone number', // Lighter grey hint text
                    hintStyle: TextStyle(color: hintTextColor, fontSize: 14), // Lighter grey hint text color
                    border: InputBorder.none, // Remove the default underline border
                  ),
                ),
              ),
            ),
            
            Text(
              'You will recieve an SMS verificaion that may apple message and data rates.',style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              fontFamily: 'SFProDisplay',
              color: Color(0xFF909396),
            ),),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.033,
            ),
            Container(
          padding: EdgeInsets.symmetric(vertical: 10), // Adjust vertical padding as needed
          child: Row(
            children: [
              Expanded(
                child: Divider(
                  color: Color(0xFFD3D4D5), // Specify the desired color
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0), // Adjust horizontal padding as needed
                child: Text(
                  'OR',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color(0xFF909396), // Specify the same color for the text
                    fontWeight: FontWeight.bold, // Optional: Make the text bold
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: Color(0xFFD3D4D5), // Specify the same color
                ),
              ),
            ],
          ),
        ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            customButton(
              backgroundColor: Color(0xFF21262D),
              iconAssetPath: 'assets/apple.png',
              buttonText: "Continue with Apple",
              textColor: textInvertColor,
              destinationWidget: OtpScreenLogin(),// Specify the text color
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            customButton(
              backgroundColor: Color(0xFFF4F6F7),
              iconAssetPath: 'assets/google.png',
              buttonText: "Continue with Google",
              textColor: textBlackColor,
              destinationWidget: OtpScreenLogin(),// Specify the text color
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            customButton(
              backgroundColor: Color(0xFF0078FF),
              iconAssetPath: 'assets/facebook.png',
              buttonText: "Continue with Facebook",
              textColor: textInvertColor,
              destinationWidget: OtpScreenLogin(),// Specify the text color
            ),









          ],
        ),
      ),
    );
  }
}
