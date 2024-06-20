import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';
import '../services/auth_service.dart';
import '../widgets/email_input_dialog.dart';
import '../widgets/sign_in_button.dart';
import 'Birthday.dart';

class ConnectAccount extends StatelessWidget {
  final String uid;
  final String name;

   ConnectAccount({super.key, required this.uid, required this.name});
  final AuthService _authService = AuthService();
  Future<void> _checkCompletionStatusAndNavigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isCompleted = prefs.getBool('isCompleted') ?? false;
    if (isCompleted) {
      Get.to(() => BirthdayPage(uid: uid, name: name));
    } else {
      Get.to(() => BirthdayPage(uid: uid, name: name));
    }
  }



/*  void _sendSignInLinkToEmail(String email) async {
    await _authService.sendSignInWithEmailLink(email);
    Get.snackbar(
      'Email Sent',
      'A sign-in link has been sent to $email',
      snackPosition: SnackPosition.BOTTOM,
    );
  }*/

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
          onPressed: () {
            Get.back();
            // Action when the leading icon is pressed
            print("Leading icon pressed");
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Action when Skip button is pressed
              Get.to(() => BirthdayPage(uid: uid, name: name));
              print("Skip pressed");
            },
            child: Text(
              "SKIP",
              style: TextStyle(
                color: textMainColor,
                fontFamily: 'SFProDisplay', // Specify the SF Pro Display font family
                fontWeight: FontWeight.w700, // or FontWeight.bold for bold
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.053),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'An easier way to sign back in',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'SFProDisplay',
                color: textBlackColor,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              'Connect an account to log back in quickly if you\'re signed out',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontFamily: 'SFProDisplay',
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            customButton(
              backgroundColor: Color(0xFF21262D),
              iconAssetPath: 'assets/apple.png',
              buttonText: "Continue with Apple",
              textColor: textInvertColor,
              //destinationWidget: BirthdayPage(uid: uid, name: name), // Pass uid and name
              onPressed: () {
                print('Email (apple) pressed');
                /*EmailInputDialog.show(context, (email) {
                  _sendSignInLinkToEmail(email);
                });*/
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            customButton(
              backgroundColor: Color(0xFFF4F6F7),
              iconAssetPath: 'assets/google.png',
              buttonText: "Continue with Google",
              textColor: textBlackColor,
              //destinationWidget: BirthdayPage(uid: uid, name: name), // Pass uid and name
              onPressed: () async {
                print('Google button pressed');
                await _authService.signInWithGoogle();
                await _checkCompletionStatusAndNavigate();
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            customButton(
              backgroundColor: Color(0xFF0078FF),
              iconAssetPath: 'assets/facebook.png',
              buttonText: "Continue with Facebook",
              textColor: textInvertColor,
              //destinationWidget: BirthdayPage(uid: uid, name: name), // Pass uid and name
              onPressed: () {
                print('Google button pressed');
                _authService.signInWithGoogle();
              },
            ),
          ],
        ),
      ),
    );
  }
}
