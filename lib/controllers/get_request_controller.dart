// get_request_controller.dart

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/get_request_model.dart';
import '../models/user_model.dart';


class GetRequestController extends GetxController {
  var recRequests = <RecRequest>[].obs;
  final RxBool isLoading = false.obs;


  Future<void> fetchRequests(String userId) async {
    print('The value of loading is $isLoading');
    isLoading.value = true;
    recRequests.clear();
    final uri = Uri.parse('https://check-in-apis-e4xj.vercel.app/api/v1/requests/getRequests?userId=$userId');
    final response = await http.get(uri);


    print(response.body);
    print(response.statusCode);
    recRequests.clear();
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status']) {
        recRequests.value = (responseData['recRequests'] as List)
            .map((request) => RecRequest.fromJson(request))
            .toList();
        isLoading.value = false;

      }
      isLoading.value = false;

    } else {
      Get.snackbar('Error', 'Failed to fetch requests');
      isLoading.value = false;

    }
    isLoading.value = false;

  }
}
