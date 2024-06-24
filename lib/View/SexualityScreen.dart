import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../constants/colors.dart';
import '../widgets/selectable_button.dart';
import 'AddPicturesScreen.dart';

class SexualityScreen extends StatefulWidget {
  final String uid;
  final String name;
  final int age;
  final String gender;
  const SexualityScreen({super.key, required this.uid, required this.name, required this.age, required this.gender});

  @override
  State<SexualityScreen> createState() => _SexualityScreenState();
}

class _SexualityScreenState extends State<SexualityScreen> {
  String selectedOption = '';
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldMessengerKey,
      appBar: AppBar(
        leading: IconButton(
          icon: SizedBox(
            width: 20, //
            height: 20,
            child: Image.asset('assets/back_arrow.png'),
          ),

          onPressed: () {
            Get.back();
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
              'What is your sexuality?',
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
              'Share your sexual orientation to find connections that truly understand you.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                fontFamily: 'SFProDisplay',
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.022,
            ),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: SelectableButtonGroup(
                options: [
                  'Straight',
                  'Gay',
                  'Lesbian',
                  'Bisexual',
                  'Asexual',
                  'Pansexual',
                  'Intersex',
                  'Other',
                  'Prefer not to say',
                ],
                initialSelected: selectedOption,
                onSelected: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
              ),
            ),

            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
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
                  if(selectedOption.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select your sexuality.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                  else{
                    Get.to(() => AddPicturesScreen(
                      uid: widget.uid,
                      name: widget.name,
                      age: widget.age,
                      gender: widget.gender,
                      sexuality: selectedOption,
                    ));
                    print("Next pressed");
                    print('User ID: ${widget.uid}');
                    print('Name: ${widget.name}');
                    print('Age: ${widget.age}');
                    print('gender: ${widget.gender}');
                    print('sexuality: $selectedOption');
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
    );
  }
}
