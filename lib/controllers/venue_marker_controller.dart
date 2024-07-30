import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/venue_marker_model.dart';

class VenueMarkerController extends GetxController {
  var isLoading = true.obs;
  var venues = <VenueMarker>[].obs;

  Future<void> checkPlaceIds(List<String> placeIds) async {
    isLoading(true);
    final url = Uri.parse(
        'https://check-in-apis-e4xj.vercel.app/api/v1/venues/getVenues?placeid=${placeIds.join(",")}');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == true) {
          venues.assignAll(
            (data['venues'] as List).map((venue) => VenueMarker.fromJson(venue)).toList(),
          );
        } else {
          venues.clear();
        }
      } else {
        print('Failed to load place IDs from API');
        venues.clear();
      }
    } catch (e) {
      print('Error: $e');
      venues.clear();
    } finally {
      isLoading(false);
    }
  }
}