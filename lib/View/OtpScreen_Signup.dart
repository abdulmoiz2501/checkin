import 'dart:async';

import 'package:checkin/View/rules_screen.dart';
import 'package:checkin/controllers/user_auth_controller.dart';
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
   String verificationId;
   OtpScreenSignUp({required this.phoneNumber, Key? key, required this.verificationId}) : super(key: key);

  @override
  State<OtpScreenSignUp> createState() => _OtpScreenSignUpState();
}

class _OtpScreenSignUpState extends State<OtpScreenSignUp> {

  int timerSeconds = 20;
  Timer? _timer;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timerSeconds == 0) {
        setState(() {
          isRed = false;
          timerSeconds = 20;
          _timer?.cancel();
        });
      } else {
        setState(() {
          timerSeconds--;
        });
      }
    });
  }


  final UserAuthController controller = Get.isRegistered<UserAuthController> ()? Get.find<UserAuthController>() : Get.put(UserAuthController());
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
    //checkInput();
  }

  Future <void> checkInput() async {
    String currentInput = controllers.map((controller) => controller.text).join('');
    if (currentInput.length == 6) {
      await _verifyOtp(currentInput);
    }
  }

  Future <void> _verifyOtp(String otp) async {
    try {
      User? user = await _authService.confirmVerificationCode(widget.verificationId, otp);
      if (user != null) {
        controller.phoneNumber.value = widget.phoneNumber;
        print('User signed in: ${user.uid}');
        print('Phone: ${controller.phoneNumber.value}');
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
    _timer?.cancel();
    super.dispose();
  }

  void _resendCode() {
    setState(() {
      isRed = true;
      _startTimer();
    });

    // Call your resend code method here
    _authService.signUpWithPhoneNumber(widget.phoneNumber, (id) {
      setState(() {
        widget.verificationId = id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
/*        leading: IconButton(
          icon: SizedBox(
            width: 20, // Specify the desired width
            height: 20, // Specify the desired height
            child: Image.asset('assets/back_arrow.png'), // Load your SVG image
          ),
          onPressed: () {
            Get.back();
            print("Leading icon pressed");
          },
        ),*/
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
                  Row(
                    children: List.generate(6, (index) {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: TextFormField(
                            maxLength: 1,
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: "",
                              counterText: "",
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    color: isRed
                                        ? Colors.red
                                        : Colors
                                        .grey.shade400), // Outline color
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(
                                    color: isRed
                                        ? Colors.red
                                        : Colors
                                        .black), // Outline color when focused
                              ),
                            ),
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: TextStyle(
                              color: isRed ? Colors.red : Colors.black,
                            ),
                            focusNode: focusNodes[index],
                            controller: controllers[index],
                            onChanged: (value) => nextField(value, index),
                          ),
                        ),
                      );
                    }),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                          text: isRed
                              ? 'Send code again 00:${timerSeconds.toString().padLeft(2, '0')}'
                              : 'Didn\'t receive the code? ',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.normal,
                            color: Colors.black,
                          ),
                          children: isRed
                              ? []
                              : [
                            TextSpan(
                              text: 'Resend',
                              style: TextStyle(
                                fontFamily: 'SFProDisplay',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  _resendCode();
                                },
                            ),
                          ],
                          recognizer: isRed
                              ? (TapGestureRecognizer()
                            ..onTap = () {
                              _resendCode();
                              // Handle resend code action when input is wrong
                            })
                              : null,
                        ),
                      ),
                    ),
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
              onPressed: () async {
                String otp = controllers.map((controller) => controller.text).join('');
                //_verifyOtp(otp);
                await checkInput();
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
