import 'package:checkin/constants/colors.dart';
import 'package:checkin/widgets/venue_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../View/SelectInterestScreen.dart';

class VenueTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String openingTime;
  final String closingTime;

  VenueTile({
    required this.title,
    required this.subtitle,
    required this.openingTime,
    required this.closingTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.0), // Ensure no horizontal margins
      padding: EdgeInsets.all(0.0),
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(0.0), // Remove card margin
            elevation: 0.0, // Remove card elevation
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0), // Adjust as needed
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust horizontal padding
                  tileColor: Colors.white,
                  title: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SFProDisplay',
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            openingTime,
                            style: TextStyle(color: Colors.green),
                          ),
                          SizedBox(width: 5),
                          Text('·'),
                          SizedBox(width: 5),
                          Text(closingTime),
                        ],
                      ),
                      SizedBox(height: 8),
                      GradientButtonWithIcon(
                        text: 'Show on map',
                        assetPath: 'assets/location.png', // Replace with your asset path
                        leftGradient: gradientLeft,
                        rightGradient: gradientRight,
                        onPressed: () {
                          Get.to(() => SelectInterestScreen());
                          //print('Show on map pressed');
                        },
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.grey.shade200, // Set the color of the divider
            thickness: 1.0, // Set the thickness of the divider
            height: 1.0, // Set the height of the divider
          ),
        ],
      ),
    );
  }
}
