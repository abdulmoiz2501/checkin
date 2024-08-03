import 'package:checkin/widgets/progress_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../View/VenueSelectedScreen.dart';
import '../controllers/user_controller.dart';
import '../controllers/venue_controller.dart';
import '../controllers/venue_marker_controller.dart';

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController _controller;
  LatLng? _initialPosition;
  Set<Marker> _markers = {};

  BitmapDescriptor? markerDefaultIcon;
  BitmapDescriptor? marker1to10Icon;
  BitmapDescriptor? marker10plusIcon;
  BitmapDescriptor? marker100plusIcon;
  Circle? _userCircle;
  double _currentZoomLevel = 16.5;
  final VenueController venueController = Get.put(VenueController());
  final VenueMarkerController venueMarkerController = Get.put(VenueMarkerController());
  final UserController userController = Get.find();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  Future<void> _initializeData() async {
    String radius = '250'; // 500 meter km radius
    await userController.fetchUser(FirebaseAuth.instance.currentUser!.uid);
    if(userController.user.value.subscribed != false ){
      radius = '500';
    }
    await _loadCustomIcons();
    LatLng userLocation = await _getUserLocation();
    setState(() {
      _initialPosition = userLocation;
      _userCircle = Circle(
        circleId: CircleId('user_radius'),
        center: userLocation,
        radius: double.parse(radius),
        fillColor: Colors.orange.withOpacity(0.1),
        strokeColor: Colors.orange.withOpacity(0.5),
        strokeWidth: 1,
      );
    });
    await _fetchAndDisplayVenues(userLocation);
  }

  Future<void> _loadCustomIcons() async {

    markerDefaultIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 1.5, size: Size(10, 10)),
      'assets/marker.png',
    );
    marker1to10Icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 1.5, size: Size(10, 10)),
      'assets/marker1-10.png',
    );
    marker10plusIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 1.5, size: Size(10, 10)),
      'assets/marker10+.png',
    );
    marker100plusIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 1.5, size: Size(10, 10)),
      'assets/marker100.png',
    );
  }


  void _initializeMarkers(List<LatLng> positions, Map<String, int> placeIdToCheckInCount) {
    _markers.clear();
    for (int i = 0; i < positions.length; i++) {
      String placeId = venueController.venues[i].placeId;
      int checkInCount = placeIdToCheckInCount[placeId] ?? 0;
      BitmapDescriptor icon;

      if (checkInCount > 100) {
        icon = marker100plusIcon!;
      } else if (checkInCount > 10) {
        icon = marker10plusIcon!;
      } else if (checkInCount > 0) {
        icon = marker1to10Icon!;
      } else {
        icon = markerDefaultIcon!;
      }

      _markers.add(Marker(
        markerId: MarkerId('venue_$i'),
        position: positions[i],
        icon: icon,
        onTap: (){
          _onMarkerTapped(
            title: venueController.venues[i].name,
            subtitle: venueController.venues[i].address,
            openNow: venueController.venues[i].openNow,
            openingTime: venueController.venues[i].openingTimes[DateTime.now().weekday - 1],
            closingTime: venueController.venues[i].closingTimes[DateTime.now().weekday - 1],
            placeId: placeId,
          );
        }
      ));
    }
    setState(() {});
  }
  void _onMarkerTapped({
    required String title,
    required String subtitle,
    required bool openNow,
    required String openingTime,
    required String closingTime,
    required String placeId,
  }) {
    Get.to(() => VenueSelectedScreen(), arguments: {
      'title': title,
      'subtitle': subtitle,
      'openNow': openNow,
      'openingTime': openingTime,
      'closingTime': closingTime,
      'placeId': placeId,
    });
  }


  Future<void> _fetchAndDisplayVenues(LatLng userLocation) async {
    try {
      await venueController.fetchNearbyVenues('restaurant');
      List<String> placeIds = venueController.venues.map((venue) => venue.placeId).toList();
      await venueMarkerController.checkPlaceIds(placeIds);
      Map<String, int> placeIdToCheckInCount = { for (var venue in venueMarkerController.venues) venue.placeId: venue.totalCheckIns };
      List<LatLng> positions = venueController.venues.map((venue) => LatLng(venue.latitude, venue.longitude)).toList();
      _initializeMarkers(positions, placeIdToCheckInCount);
    } catch (e) {
      print('Error fetching venues: $e');
    }
  }

  Future<LatLng> _getUserLocation() async {
    Position position = await _getCurrentLocation();
    return LatLng(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return _initialPosition == null
        ? Center(child: CustomCircularProgressIndicator())
        : Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: _initialPosition!,
            zoom: _currentZoomLevel,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          onCameraMove: (CameraPosition position) {
            setState(() {
              _currentZoomLevel = position.zoom;
            });
          },
          markers: _markers,
          circles: _userCircle != null ? {_userCircle!} : {},
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          compassEnabled: false,
          mapToolbarEnabled: false,
          minMaxZoomPreference: MinMaxZoomPreference(16, null),
         // minMaxZoomPreference: MinMaxZoomPreference(1, 10),
         // minMaxZoomPreference: MinMaxZoomPreference(10, 11),
        ),
      ],
    );
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

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

    return await Geolocator.getCurrentPosition();
  }
}
