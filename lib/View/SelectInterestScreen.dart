import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/colors.dart';
import '../widgets/selectable_button.dart';
import 'CheckInScreen.dart';

class SelectInterestScreen extends StatefulWidget {
  const SelectInterestScreen({super.key});

  @override
  State<SelectInterestScreen> createState() => _SelectInterestScreenState();
}

class _SelectInterestScreenState extends State<SelectInterestScreen> {
  String selectedOption = '';

  void showSnackbar(String message) {
    Get.snackbar(
      'Select Interest',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: EdgeInsets.only(bottom: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            Flexible(
              child: IconButton(
                icon: SizedBox(
                  width: 20,
                  height: 20,
                  child: Image.asset('assets/back_arrow.png'), // Load your image
                ),
                onPressed: () {
                  Get.back();
                  print("Leading icon pressed");
                },
              ),
            ),
            Flexible(
              child: GestureDetector(
                onTap: () {
                  Get.back();
                  print("Back text pressed");
                },
                child: Text(
                  "Back",
                  style: TextStyle(
                    color: Color(0xFFF83600),
                    fontSize: 16,
                    fontFamily: 'SFProDisplay',
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        leadingWidth: 100, // Adjust this width as necessary
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.053),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Container(
                      height: 200,
                      width: 200,
                      child: Image.asset('assets/interestIcon.png'),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
                  Text(
                    'What are you looking for?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SFProDisplay',
                      color: textBlackColor,
                    ),
                  ),SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),

                  Text(
                    'Discover people who share your interests.',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'SFProDisplay',
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  SelectableButtonGroup(
                    options: [
                      'Friends',
                      'Networking',
                      'Dates',
                      'Food',
                      'Parties',
                      'Events',
                      'Drinks',
                    ],
                    initialSelected: selectedOption,
                    onSelected: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                  ),

                ],
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
                  if (selectedOption.isEmpty) {
                    showSnackbar('Please select at least one interest.');
                  } else {
                    Get.to(() => CheckinScreen());
                    print("Next pressed");
                  }
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
                      "Lets go!",
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
          ],
        ),
      ),
    );
  }
}
