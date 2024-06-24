import 'package:checkin/View/enterNumberScreen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/ScreenUtils.dart';
import '../constants/colors.dart';
import '../utils/theme/custom_themes/text_theme.dart';
import 'Sign_In.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.053),
        child: Center(
          child: Column(
            children: [
              Container(
                child: Image.asset(
                  'assets/logo_login.png',
                  width: ScreenUtil.responsiveWidth(0.5), // 50%
                  height: ScreenUtil.responsiveHeight(0.23),
                ),
              ),
              Container(
                child: Image.asset(
                  'assets/login1.png',
                  width: ScreenUtil.responsiveWidth(0.85), // 70%
                  height: ScreenUtil.responsiveHeight(0.23),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'A new way to meet',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = LinearGradient(
                            colors: <Color>[gradientLeft, gradientRight],
                            stops: [0.0, 0.7],
                          ).createShader(
                              Rect.fromLTWH(200.0, 100.0, 150.0, 70.0)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Text('The old fashioned way',
                    style:
                        VoidTextTheme.lightTextTheme.headlineMedium?.copyWith(
                      fontFamily: 'Taprom',
                      fontWeight: FontWeight.normal,
                      color: textBlackColor,
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
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
                    Get.to(() => NumberScreen());
                    print("Next pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0, // Remove shadow
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
                      child: Text(
                        "Create Account",
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
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Container(
                child: RichText(
                  text: TextSpan(
                      text: 'Already have an account? ',
                      style: VoidTextTheme.lightTextTheme.bodyLarge?.copyWith(
                        fontFamily: 'SFProDisplay',
                        fontWeight: FontWeight.w400,
                        color: textBlackColor,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sign In',
                          style:
                              VoidTextTheme.lightTextTheme.bodyLarge?.copyWith(
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.w700,
                            color: textBlackColor,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(() => Signin());
                              print('Sign in tapped');
                            },
                        ),
                      ]),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.19,
              ),
              Container(
                child: RichText(
                  textAlign: TextAlign.center, // Center align the text
                  text: TextSpan(
                    text: 'By Pressing create account you agree to\n',
                    style: VoidTextTheme.lightTextTheme.bodyLarge?.copyWith(
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.w400,
                      color: textBlackColor,
                    ),
                    children: [
                      TextSpan(
                        text: 'Terms of Use ',
                        style: TextStyle(
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.normal, // Change from bold to normal
                          color: textBlackColor, // Change color as needed
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Action when "Terms of Use" is tapped
                            print('Terms of Use tapped');
                          },
                      ),
                      TextSpan(
                        text: 'and ',
                        style: TextStyle(
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.w400,
                          color: textBlackColor,
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.normal, // Change from bold to normal
                          color: textBlackColor, // Change color as needed
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            // Action when "Privacy Policy" is tapped
                            print('Privacy Policy tapped');
                          },
                      ),
                    ],
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
