import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VenueSingularMarkerController extends GetxController {
  var isLoading = true.obs;
  var totalCheckIns = 0.obs;

  Future<void> fetchCheckInData(String placeId) async {
    isLoading(true);
    try {
      final url = Uri.parse('https://check-in-apis-e4xj.vercel.app/api/v1/venues/getVenues?placeid=$placeId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == true && data['venues'].isNotEmpty) {
          totalCheckIns.value = data['venues'][0]['totalCheckIns'];
        } else {
          totalCheckIns.value = 0;
        }
      } else {
        totalCheckIns.value = 0;
      }
    } catch (e) {
      print('Error: $e');
      totalCheckIns.value = 0;
    } finally {
      isLoading(false);
    }
  }
}
