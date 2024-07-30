import 'package:checkin/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/subscription_model.dart';

class SubscriptionController extends GetxController {
  var isLoading = false.obs;

   Future<void> addSubscription(SubscriptionModel subscription) async {
    try {
      isLoading(true);
      final response = await http.post(
        Uri.parse('https://check-in-apis-e4xj.vercel.app/api/v1/users/addSubscription'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(subscription.toJson()),
      );
      print("RESPONSE BODY OF ADD SUBSCRIPTION API ${response.body}");
      print("RESPONSE CODE OD ADD SUBSCRIPTION API ${response.statusCode}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        if (data['status'] == true || data['status'] == "true") {
          final UserController userController = Get.find();
          userController.fetchUser(FirebaseAuth.instance.currentUser!.uid);
          Get.snackbar('Success', 'Subscription added successfully');
        } else {
          Get.snackbar('Error', 'Failed to add subscription');
        }
      } else {
        Get.snackbar('Error', 'Failed to add subscription');
      }
    } catch (e) {
      print('Error adding subscription: $e');
      Get.snackbar('Error', 'An error occurred');
    } finally {
      isLoading(false);
     // Get.back();
    }
  }
}
