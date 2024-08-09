import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import '../models/venue_model.dart';
import '../services/places_service.dart';

class VenueController extends GetxController {
  var isLoading = true.obs;
  var venues = <Venue>[].obs;
  final PlacesService _placesService = PlacesService();

  @override
  void onInit() {
    super.onInit();
    //  default
    fetchNearbyVenues('restaurant');
  }

  Future <void>  fetchNearbyVenues(String type) async {
    isLoading(true); // Set loading state to true
    print('Fetching nearby venues of type: $type...');
    try {
      // Get the current user location
      Position position = await _determinePosition();
      print('User location: ${position.latitude}, ${position.longitude}');
      // Fetch nearby venues using the PlacesService


      List<Venue> nearbyVenues = [];
      if (type == 'all') {
        // Fetch multiple venue types
        List<String> types = ['bar', 'cafe', 'gym', 'museum', 'restaurant'];
        for (var venueType in types) {
          var venues = await _placesService.getNearbyVenues(position, venueType);
          nearbyVenues.addAll(venues);
        }
      } else {
        // Fetch nearby venues of a single type
        nearbyVenues = await _placesService.getNearbyVenues(position, type);
      }
     // var nearbyVenues = await _placesService.getNearbyVenues(position, type);
      // Update the venues list with the fetched data
      venues.assignAll(nearbyVenues);
      print('Fetched ${nearbyVenues.length} venues');

      // Print all opening and closing times
      for (var venue in nearbyVenues) {
        print('Venue: ${venue.name}');
      }
    } catch (e) {
      print('Error fetching venues: $e');
    } finally {
      isLoading(false); // Set loading state to false
    }
  }


  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Check for location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // Return the current position
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
  List<String> getVenueImagesByPlaceId(String placeId) {
    final venue = venues.firstWhere((venue) => venue.placeId == placeId, orElse: () => Venue(
      name: '',
      address: '',
      openNow: false,
      placeId: '',
      openingTimes: [],
      closingTimes: [],
      latitude: 0.0,
      longitude: 0.0,
      imageUrls: [],
    ));
    return venue.imageUrls;
  }
}


