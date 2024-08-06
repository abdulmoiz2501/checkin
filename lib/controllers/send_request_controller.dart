// controllers/send_request_controller.dart
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../constants/api_constant.dart';
import '../models/send_request_model.dart';
import '../services/notification_sending_service.dart';

class SendRequestController extends GetxController {
  Future<void> sendRequest(SendRequestModel request) async {
    final url = '$api/api/v1/requests/sendRequest';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(request.toJson()),
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == false) {
        // Handle error
        Get.snackbar('Error', 'An error occurred while sending the request');
        print('Error: ${responseData['message']}');
      } else {
        // Request sent successfully
        final data = await NotificationSendingService.getUserTokenFromFirestore(request.receiverUid);
        await NotificationSendingService.sendFriendRequestNotification(
          data!['token'],
          //userController.user.value.fullName,
        );
        print('Request sent successfully');
        Get.snackbar('Success', 'Request sent successfully');
      }
    } else {
      // Handle server error
      print('Server error: ${response.statusCode}');
    }
  }
}
