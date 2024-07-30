import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants/colors.dart';
import '../services/user_service.dart';
import 'ConnectAccount.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

 /* final UserService _userService = UserService();
  Future<void> _saveUserDetails(String uid, String name) async {
    // Dummy data for gender, note, and sexuality
    String gender = "gender_placeholder";
    String note = "note_placeholder";
    String sexuality = "sexuality_placeholder";

    await _userService.saveUserDetails(
      uid: uid,
      name: name,
      gender: gender,
      note: note,
      sexuality: sexuality,
      age: age,
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldMessengerKey,
      appBar: AppBar(
        leading: IconButton(
          icon: SizedBox(
            width: 20, // Specify the desired width
            height: 20, // Specify the desired height
            child: Image.asset('assets/back_arrow.png'), // Load your SVG image
          ),
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
                    'What is your name?',
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
                    'Please enter your legal first name',
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
                  Text(
                    'First Name',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SFProDisplay',
                      color: textBlackColor,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.008,
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
                        controller: _nameController,
                        decoration: InputDecoration(
                          hintText: 'Enter name', // Lighter grey hint text
                          hintStyle: TextStyle(color: hintTextColor, fontSize: 14), // Lighter grey hint text color
                          border: InputBorder.none, // Remove the default underline border
                        ),
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
                onPressed: () async {
                  String name = _nameController.text;
                  User? user = FirebaseAuth.instance.currentUser;
                  String? uid = user?.uid;
                  if (uid != null && name.isNotEmpty) {
                    print("UID: $uid");
                    //await _saveUserDetails(uid, name);
                    Get.to(() => ConnectAccount(uid: uid, name: name));
                    print("Next pressed with UID: $uid and Name: $name");
                  } else if(name.isEmpty) {
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please enter your name.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                    if (uid == null) {
                      print("Error: UID is empty");
                    }
                    if (name.isEmpty) {
                      print("Error: Name is empty");
                    }
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
