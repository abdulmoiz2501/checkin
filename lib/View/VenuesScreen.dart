import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/selectable_button.dart';
import '../widgets/venue_tiles.dart';

class VenueScreen extends StatefulWidget {
  const VenueScreen({super.key});

  @override
  State<VenueScreen> createState() => _VenueScreenState();
}

class _VenueScreenState extends State<VenueScreen> {
  String selectedOption = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SizedBox(
            width: 20,
            height: 20,
            child: Image.asset('assets/back_arrow.png'), // Load your image
          ),
          onPressed: () {
            Get.back();
            print("Leading icon pressed");
          },
        ),
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
            SizedBox(width: 5), // Adjust the space between the text and the icon
            Image.asset(
              'assets/appBarIcon.png', // Replace with your asset path
              width: 20, // Adjust the size as needed
              height: 20, // Adjust the size as needed
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
            SizedBox(height:15),
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
            SizedBox(height:10),
            Expanded(
              child: ListView(
                children: [
                  VenueTile(
                    title: 'Marble Bar',
                    subtitle: 'Cocktail bar · Level b1/488 George St, Sydney NSW 2000',
                    openingTime: 'Open',
                    closingTime: 'Closes 1 am',
                  ),
                  VenueTile(
                    title: 'Art House Hotel',
                    subtitle: 'Cocktail bar · Level b1/488 George St, Sydney NSW 2000',
                    openingTime: 'Open',
                    closingTime: 'Closes 1 am',
                  ),
                  VenueTile(
                    title: 'Marble Bar',
                    subtitle: 'Cocktail bar · Level b1/488 George St, Sydney NSW 2000',
                    openingTime: 'Open',
                    closingTime: 'Closes 1 am',
                  ),
                  VenueTile(
                    title: 'Marble Bar',
                    subtitle: 'Cocktail bar · Level b1/488 George St, Sydney NSW 2000',
                    openingTime: 'Open',
                    closingTime: 'Closes 1 am',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
