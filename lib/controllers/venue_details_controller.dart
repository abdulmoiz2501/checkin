import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VenueDetailsController extends GetxController {
  var isLoading = true.obs;
  var totalPeopleCheckedIn = 0.obs;
  var interests = <Map<String, dynamic>>[].obs;
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> fetchVenueDetails(String placeId) async {
    isLoading(true);
    try {
      final url = Uri.parse('https://check-in-apis-e4xj.vercel.app/api/v1/venues/getVenues?placeid=$placeId&userId=${user!.uid}');
      print('Request URL: $url');
      final response = await http.get(url);

      print('Response status: ${response.statusCode}');
      print('THE RESPONSE OF VENUE DETAILS CONTROLLER Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);
        if (data['status'] == false) {
          totalPeopleCheckedIn.value = 0;
          interests.assignAll([
            {'label': 'Friends', 'count': 0},
            {'label': 'Networking', 'count': 0},
            {'label': 'Dates', 'count': 0},
            {'label': 'Food', 'count': 0},
            {'label': 'Parties', 'count': 0},
            {'label': 'Events', 'count': 0},
            {'label': 'Drinks', 'count': 0},
          ]);
        } else {

          totalPeopleCheckedIn.value = data['venues'][0]['totalCheckIns'];

          interests.assignAll([
            {'label': 'Friends', 'count': data['venues'][0]['categoryCounts']['Friends'] as int ?? 0},
            {'label': 'Networking', 'count': data['venues'][0]['categoryCounts']['Networking'] ?? 0},
            {'label': 'Dates', 'count': data['venues'][0]['categoryCounts']['Dates'] ?? 0},
            {'label': 'Food', 'count': data['venues'][0]['categoryCounts']['Food'] ?? 0},
            {'label': 'Parties', 'count': data['venues'][0]['categoryCounts']['Parties'] ?? 0},
            {'label': 'Events', 'count': data['venues'][0]['categoryCounts']['Events'] ?? 0},
            {'label': 'Drinks', 'count': data['venues'][0]['categoryCounts']['Drinks'] ?? 0},
          ]);
        }
      } else {
        print('Failed to load venue details');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
