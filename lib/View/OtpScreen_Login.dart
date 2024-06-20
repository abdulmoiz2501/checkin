import 'package:checkin/View/rules_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../utils/theme/custom_themes/text_theme.dart';

class OtpScreenLogin extends StatefulWidget {
  const OtpScreenLogin({Key? key}) : super(key: key);

  @override
  State<OtpScreenLogin> createState() => _OtpScreenLoginState();
}

class _OtpScreenLoginState extends State<OtpScreenLogin> {
  // Define focus nodes
  final focusNodes = List<FocusNode>.generate(5, (index) => FocusNode());

  // Define controllers
  final controllers = List<TextEditingController>.generate(
      5, (index) => TextEditingController());

  bool isRed = false;

  // Function to move focus to the next field if a digit is entered
  void nextField(String value, int index) {
    if (value.isNotEmpty) {
      print(index);
      if (index < 4) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else {
        FocusScope.of(context)
            .unfocus(); // to hide the keyboard if the last field is filled
      }
    }
    checkInput();
  }

  void checkInput() {
    String currentInput =
    controllers.map((controller) => controller.text).join('');
    if (currentInput == '11111') {
      setState(() {
        isRed = true;
      });
    } else {
      setState(() {
        isRed = false;
      });
    }
  }

  @override
  void dispose() {
    // Dispose the controllers and focus nodes
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Enter Code',
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
                    'We\'ve sent an SMS with an activation code to your phone +61 431 111 111',
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
                  Row(
                    children: List.generate(5, (index) {
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
                  SizedBox(height: MediaQuery.of(context).size.height* 0.02),
                  if (isRed)
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          'Wrong code, please try again',
                          style: TextStyle(color: Color(0xFFDB340B)),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: isRed ? 'Send code again   00:20' : 'Didn\'t receive the code? ',
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
                            // Handle resend code action
                          },
                      ),
                    ],
                    recognizer: isRed
                        ? (TapGestureRecognizer()
                      ..onTap = () {
                        // Handle resend code action when input is wrong
                      })
                        : null,
                  ),
                ),
              ),
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
                  Get.to(() => RulesScreen());
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
                      "Continue",
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
              height: MediaQuery.of(context).size.height * 0.03,
            ),
          ],
        ),
      ),
    );
  }
}
