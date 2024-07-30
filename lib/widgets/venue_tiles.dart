import 'package:checkin/controllers/check_in_controller.dart';
import 'package:checkin/widgets/venue_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../View/VenueSelectedScreen.dart';
import '../constants/colors.dart';

class VenueTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool openNow;
  final String openingTime;
  final String closingTime;
  final String placeId;
  final String imageUrl;

  VenueTile({
    required this.title,
    required this.subtitle,
    required this.openNow,
    required this.openingTime,
    required this.closingTime,
    required this.placeId,
    required this.imageUrl,
  });

  String formatTime(String time) {
    if (time.isEmpty) return 'Time is empty';

    int hour = int.parse(time.substring(0, 2));
    int minute = int.parse(time.substring(2, 4));
    String period = hour >= 12 ? 'PM' : 'AM';

    if (hour > 12) hour -= 12;
    if (hour == 0) hour = 12;

    return '$hour:${minute.toString().padLeft(2, '0')} $period';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 0.0),
      padding: EdgeInsets.all(0.0),
      child: Column(
        children: [
          Card(
            margin: EdgeInsets.all(0.0),
            elevation: 0.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
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
                          fontFamily: 'SFProDisplay',
                        ),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            openNow ? 'Open' : 'Closed',
                            style: TextStyle(color: openNow ? Colors.green : Colors.red, fontFamily: 'SFProDisplay', fontWeight: FontWeight.bold),
                          ),
                          /*Text(

                            openingTime,
                            style: TextStyle(color: Colors.green, fontFamily: 'SFProDisplay'),
                          ),*/
                          SizedBox(width: 5),
                          //Text('·'),
                          SizedBox(width: 5),
                          //Text(closingTime),
                          /*Text(
                            openNow
                                ? 'Closes at ${formatTime(closingTime)}'
                                : 'Opens at ${formatTime(openingTime)}',
                            style: TextStyle(color: Colors.grey, fontFamily: 'SFProDisplay'),
                          ),*/
                          ///Todo
                          //Text(placeId),
                        ],
                      ),
                      SizedBox(height: 8),
                      GradientButtonWithIcon(
                        text: 'Show on map',
                        assetPath: 'assets/location.png',
                        leftGradient: gradientLeft,
                        rightGradient: gradientRight,
                        onPressed: () {
                          print('Show on Map clicked for placeId: $placeId');
                          print('Navigating to VenueSelectedScreen');
                          final controller = Get.put<CheckInController>(CheckInController(), permanent: true);
                          controller.venueImage.value = imageUrl;

                          Get.to(() => VenueSelectedScreen(),
                          arguments: {
                            'title': title,
                            'subtitle': subtitle,
                            'openNow': openNow,
                            'openingTime': openingTime,
                            'closingTime': closingTime,
                            'placeId': placeId,
                            'images': imageUrl,

                          },
                          );
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
            color: Colors.grey.shade200,
            thickness: 1.0,
            height: 1.0,
          ),
        ],
      ),
    );
  }
}
