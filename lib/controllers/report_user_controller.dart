import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/report_user_model.dart';

class ReportUserController extends GetxController {
  Future<bool> reportUser(ReportUserModel reportUserModel) async {
    final url = 'https://check-in-apis-e4xj.vercel.app/api/v1/users/reportUser';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: reportUserModel.toJson(),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Handle successful response
        print('Report submitted successfully');
        return true;
      } else {
        // Handle error response
        print('Failed to submit report');
        print(response.body);
        return false;
      }
    } catch (e) {
      print('Error occurred: $e');
      return false;
    }
  }
}
