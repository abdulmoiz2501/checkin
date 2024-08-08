import 'package:checkin/services/crud_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/colors.dart';
import '../controllers/user_auth_controller.dart';
import '../services/notification_service.dart';
import '../services/user_service.dart';
import '../widgets/snackbar.dart';
import 'UseLocationScreen.dart';

class AddNoteScreen extends StatefulWidget {
  final String uid;
  final String name;
  final int age;
  final String gender;
  final String sexuality;
  final List<String> imagePaths;

  const AddNoteScreen({
    Key? key,
    required this.uid,
    required this.name,
    required this.age,
    required this.gender,
    required this.sexuality,
    required this.imagePaths,
  }) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _noteController = TextEditingController();
  UserAuthController controller = Get.isRegistered<UserAuthController> ()? Get.find<UserAuthController>() : Get.put(UserAuthController());
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  bool _isLoading = false;
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref().child('users');


  Future<void> _saveUserDetails() async {
    print('saving details in db');
    try {
      await dbRef.child(controller.phoneNumber.value).set({
        'uid': widget.uid,
        'isCompleted': true,
      });
      print('User details saved successfully');
    } catch (e) {
      print('Error saving user details: $e');
    }
  }

  Future<void> _setCompletionStatus(bool status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isCompleted', status);
  }


  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserAuthController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false, // This removes the default back button
        backgroundColor: Colors.white, // Set the background color as needed
        elevation: 0, // Remove shadow if needed
      ),

      /*appBar: AppBar(
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
      ),*/
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
                        maxLines: null,
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
                  //String note = "note";
                  setState(() {
                    _isLoading = true;
                  });

                  //to save in realtime db
                  await _saveUserDetails();
                  final token = await PushNotifications.getDeviceToken();
                  await CRUDService.saveUserToken(token);

                  //to save in api
                  print('note: $note');
                  final resp = await controller.signUpUser({
                    'uid': widget.uid,
                    'name': widget.name,
                    'age': widget.age,
                    'gender': widget.gender,
                    'sexuality': widget.sexuality,
                  }, widget.imagePaths, note);
                  if(resp == true){
                    print("User signed up successfully");
                    await _setCompletionStatus(true);
                    setState(() {
                      _isLoading = false;
                    });
                    Get.offAll(() => GetLocationScreen());
                  }else{
                    Get.snackbar("Error", "Failed to sign up", backgroundColor: Colors.red);
                   /* showCustomSnackbar(context, Colors.red, 'Error signing up user');*/
                    setState(() {
                      _isLoading = false;
                    });
                  }
                  print("Next pressed");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: _isLoading
                    ? CircularProgressIndicator(color: textInvertColor)
                    :Ink(
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
