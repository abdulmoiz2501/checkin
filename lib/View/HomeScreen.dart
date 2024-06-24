import 'package:checkin/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/snackbar.dart';
import '../widgets/horizontal_view_list.dart';
import '../widgets/selectable_button.dart';
import 'VenueSelectedScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> items = [
    {'image': 'assets/forresters.png', 'title': "Forrester's"},
    {'image': 'assets/dolphin_hotel.png', 'title': 'The dolphin hotel'},
    {'image': 'assets/the_clock.png', 'title': 'The Clock'},
    {'image': 'assets/gin_lab.png', 'title': 'Four pillars gin lab.'},
    {'image': 'assets/bar_conte.png', 'title': 'Bar Conte'},
  ];
  String selectedOption = '';
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
              // Handle venue button press
            },
          ),
          IconButton(
            icon: Image.asset('assets/setting_icon.png'),
            onPressed: () {
              // Handle settings button press
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
                  'Bars',
                  'Cafe',
                  'Gym',
                  'Mueseum',
                  'Restaurants',
                ],
                initialSelected: selectedOption,
                onSelected: (value) {
                  setState(() {
                    selectedOption = value;
                  });
                },
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.025),
            HorizontalListView(items: items),
            Expanded(
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => VenueSelectedScreen());
                  },
                  child: Image.asset('assets/map_placeholder.png',
                  fit: BoxFit.cover,
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCustomSnackbar(context, Colors.black,
              'Select a venue to see more details and Checkin.');
        },
        child: Icon(Icons.info),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
