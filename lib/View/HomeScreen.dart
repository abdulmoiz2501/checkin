import 'package:checkin/View/SubscriptionScreen.dart';
import 'package:checkin/constants/colors.dart';
import 'package:checkin/widgets/map_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controllers/venue_controller.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/snackbar.dart';
import '../widgets/horizontal_view_list.dart';
import '../widgets/selectable_button.dart';
import 'SafetyCenterScreen.dart';
import 'SettingsScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final VenueController venueController = Get.put(VenueController());
  String selectedOption = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showCustomSnackbar(context, Colors.black,
          'Select a venue to see more details and Checkin.');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Image.asset('assets/logo_appbar.png'),
          ),
        ),
        actions: [
          IconButton(
            icon: Image.asset('assets/venue_icon.png'),
            onPressed: () {
              Get.to(() => SafetyCenterScreen());
            },
          ),
          IconButton(
            icon: Image.asset('assets/setting_icon.png'),
            onPressed: () {
              Get.to(() => AccountSettingsScreen());
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.03),
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SelectableButtonGroup(
                options: [
                  'All',
                  'Bars',
                  'Cafe',
                  'Gym',
                  'Musueum',
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            //HorizontalListView(items: items),
            Obx(() {
              if (venueController.isLoading.value) {
                return Center(child: CustomCircularProgressIndicator());
              } else {
                List<Map<String, String?>> items = venueController.venues
                    .map((venue) => {
                          'image': venue.imageUrls.isNotEmpty
                              ? venue.imageUrls[0]
                              : null,
                          'title': venue.name,
                          'placeId': venue.placeId,
                        })
                    .toList();
                if (items.isEmpty) {
                  return Container(
                    padding: EdgeInsets.all(12.0),
                    margin:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'No venues nearby',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          'It seems there are no venues nearby. Please move to a different location to check into a venue.',
                          style: TextStyle(
                            fontFamily: 'SFProDisplay',
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return HorizontalListView(items: items);
                }
                //return HorizontalListView(items: items);
              }
            }),

            SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: MapWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
