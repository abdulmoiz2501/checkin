import 'package:firebase_auth/firebase_auth.dart';
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


  void _showSnackBar(BuildContext context, Color backgroundColor, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: backgroundColor,
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
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
            width: 20,
            height: 20,
            child: Image.asset('assets/back_arrow.png'),
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
                fontFamily: 'SFProDisplay',
                fontWeight: FontWeight.w700,
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
                try {
                  print('Google button pressed');
                  User? user = await _authService.signInWithGoogle();

                  ///SnapShot TODO
                  if (user != null) {
                    _showSnackBar(context, Colors.green, 'The account connected successfully.');
                    await _checkCompletionStatusAndNavigate();
                  } else {

                    print('Google sign-in canceled');
                  }
                } catch (e) {
                  print('Google sign-in error: $e');
                  if (e is FirebaseAuthException) {
                    if (e.code == 'credential-already-in-use') {
                      _showSnackBar(context, Colors.red, 'This Google account is already associated with a different user account.');
                    } else if (e.code == 'provider-already-linked') {
                      _showSnackBar(context, Colors.red, 'User has already been linked to the given provider.');
                    } else {
                      _showSnackBar(context, Colors.red, 'An error occurred. Please try again.');
                    }
                  } else {
                    _showSnackBar(context, Colors.red, 'An unexpected error occurred. Please try again.');
                  }
                }
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
               /* print('Google button pressed');
                _authService.signInWithGoogle();*/
              },
            ),
          ],
        ),
      ),
    );
  }
}
