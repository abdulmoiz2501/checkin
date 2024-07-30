//
//
// import 'package:checkin/widgets/progress_indicator.dart';
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import '../controllers/venue_controller.dart';
// import '../controllers/venue_singular_marker_controller.dart';
//
// class SingularMapWidget extends StatefulWidget {
//   final LatLng venueLocation;
//   final String venueTitle;
//   final String placeId;
//
//   SingularMapWidget({required this.venueLocation, required this.venueTitle, required this.placeId});
//
//   @override
//   _SingularMapWidgetState createState() => _SingularMapWidgetState();
// }
//
// class _SingularMapWidgetState extends State<SingularMapWidget> {
//   late GoogleMapController _controller;
//   LatLng? _initialPosition;
//   Set<Marker> _markers = {};
//   Circle? _userCircle;
//   double _currentZoomLevel = 16.5;
//   BitmapDescriptor? markerIcon;
//   BitmapDescriptor? markerDefaultIcon;
//   BitmapDescriptor? marker1to10Icon;
//   BitmapDescriptor? marker10plusIcon;
//   BitmapDescriptor? marker100plusIcon;// Variable to hold custom marker icon
//
//   final VenueSingularMarkerController venueSingularMarkerController = Get.put(VenueSingularMarkerController());
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _initializeData();
//     });
//   }
//
//   // Function to initialize data and set up the map
//   Future<void> _initializeData() async {
//    // await _loadCustomIcon(); // Load custom icon
//     LatLng userLocation = await _getUserLocation(); // Get user's current location
//     setState(() async {
//       _initialPosition = userLocation; // Set initial position to user's location
//       // Circle
//       _userCircle = Circle(
//         circleId: CircleId('user_radius'),
//         center: userLocation,
//         radius: 250,
//         fillColor: Colors.orange.withOpacity(0.2),
//         strokeColor: Colors.white,
//         strokeWidth: 1,
//
//       );
//       // Add a marker for the selected venue
//       await venueSingularMarkerController.fetchCheckInData(widget.placeId);
//       _updateMarker();
//       /*_markers.add(Marker(
//         markerId: MarkerId('selected_venue'),
//         position: widget.venueLocation,
//         infoWindow: InfoWindow(title: widget.venueTitle),
//         icon: markerIcon ?? BitmapDescriptor.defaultMarker, // Use custom marker icon if available
//       ));*/
//     });
//   }
//
//   // Function to load custom marker icon
//   Future<void> _loadCustomIcons() async {
//     markerDefaultIcon = await BitmapDescriptor.fromAssetImage(
//       ImageConfiguration(devicePixelRatio: 2.5),
//       'assets/marker.png',
//     );
//     marker1to10Icon = await BitmapDescriptor.fromAssetImage(
//       ImageConfiguration(devicePixelRatio: 2.5),
//       'assets/marker1-10.png',
//     );
//     marker10plusIcon = await BitmapDescriptor.fromAssetImage(
//       ImageConfiguration(devicePixelRatio: 2.5),
//       'assets/marker10+.png',
//     );
//     marker100plusIcon = await BitmapDescriptor.fromAssetImage(
//       ImageConfiguration(devicePixelRatio: 2.5),
//       'assets/marker100+.png',
//     );
//   }
//
//   /*Future<void> _loadCustomIcon() async {
//     markerIcon = await BitmapDescriptor.fromAssetImage(
//       ImageConfiguration(devicePixelRatio: 2.5),
//       'assets/marker_23.png', // Path to custom marker icon
//     );
//   }*/
//
//   void _updateMarker() {
//     // Ensure all icons are loaded before proceeding
//     if (markerDefaultIcon == null ||
//         marker1to10Icon == null ||
//         marker10plusIcon == null ||
//         marker100plusIcon == null) {
//       return;
//     }
//
//     BitmapDescriptor icon;
//     int totalCheckIns = venueSingularMarkerController.totalCheckIns.value;
//
//     if (totalCheckIns > 100) {
//       icon = marker100plusIcon!;
//     } else if (totalCheckIns > 10) {
//       icon = marker10plusIcon!;
//     } else if (totalCheckIns > 0) {
//       icon = marker1to10Icon!;
//     } else {
//       icon = markerDefaultIcon!;
//     }
//
//     setState(() {
//       _markers.clear();
//       _markers.add(Marker(
//         markerId: MarkerId('selected_venue'),
//         position: widget.venueLocation,
//         infoWindow: InfoWindow(title: widget.venueTitle),
//         icon: icon,
//       ));
//     });
//   }
//
//   // Function to get user's current location
//   Future<LatLng> _getUserLocation() async {
//     Position position = await _getCurrentLocation();
//     return LatLng(position.latitude, position.longitude);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: MediaQuery.of(context).size.height * 0.3, // Set the height of the map widget
//       child: _initialPosition == null
//           ? Center(child: CustomCircularProgressIndicator()) // Show loading indicator if initial position is null
//           : GoogleMap(
//         initialCameraPosition: CameraPosition(
//           target: _initialPosition!,
//           zoom: _currentZoomLevel,
//         ),
//         onMapCreated: (GoogleMapController controller) {
//           _controller = controller;
//         },
//         onCameraMove: (CameraPosition position) {
//           setState(() {
//             _currentZoomLevel = position.zoom;
//           });
//         },
//         markers: _markers,
//         circles: _userCircle != null ? {_userCircle!} : {},
//         myLocationEnabled: false,
//         myLocationButtonEnabled: false,
//         zoomControlsEnabled: false,
//       ),
//     );
//   }
//
//   // Function to get current location with permissions handling
//   Future<Position> _getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       return Future.error('Location services are disabled.');
//     }
//
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       return Future.error('Location permissions are permanently denied, we cannot request permissions.');
//     }
//
//     return await Geolocator.getCurrentPosition();
//   }
// }

