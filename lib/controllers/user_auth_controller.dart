import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';



class UserAuthController extends GetxController {
  final phoneNumber = ''.obs;
  Future<bool> signUpUser(Map <String, dynamic> map, List<String> files,
      String note) async {
    try {
      print('Signing up user: $map');
      print('Phone: $phoneNumber.va');

      final uri = Uri.parse(
          'https://check-in-production-b9fd.up.railway.app/api/v1/user/signup');
      final request = http.MultipartRequest('POST', uri);
      request.fields['UID'] = map['uid'];
      request.fields['name'] = map['name'];
      request.fields['number'] = phoneNumber.value;
      request.fields['description'] = note;
      request.fields['gender'] = map['gender'];
      request.fields['activeStatus'] = 'true';
      request.fields['packageId'] = '1';
      request.fields['age'] = map['age'].toString();
      request.fields['sex'] = map['sexuality'] ?? 'error';
      request.fields['date'] = "2024-06-20T00:00:00Z";

      for (var imageFile in files) {
        request.files.add(
            await http.MultipartFile.fromPath('profilePictureUrl', imageFile));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error signing up user: $e');
    }
    return false;
  }


  Future<bool> signInUser(String uid) async {
    try {
      print('Signing in user');
      final uri = Uri.parse(
          'https://check-in-production-b9fd.up.railway.app/api/v1/user/signin?uid=$uid');
      final response = await http.post(uri);
      print(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error signing in user: $e');
    }
    return false;
  }
}


//https://check-in-production-b9fd.up.railway.app/api/v1/user/signin?uid=jksjdkfjkdjnnn