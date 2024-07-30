import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController {
  var userLocation = Rxn<LatLng>();

  void setUserLocation(Position position) {
    userLocation.value = LatLng(position.latitude, position.longitude);
  }
}
