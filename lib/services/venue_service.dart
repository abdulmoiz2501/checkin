//
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// import '../models/venue_model.dart';
//
// class VenueService {
//   static const String url = 'https://check-in-production-b9fd.up.railway.app/api/v1/venue/GetVenue';
//
//   static Future<List<Venue>?> fetchVenues() async {   ///Map of string dynamic.
//     final response = await http.get(Uri.parse(url));
//
//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse.map((venue) => Venue.fromJson(venue)).toList();
//     } else {
//       print('Error fetching venues: ${response.statusCode}');
//       print('Response: ${response.body}');
//       return null;
//     }
//   }
// }
