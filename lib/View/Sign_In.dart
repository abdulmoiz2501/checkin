import 'package:checkin/View/HomeScreen.dart';
import 'package:checkin/View/OtpScreen_Login.dart';
import 'package:checkin/View/rules_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';
import '../services/auth_service.dart';
import '../widgets/email_input_dialog.dart';
import '../widgets/sign_in_button.dart';
import 'NameScreen.dart';
import 'OtpScreen_Signup.dart';

class Signin extends StatelessWidget {
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
   Signin({super.key});

  final AuthService _authService = AuthService();
  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      String fullPhoneNumber = _phoneController.text.trim();
      _authService.signUpWithPhoneNumber(fullPhoneNumber, (verificationId) {
        Get.to(() => OtpScreenLogin(
          phoneNumber: fullPhoneNumber,
          verificationId: verificationId,
        ));
      });
    }
  }
  Future<void> _checkCompletionStatusAndNavigate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isCompleted = prefs.getBool('isCompleted') ?? false;
    if (isCompleted) {
      Get.to(() => RulesScreen());
    } else {
      Get.to(() => NameScreen());
    }
  }

/*  void _sendSignInLinkToEmail(String email) async {
    await _authService.sendSignInWithEmailLink(email).whenComplete(() => Get.snackbar(
      'Email Sent',
      'A sign-in link has been sent to $email',
      snackPosition: SnackPosition.BOTTOM,
    )
    );
  }*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        child: Form(
          key: _formKey,
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
                  border:
                      Border.all(color: hintTextColor), // Lighter grey outline
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 2.0), // Adjust padding as needed
                  child: TextFormField(
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText:
                          'Enter your phone number', // Lighter grey hint text
                      hintStyle: TextStyle(
                          color: hintTextColor,
                          fontSize: 14), // Lighter grey hint text color
                      border:
                          InputBorder.none, // Remove the default underline border
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      } else if (value.length < 12) {
                        return 'Phone number must be greater than 11 digits including country code. ';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Text(
                'You will recieve an SMS verificaion that may apple message and data rates.',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'SFProDisplay',
                  color: Color(0xFF909396),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    colors: [gradientLeft, gradientRight],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: _onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
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
                      child: const Text(
                        "Next",
                        style: TextStyle(
                          color: textInvertColor,
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.033,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    vertical: 10), // Adjust vertical padding as needed
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Color(0xFFD3D4D5), // Specify the desired color
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0), // Adjust horizontal padding as needed
                      child: Text(
                        'OR',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(
                              0xFF909396), // Specify the same color for the text
                          fontWeight:
                              FontWeight.bold, // Optional: Make the text bold
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
                onPressed: ()  {
                  ///Apple
                  /*EmailInputDialog.show(context, (email) {
                    _sendSignInLinkToEmail(email);
                  });*/
                }, // Specify the text color
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              customButton(
                backgroundColor: Color(0xFFF4F6F7),
                iconAssetPath: 'assets/google.png',
                buttonText: "Continue with Google",
                textColor: textBlackColor,
                onPressed: () async {
                  print('Google button pressed');
                  await _authService.signInWithGoogle();
                  await _checkCompletionStatusAndNavigate();
                },  // Specify the text color
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              customButton(
                backgroundColor: Color(0xFF0078FF),
                iconAssetPath: 'assets/facebook.png',
                buttonText: "Continue with Facebook",
                textColor: textInvertColor,
                onPressed: () async{
                print('Google button pressed');
                await _authService.signInWithGoogle();
              },  // Specify the text color
              ),
            ],
          ),
        ),
      ),
    );
  }
}
