// controllers/payment_controller.dart

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/payment_model.dart';

class PaymentController extends GetxController {
  var isLoading = false.obs;
  var isPaymentSuccessful = false.obs;

  Future<void> addPayment(PaymentModel payment) async {
    isLoading(true);
    final url = 'https://check-in-apis-e4xj.vercel.app/api/v1/users/addPayment';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: json.encode(payment.toJson()),
      );

      print('Response of ADD PAYMENT API: ${response.body}');
      print('Status Code of ADD PAYMENT API: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        isPaymentSuccessful(true);
      } else {
        isPaymentSuccessful(false);
        // Handle error response
        print('Failed to add payment: ${response.body}');
      }
    } catch (e) {
      isPaymentSuccessful(false);
      // Handle exception
      print('Error adding payment: $e');
    } finally {
      isLoading(false);
    }
  }
}