import 'package:checkin/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../controllers/venue_singular_marker_controller.dart';

class SingularMapWidget extends StatefulWidget {
  final LatLng venueLocation;
  final String venueTitle;
  final String placeId; // Add placeId to the widget

  SingularMapWidget({required this.venueLocation, required this.venueTitle, required this.placeId});

  @override
  _SingularMapWidgetState createState() => _SingularMapWidgetState();
}

class _SingularMapWidgetState extends State<SingularMapWidget> {
  late GoogleMapController _controller;
  LatLng? _initialPosition;
  Set<Marker> _markers = {};
  Circle? _userCircle;
  double _currentZoomLevel = 16.5;
  BitmapDescriptor? markerDefaultIcon;
  BitmapDescriptor? marker1to10Icon;
  BitmapDescriptor? marker10plusIcon;
  BitmapDescriptor? marker100plusIcon;

  final VenueSingularMarkerController venueSingularMarkerController = Get.put(VenueSingularMarkerController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeData();
    });
  }

  Future<void> _initializeData() async {
    await _loadCustomIcons();
    LatLng userLocation = await _getUserLocation();
    _setInitialData(userLocation);
    await venueSingularMarkerController.fetchCheckInData(widget.placeId);
    _updateMarker();
  }

  void _setInitialData(LatLng userLocation) {
    setState(() {
      _initialPosition = userLocation;
      _userCircle = Circle(
        circleId: CircleId('user_radius'),
        center: userLocation,
        radius: 250,
        fillColor: Colors.orange.withOpacity(0.2),
        strokeColor: Colors.white,
        strokeWidth: 1,
      );
    });
  }

  Future<void> _loadCustomIcons() async {
    markerDefaultIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/marker.png',
    );
    marker1to10Icon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/marker1-10.png',
    );
    marker10plusIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/marker10+.png',
    );
    marker100plusIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/marker100+.png',
    );
  }

  void _updateMarker() {
    // Ensure all icons are loaded before proceeding
    if (markerDefaultIcon == null ||
        marker1to10Icon == null ||
        marker10plusIcon == null ||
        marker100plusIcon == null) {
      return;
    }

    BitmapDescriptor icon;
    int totalCheckIns = venueSingularMarkerController.totalCheckIns.value;

    if (totalCheckIns > 100) {
      icon = marker100plusIcon!;
    } else if (totalCheckIns > 10) {
      icon = marker10plusIcon!;
    } else if (totalCheckIns > 0) {
      icon = marker1to10Icon!;
    } else {
      icon = markerDefaultIcon!;
    }

    setState(() {
      _markers.clear();
      _markers.add(Marker(
        markerId: MarkerId('selected_venue'),
        position: widget.venueLocation,
        infoWindow: InfoWindow(title: widget.venueTitle),
        icon: icon,
      ));
    });
  }

  Future<LatLng> _getUserLocation() async {
    Position position = await _getCurrentLocation();
    return LatLng(position.latitude, position.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      child: _initialPosition == null
          ? Center(child: CustomCircularProgressIndicator())
          : GoogleMap(
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
        myLocationEnabled: false,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
      ),
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
