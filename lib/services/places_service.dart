import 'dart:convert';
import 'package:checkin/controllers/user_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import '../models/venue_model.dart';

class PlacesService {
  final String apiKey = 'AIzaSyCRxb4QueUWp9LKMm9QdMLr8_RZf7i3ExM';
final UserController userController = Get.find();

  Future<List<Venue>> getNearbyVenues(Position position, String type) async {
    String radius = '100'; // 500 meter km radius
    await userController.fetchUser(FirebaseAuth.instance.currentUser!.uid);
    if(userController.user.value.subscribed != false ){
  radius = '250';
    }
    final url = Uri.parse(
      'https://maps.googleapis.com/maps/api/place/nearbysearch/json'
          '?location=${position.latitude},${position.longitude}'
          '&radius=$radius' // 500 meter km radius
          '&type=$type'
          '&key=$apiKey',
    );

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List results = data['results'];
      print('API call success: Fetched ${results.length} places');
      //print('')

      List<Venue> venues = [];
      for (var place in results) {
        List<String> imageUrls = [];
        if (place['photos'] != null && place['photos'].isNotEmpty) {
          for (var photo in place['photos']) {
            String imageUrl = getPhotoUrl(photo['photo_reference']);
            //images.add(getPhotoUrl(photo['photo_reference']));
            imageUrls.add(imageUrl);
            if (imageUrls.length == 3) break; // Limit to 3 images
          }
        }


        // Debugging: Print the place data to ensure we are receiving the expected structure
        print('Place: ${place['name']}');
        if (place['opening_hours'] != null) {
          print('Opening hours: ${place['opening_hours']}');
          print('imageUrls: $imageUrls');
        } else {
          print('No opening hours data available for ${place['name']}');
        }

        if (place['opening_hours'] != null && place['opening_hours']['periods'] != null) {
          print('Opening hours for ${place['name']}:');
          for (var period in place['opening_hours']['periods']) {
            int day = period['open']['day'];
            String openTime = period['open']['time'] ?? '0000';
            String closeTime = period['close'] != null ? period['close']['time'] : '';
            print('Day $day: Open at $openTime, Close at $closeTime');
          }
        }
        venues.add(Venue.fromJson(place, imageUrls));
      }
      return venues;
    } else {
      print('API call failed: ${response.statusCode}');
      throw Exception('Failed to load places');
    }
  }

  String getPhotoUrl(String photoReference) {
    return 'https://maps.googleapis.com/maps/api/place/photo'
        '?maxwidth=400'
        '&photoreference=$photoReference'
        '&key=$apiKey';
  }
}
