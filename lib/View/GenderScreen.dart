import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/colors.dart';
import '../widgets/gender_selection_tile.dart';
import 'SexualityScreen.dart';

class GenderScreen extends StatefulWidget {
  final String uid;
  final String name;
  final int age;
  const GenderScreen({super.key, required this.uid, required this.name, required this.age});

  @override
  State<GenderScreen> createState() => _GenderScreenState();
}

class _GenderScreenState extends State<GenderScreen> {
  String selectedGender = 'Male'; // Default selection
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
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'What is your gender?',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SFProDisplay',
                      color: textBlackColor,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    'Select the gender that best represents who you are. Your hoice is an important aspect of your identity, helping others understand and respect your individuality.',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'SFProDisplay',
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  GenderSelectionTile(
                    title: 'Male',
                    iconPath: 'assets/male.png', // Replace with your actual icon path
                    isSelected: selectedGender == 'Male',
                    onTap: () {
                      setState(() {
                        selectedGender = 'Male';
                      });
                    },
                  ),
                  GenderSelectionTile(
                    title: 'Female',
                    iconPath: 'assets/female.png', // Replace with your actual icon path
                    isSelected: selectedGender == 'Female',
                    onTap: () {
                      setState(() {
                        selectedGender = 'Female';
                      });
                    },
                  ),
                  GenderSelectionTile(
                    title: 'Non Binary',
                    iconPath: 'assets/binary.png', // Replace with your actual icon path
                    isSelected: selectedGender == 'Non Binary',
                    onTap: () {
                      setState(() {
                        selectedGender = 'Non Binary';
                      });
                    },
                  ),

                  SizedBox(height: MediaQuery.of(context).size.height * 0.09,),
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

                        Get.to(() => SexualityScreen(
                            uid: widget.uid,
                            name: widget.name,
                            age: widget.age,
                            gender: selectedGender
                        ));
                        print("Next pressed");
                        print('User ID: ${widget.uid}');
                        print('Name: ${widget.name}');
                        print('Age: ${widget.age}');
                        print('gender: $selectedGender');
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
                            "Next ",
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
                ],

              ),
            ),


          ],
        ),
      ),
    );
  }
}
