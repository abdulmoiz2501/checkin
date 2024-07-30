import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class RejectRequestController extends GetxController {
  Future<void> rejectRequest(String userId, String senderId) async {
    try {
      final uri = Uri.parse('https://check-in-apis-e4xj.vercel.app/api/v1/requests/rejectRequest');
      final response = await http.put(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'userId': userId,
          'senderId': senderId,
        }),
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Request rejected successfully');
      } else {
        Get.snackbar('Error', 'Failed to reject request');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while rejecting the request');
    }
  }
}
