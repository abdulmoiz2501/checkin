import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/view_profile_model.dart';


class ViewProfileController extends GetxController {
  var userProfile = Rxn<User>();
  var isLoading = false.obs;
  var images = <String>[].obs;
  @override
  void onInit() async{
    super.onInit();
    await fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    final url = 'https://check-in-apis-e4xj.vercel.app/api/v1/users/getUsers?uid=oAR5pa5Hd4bumJaZWRpfbi8Ehy82';

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
        for(var i in profile.user.userPictures){
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
