import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constant.dart';
import '../services/notification_sending_service.dart';

class AcceptRequestController extends GetxController {
  Future<void> acceptRequest(String userId, String senderId) async {
    try {
      final uri = Uri.parse('$api/api/v1/requests/acceptRequest');
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
        final data = await NotificationSendingService.getUserTokenFromFirestore(senderId);
        await NotificationSendingService.sendFriendRequestAcceptedNotification(
          data!['token'],
          //userController.user.value.fullName,
        );
        Get.snackbar('Success', 'Request accepted successfully');
      } else {
        Get.snackbar('Error', 'Failed to accept request');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while accepting the request');
    }
  }
}
