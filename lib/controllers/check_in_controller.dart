import 'package:checkin/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../View/CheckInScreen.dart';
import '../models/check_in_model.dart';

class CheckInController extends GetxController {
  var isLoading = false.obs;
  final RxList<UserModel> checkedInUsers = <UserModel>[].obs;
  var filteredUsers = <UserModel>[].obs;
  var currentGenderFilter = 'Everyone'.obs;
  final currentPlaceId = ''.obs;
  final venueTitle = ''.obs;
  final venueImage = ''.obs;
  final RxInt currentGenderFilterIndex = 3.obs;

  @override
  void onInit() {
    super.onInit();
    filteredUsers.assignAll(checkedInUsers);
    filterUsersByGender('Everyone');
  }

  Future<void> checkInUser(CheckInRequest request) async {
    isLoading(true);

    final url = 'https://check-in-apis-e4xj.vercel.app/api/v1/venues/checkin';
    final headers = {'Content-Type': 'application/json'};
    final currentUser = FirebaseAuth.instance.currentUser;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(request.toJson()),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final checkInResponse = CheckInResponse.fromJson(responseBody);
        checkedInUsers.value.clear();
        /* for (var user in responseBody['venue']['users'])
          {
            checkedInUsers.value.add(UserModel.fromJson(user));
          }*/
        for (var user in responseBody['venue']['users']) {
          if (user['UId'] != currentUser?.uid) {
            checkedInUsers.value.add(UserModel.fromJson(user));
          }
        }

        filterUsersByGender(currentGenderFilter.value);
        if (checkInResponse.status) {
          currentPlaceId.value = request.placeId;
          venueTitle.value = request.venueName;
          // venueImage.value = request.venueImage;
          // Handle successful check-in, e.g., navigate to the next screen
          Get.to(() => CheckinScreen(), arguments: checkInResponse.venue);
        } else {
          Get.snackbar('Error', checkInResponse.message);
        }
      } else {
        Get.snackbar('Error', 'Failed to check-in. Please try again.');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'An error occurred. Please try again.');
    } finally {
      isLoading(false);
    }
  }

  void filterUsersByGender(String gender) {
    currentGenderFilter.value = gender;

    if (gender == 'Everyone') {
      filteredUsers.assignAll(checkedInUsers);
    } else {
      filteredUsers.value = checkedInUsers
          .where((user) => user.gender.toLowerCase() == gender.toLowerCase())
          .toList();
    }
    print('Filtered Users: ${filteredUsers.length}');
    // print('filtered user name is ${filteredUsers[0].name}   ');
    for (var user in filteredUsers) {
      print(
          'User: ${user.name}, Gender: ${user.gender}'); // Debugging statement
    }
  }

/*  Future<void> rehitAPI(CheckInRequest request) async {
    isLoading(true);
    final url = 'https://check-in-apis-e4xj.vercel.app/api/v1/venues/checkin';
    final headers = {'Content-Type': 'application/json'};
    final currentUser = FirebaseAuth.instance.currentUser;

    try {
      final response = await http.post(
          Uri.parse(url),
        headers: headers,
        body: json.encode(request.toJson()),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        checkedInUsers.clear();
        for (var user in responseBody['venue']['users']) {
          if (user['UId'] != currentUser?.uid) {
            checkedInUsers.add(UserModel.fromJson(user));
          }
        }

        filterUsersByGender(currentGenderFilter.value);
      } else {
        Get.snackbar('Error', 'Failed to fetch users. Please try again.');
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'An error occurred. Please try again.');
    }
    finally {
      isLoading(false);
    }
  }*/
}
