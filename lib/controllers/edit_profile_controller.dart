// controllers/edit_profile_controller.dart

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../constants/api_constant.dart';
import '../models/edit_profile_model.dart';

class EditProfileController extends GetxController {
  var isLoading = false.obs;
  final RxBool showSexualOrientation = false.obs;

  Future<void> updateProfile(String userId, EditProfileModel profile) async {
    isLoading.value = true;
    final url =
        '$api/api/v1/user/editProfile?userId=$userId';

    var request = http.MultipartRequest('PUT', Uri.parse(url));
    request.fields.addAll(profile.toJson());
    request.fields['showSexualOrientation'] = showSexualOrientation.value.toString();

    // Helper function to download and save network image to file
    Future<File> _downloadFile(String url, String filename) async {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$filename';
      final response = await http.get(Uri.parse(url));
      final file = File(filePath);
      return file.writeAsBytes(response.bodyBytes);
    }

    if (profile.localImages != null) {
      for (var imagePath in profile.localImages!) {
        if (imagePath != null) {
          request.files.add(await http.MultipartFile.fromPath(
            'profilePicUrl',
            imagePath,
          ));
        }
      }
    }

    /// Iterate over the images and add them to the request
    /*for (var image in profile.images) {
      if (image != null) {
        if (image is String && image.startsWith('http')) {
          // If the image is a network URL, download it first
          File downloadedFile = await _downloadFile(image, basename(image));
          request.files.add(http.MultipartFile.fromBytes(
            'pictures',
            downloadedFile.readAsBytesSync(),
            filename: basename(downloadedFile.path),
          ));
        } else if (image is File) {
          // If the image is a local file
          request.files.add(await http.MultipartFile.fromPath(
            'pictures',
            image.path,
          ));
        }
      }
    }*/

    print('Request: ${request.fields}');
    print('Request: ${request.files}');
    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print('Response: ${response.body}');
      print('Response: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Profile updated successfully');
      } else {
        Get.snackbar('Error', 'Failed to update profile');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
