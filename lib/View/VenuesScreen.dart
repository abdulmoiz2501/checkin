import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/venue_controller.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/selectable_button.dart';
import '../widgets/venue_tiles.dart';


class VenueScreen extends StatefulWidget {
  const VenueScreen({super.key});

  @override
  State<VenueScreen> createState() => _VenueScreenState();
}

class _VenueScreenState extends State<VenueScreen> {
  final VenueController venueController = Get.put(VenueController());
  //String selectedOption = '';
  String selectedOption = 'restaurant';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // This removes the default back button
        backgroundColor: Colors.white, // Set the background color as needed
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Nearby Venues',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontFamily: 'SFProDisplay',
              ),
            ),
            SizedBox(width: 5),
            Image.asset(
              'assets/appBarIcon.png',
              width: 20,
              height: 20,
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.023),
        child: Column(
          children: [
            SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SelectableButtonGroup(
                options: [
                  'All',
                  'Bars',
                  'Cafe',
                  'Gym',
                  'Museum',
                  'Restaurants',
                ],
                initialSelected: selectedOption,
                onSelected: (value) {
                  setState(() {
                    selectedOption = value.toLowerCase();
                    String apiType;
                    if(selectedOption == 'all')
                      {
                        apiType  = 'all';
                      }
                    else{
                      switch (selectedOption) {
                        case 'bars':
                          apiType = 'bar';
                          break;
                        case 'cafe':
                          apiType = 'cafe';
                          break;
                        case 'gym':
                          apiType = 'gym';
                          break;
                        case 'museum':
                          apiType = 'museum';
                          break;
                        case 'clubs':
                          apiType = 'night_club';
                          break;
                        case 'restaurants':
                        default:
                          apiType = 'restaurant';
                          break;
                      }
                    }
                    venueController.fetchNearbyVenues(apiType);
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                print('Loading state: ${venueController.isLoading.value}');
                if (venueController.isLoading.value) {
                  return Center(child: CustomCircularProgressIndicator());
                } else {
                  print('Loaded ${venueController.venues.length} venues');
                  return ListView.builder(
                    itemCount: venueController.venues.length,
                    itemBuilder: (context, index) {
                      print('This is the length of the venues: ${venueController.venues.length} ');
                      var venue = venueController.venues[index];
                      final today = DateTime.now().weekday - 1;
                      return VenueTile(
                        placeId: venue.placeId,
                        title: venue.name,
                        subtitle: venue.address,
                        openNow: venue.openNow,
                        openingTime: venue.openingTimes[today],
                        closingTime: venue.closingTimes[today],
                        imageUrl: venue.imageUrls.isNotEmpty?venue.imageUrls.first : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQsairhVA5q080vP7Niigy3bMCnGZNdzNCN4w&s',
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
