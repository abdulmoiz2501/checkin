import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import '../constants/colors.dart';
import 'GenderScreen.dart';

class BirthdayPage extends StatefulWidget {
  final String uid;
  final String name;
  const BirthdayPage({super.key, required this.uid, required this.name});

  @override
  State<BirthdayPage> createState() => _BirthdayPageState();
}

class _BirthdayPageState extends State<BirthdayPage> {
  TextEditingController _controller = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  Color hintTextColor = Colors.grey;
  int age = 0;


  void _showDatePicker() {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(1900, 1, 1),
      maxTime: DateTime.now(),
      onConfirm: (date) {
        setState(() {
          _controller.text = "${date.day}/${date.month}/${date.year}";
          age = _calculateAge(date);
        });
      },
      currentTime: DateTime.now(),
      locale:LocaleType.en,
    );
  }
  int _calculateAge(DateTime selectedDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - selectedDate.year;
    if (currentDate.month < selectedDate.month ||
        (currentDate.month == selectedDate.month && currentDate.day < selectedDate.day)) {
      age--;
    }
    return age;
  }
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
                    'What is birth date?',
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
                    'Date of Birth',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SFProDisplay',
                      color: textBlackColor,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
              Container(
                height: 60, // Adjust the height as needed
                decoration: BoxDecoration(
                  border: Border.all(color: hintTextColor), // Lighter grey outline
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0), // Adjust padding as needed
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'dd/mm/yyyy', // Lighter grey hint text
                      hintStyle: TextStyle(color: hintTextColor, fontSize: 14), // Lighter grey hint text color
                      border: InputBorder.none, // Remove the default underline border
                    ),
                    readOnly: true,
                    onTap: _showDatePicker,
                  ),
                ),
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
                  if(_controller.text.isEmpty){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please select your birth date.'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                  else if(age < 18)
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('You must be 18 years old to use this app.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  else{
                    print('User ID: ${widget.uid}');
                    print('Name: ${widget.name}');
                    print('Age: $age');
                    Get.to(() => GenderScreen(uid: widget.uid, name: widget.name, age: age));
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.03,)
          ],
        ),
      ),
    );
  }
}
