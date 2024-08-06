import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constants/api_constant.dart';
import '../models/view_profile_model.dart';

class ViewProfileController extends GetxController {
  var userProfile = Rxn<UserM>();
  var isLoading = false.obs;
  var images = <String>[].obs;
  @override
  void onInit() async {
    super.onInit();
    await fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    final url =
        '$api/api/v1/users/getUsers?uid=${FirebaseAuth.instance.currentUser!.uid}';

    try {
      print("INSIDE FETCH USER PROFILE");
      final response = await http.get(Uri.parse(url));

      print('The response body of view profile controller is${response.body}');
      print(response.statusCode);

      if (response.statusCode == 200 || response.statusCode == 201) {
        images.clear();
        var data = jsonDecode(response.body);
        var profile = ViewProfileModel.fromJson(data);
        userProfile.value = profile.user;
        for (var i in profile.user.userPictures) {
          images.add(i.imageUrl);
        }
        //images.value = List<String>.from(data['user']['pictures'].map((pic) => pic['imageUrl']));
        print('total images are ${images.length}');

        userProfile.value = profile.user;
      } else {
        print('Failed to load user profile');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading.value = false;
    }
    }
}