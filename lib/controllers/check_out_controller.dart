import 'package:checkin/View/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/api_constant.dart';
import '../models/check_out_model.dart';
import '../widgets/bottom_bav_bar.dart';

class CheckOutController extends GetxController {
  var isLoading = false.obs;

  Future<void> checkOutUser(CheckOutRequest request) async {
    isLoading(true);

    final url = '$api/api/v1/venues/checkout';
    final headers = {'Content-Type': 'application/json'};

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(request.toJson()),
      );


      print("//////RESPONSE OF CHECK OUT API//////");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (responseBody['status']) {
          Get.snackbar('Success', 'User checked out successfully.');
           //await Future.delayed(Duration(seconds: 3)); // Wait for snackbar to show
          // Hide the current SnackBar
          Get.context?.findAncestorStateOfType<ScaffoldMessengerState>()?.hideCurrentSnackBar();
          // Navigate back to the home screen
          Get.to(() => BottomNavigation());
          // Get.to(() => BottomNavigation());
          //Navigator.pushAndRemoveUntil(context, newRoute, predicate)
        } else {
          Get.snackbar('Error', responseBody['message']);
        }
      } else {
        Get.snackbar('Error', 'Failed to check out. Please try again.');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'An error occurred. Please try again.');
    } finally {
      isLoading(false);
    }
  }
}
