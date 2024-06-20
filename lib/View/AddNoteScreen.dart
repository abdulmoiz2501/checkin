import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import '../services/user_service.dart';
import 'UseLocationScreen.dart';

class AddNoteScreen extends StatefulWidget {
  final String uid;
  final String name;
  final int age;
  final String gender;
  final String sexuality;

  const AddNoteScreen({
    Key? key,
    required this.uid,
    required this.name,
    required this.age,
    required this.gender,
    required this.sexuality,
  }) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _noteController = TextEditingController();
  final UserService _userService = UserService();

  Future<void> _saveUserDetails(
      String uid, String name, int age, String gender, String sexuality, String note) async {
    await _userService.saveUserDetails(
      uid: uid,
      name: name,
      age: age,
      gender: gender,
      sexuality: sexuality,
      note: note,
    );
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    'Write a short note for others to see',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SFProDisplay',
                      color: textBlackColor,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFD3D4D5)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 2.0),
                      child: TextField(
                        controller: _noteController,
                        decoration: InputDecoration(
                          hintText: 'What\'s on your mind?',
                          hintStyle: TextStyle(color: Color(0xFF909396), fontSize: 16),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Text(
                    'Don\'t stress if you don\'t know what to write, you can change it any time!',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'SFProDisplay',
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    'Here are some examples to get your creative juices going!',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'SFProDisplay',
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Text(
                    '"A random fact about me is..."',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'SFProDisplay',
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '"We\'re a similar type of weird if... "',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'SFProDisplay',
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    '"Let\'s make sure we\'re on the same page about..."',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      fontStyle: FontStyle.italic,
                      fontFamily: 'SFProDisplay',
                      color: Colors.grey,
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
                onPressed: () async {
                  String note = _noteController.text.trim();
                  await _saveUserDetails(
                    widget.uid,
                    widget.name,
                    widget.age,
                    widget.gender,
                    widget.sexuality,
                    note,
                  );
                  Get.to(() => GetLocationScreen());
                  print("Next pressed");
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
                    child: Text(
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          ],
        ),
      ),
    );
  }
}
