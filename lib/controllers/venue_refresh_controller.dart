import 'package:checkin/controllers/check_in_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/check_in_model.dart';
import '../models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VenueRefreshController extends GetxController {
  var isLoading = false.obs;

  final currentPlaceId = ''.obs;
  final CheckInController checkInController = Get.find();
  final RxList<String> checkinGoals = <String>[].obs;
  final RxDouble minAge = 26.0.obs;
  final RxDouble maxAge = 70.0.obs;
  final RxBool isFirstHitDone = false.obs;
  final RxBool peopleOutsideRange = false.obs;

  // Fetch data from the provided API
  Future<void> fetchVenueData() async {
    print("Inside fetchVenueData()...");
    isLoading(true);

    String url =
        'https://check-in-apis-e4xj.vercel.app/api/v1/venues/getVenues?placeid=${currentPlaceId.value}&userId=${FirebaseAuth.instance.currentUser?.uid}';
    if (isFirstHitDone.value) {
      url += '&ageRange=${minAge.value.toInt()}-${maxAge.value.toInt()}';
    }

    if (checkinGoals.isNotEmpty) {
      url += '&checkInGoals=${checkinGoals.join(',')}';
      //
    }
    print(url);
    final currentUser = FirebaseAuth.instance.currentUser;

    try {
      final response = await http.get(Uri.parse(url));

      print('Response status of REFRESH CONTROLLER: ${response.statusCode}');
      print('Response body OF REFRESH CONTROLLER: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        //final venue = Venue.fromJson(responseBody['venues'][0]);
        checkInController.checkedInUsers.clear();
        for (var user in responseBody['venues'][0]['users']) {
          print(user['name']);
          //checkInController.filteredUsers.value.add(UserModel.fromJson(user));

          if (user['UId'] != currentUser?.uid) {
            checkInController.checkedInUsers.value
                .add(UserModel.fromJson(user));
          }
        }
        checkInController
            .filterUsersByGender(checkInController.currentGenderFilter.value);

        print(
            'the length of the users is ${checkInController.checkedInUsers.length}');
      } else {
        Get.snackbar('Error', 'Failed to fetch users. Please try again.');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'An error occurred. Please try again.');
    } finally {
      isLoading(false);
    }
  }
}
