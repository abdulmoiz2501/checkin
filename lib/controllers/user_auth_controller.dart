import 'dart:convert';

import 'package:checkin/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../models/user_model.dart';
import '../utils/popups/loaders.dart';



class UserAuthController extends GetxController {
  final phoneNumber = ''.obs;
  var user = Rxn<UserModel>();
  Future<bool> signUpUser(Map <String, dynamic> map, List<String> files,
      String note) async {
    try {
      print('Signing up user: $map');
      print('Phone: $phoneNumber.va');

      final uri = Uri.parse(
          'https://check-in-apis-e4xj.vercel.app/api/v1/users/signup');
      final request = http.MultipartRequest('POST', uri);
      request.fields['UId'] = map['uid'];
      request.fields['name'] = map['name'];
      request.fields['number'] = phoneNumber.value;
      request.fields['description'] = note;
      request.fields['gender'] = map['gender'];
      request.fields['activeStatus'] = 'true';
      request.fields['packageId'] = '1';
      request.fields['age'] = map['age'].toString();
      request.fields['sex'] = map['sexuality'] ?? 'error';
      final now = DateTime.now();
      final dateFormat = DateFormat('yyyy-MM-dd');
      request.fields['date'] = dateFormat.format(now);
      request.fields['email'] = "test@gmail.com";

      for (var imageFile in files) {
        request.files.add(
            await http.MultipartFile.fromPath('profilePicUrl', imageFile));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      print("//////THIS IS SIGN UP USER BODY//////");
      print(response.body);
      print(response.statusCode);

      print("//////NUMBER/////");
      print(phoneNumber.value);
      if (response.statusCode == 201 || response.statusCode == 200) {
        var data = json.decode(response.body);
        final UserController userController = Get.find();
        //userController.user.value = UserModel.fromJson(data['user']);
        userController.fetchUser(FirebaseAuth.instance.currentUser!.uid);
        return true;
      } else {
        print(phoneNumber.value);
        return false;
      }
    } catch (e) {
      print(phoneNumber.value);
      print('Error signing up user: $e');
    }
    return false;
  }

  Future<bool> signInUser(String uid) async {
    try {
      print('Signing in user with UID: $uid');
      final uri = Uri.parse(
          'https://check-in-apis-e4xj.vercel.app/api/v1/users/getUsers?uid=$uid');
      final response = await http.get(uri);
      print("/////////////////////////////////////");
      print('THIS IS THE RESPONSE OF SIGN IN USER IN USER AUTH CONTROLLER ${response.body}');
      print(response.statusCode);
      print("/////////////////////////////////////");

      if (response.statusCode == 200) {
        print('We are in the sign in user and ');
        var data = json.decode(response.body);
        final UserController userController = Get.find();
       await userController.fetchUser(uid);

        print('This is the user from api:${data['user']}');
        print("The user name is : ${userController.user.value!.name}");

        return true;
      } else {
        if(response.statusCode == 404)
          {
            Get.snackbar("No User Found", "Please sign up first");
          // VoidLoaders.errorSnackBar(title: "No user found" , message: "Please sign up first ");
          }
        return false;
      }
    } catch (e) {
      print('Error signing in user: $e');
    }
    return false;
  }
  bool get isUserSubscribed => user.value?.subscribed != null;
}

