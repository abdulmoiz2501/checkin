
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/block_user_model.dart';

class BlockUserController extends GetxController {
  Future<void> blockUser(BlockUserModel blockUserModel) async {
    final url = 'https://check-in-apis-e4xj.vercel.app/api/v1/users/blockUser';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: blockUserModel.toJson(),
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 201  || response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == false) {
        Get.snackbar(
          'Block Status',
          responseData['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          'Block Status',
          'User blocked successfully.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        'Server Error',
        'Something went wrong. Please try again later.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
