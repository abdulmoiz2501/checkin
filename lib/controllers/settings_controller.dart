import 'package:checkin/View/Login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/api_constant.dart';

class SettingsController extends GetxController {
  var isLoading = false.obs;

  Future<void> deleteAccount(String uid) async {
    isLoading.value = true;
    final url =
        '$api/api/v1/user/deleteAccount?uid=$uid';

    try {
      final response = await http.delete(Uri.parse(url));
      print(response.body);

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody['status'] == true) {
          Get.snackbar(
            "Success",
            responseBody['message'],
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          // Navigate to the desired screen
          Get.offAll(Login());
        } else {
          Get.snackbar(
            "Error",
            "Failed to delete account",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      } else {
        Get.snackbar(
          "Error",
          "Failed to delete account",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "An error occurred",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
