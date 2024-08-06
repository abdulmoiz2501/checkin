import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/api_constant.dart';
import '../models/user_model.dart';

class UserController extends GetxController {
  var user =  UserModel(
    id: 0,
    uid: '',
    name: '',
    number: 0,
    description: '',
    gender: '',
    sex: '',
    activeStatus: '',
    packageId: 0,
    date: DateTime.now(),
    email: '',
    age: 0,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    userPictures: [],
    subscribed: null,
  ).obs;

  var isLoading = true.obs;

  Future<void> fetchUser(String uid) async {
    try {
      isLoading(true);
      final response = await http.get(
          Uri.parse('$api/api/v1/users/getUsers?uid=$uid'));

      print('Response status of USER CONTROLLER FETCH USER ON LOGIN/SIGNUP: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        if (data['status'] == true) {
          print("this is the user from api: " + data['user'].toString());
          user.value = UserModel.fromJson(data['user']);
          print("this is the user from api: " + user.value.name.toString());
        } else {
          Get.snackbar('Error', 'User not found');
        }
      } else {
        Get.snackbar('Error', 'Failed to load user data');
      }
    } catch (e) {
      print('Error fetching user data: $e');
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading(false);
    }
  }
}

