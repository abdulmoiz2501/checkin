import 'package:checkin/View/rules_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:checkin/services/auth_service.dart'; // Add this import

import '../constants/colors.dart';
import '../utils/theme/custom_themes/text_theme.dart';
import 'NameScreen.dart';

class OtpScreenSignUp extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  const OtpScreenSignUp({required this.phoneNumber, Key? key, required this.verificationId}) : super(key: key);

  @override
  State<OtpScreenSignUp> createState() => _OtpScreenSignUpState();
}

class _OtpScreenSignUpState extends State<OtpScreenSignUp> {
  final focusNodes = List<FocusNode>.generate(6, (index) => FocusNode());
  final controllers = List<TextEditingController>.generate(6, (index) => TextEditingController());
  bool isRed = false;
  final AuthService _authService = AuthService(); // Initialize AuthService

  void nextField(String value, int index) {
    if (value.isNotEmpty) {
      print(index);
      if (index < 5) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else {
        FocusScope.of(context).unfocus(); // to hide the keyboard if the last field is filled
      }
    }
    checkInput();
  }

  void checkInput() {
    String currentInput = controllers.map((controller) => controller.text).join('');
    if (currentInput.length == 6) {
      _verifyOtp(currentInput);
    }
  }

  void _verifyOtp(String otp) async {
    try {
      User? user = await _authService.confirmVerificationCode(widget.verificationId, otp);
      if (user != null) {
        Get.to(() => NameScreen());
      } else {
        setState(() {
          isRed = true;
        });
      }
    } catch (e) {
      setState(() {
        isRed = true;
      });
      print('Failed to sign in: $e');
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

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
            print("Leading icon pressed");
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.053),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Verification Code',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SFProDisplay',
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  RichText(
                    text: TextSpan(
                      text: 'Please type the verification code sent to ',
                      style: const TextStyle(
                        fontSize: 15,
                        fontFamily: 'SFProDisplay',
                        color: Colors.black,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: widget.phoneNumber,
                          style: const TextStyle(
                            fontSize: 15,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Form(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(6, (index) {
                        return Container(
                          width: 60,
                          child: TextFormField(
                            controller: controllers[index],
                            focusNode: focusNodes[index],
                            onChanged: (value) => nextField(value, index),
                            style: TextStyle(
                              fontSize: 24,
                              color: isRed ? Colors.red : Colors.black,
                            ),
                            keyboardType: TextInputType.number,
                            inputFormatters: [LengthLimitingTextInputFormatter(1), FilteringTextInputFormatter.digitsOnly],
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: isRed ? Colors.red : Colors.transparent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: isRed ? Colors.red : Colors.blue),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (isRed)
                    Text(
                      'The verification code entered is incorrect. Please try again.',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'SFProDisplay',
                        color: Colors.red,
                      ),
                    ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Didn't receive the code?",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'SFProDisplay',
                          color: Colors.black,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Resend code functionality
                        },
                        child: const Text(
                          'Resend',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
              onPressed: () {

                String otp = controllers.map((controller) => controller.text).join('');
                _verifyOtp(otp);
              },
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
                    "Verify",
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
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        ],
      ),
    );
  }
}
