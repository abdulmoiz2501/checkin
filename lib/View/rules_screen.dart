import 'package:checkin/View/HomeScreen.dart';
import 'package:checkin/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../widgets/bottom_bav_bar.dart';
import 'VenuesScreen.dart';

class RulesScreen extends StatelessWidget {
  const RulesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SizedBox(
            width: 20,
            height: 20,
            child: Image.asset('assets/back_arrow.png'), // Load your SVG image
          ),
          onPressed: () {
            ///TODO : Add the action when the leading icon is pressed
            //Get.back();
            print("Leading icon pressed");
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.053),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: 'Welcome to ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                children: [
                  TextSpan(
                    text: 'Checkin',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      foreground: Paint()
                        ..shader = LinearGradient(
                          colors: <Color>[gradientLeft, gradientRight],
                          stops: [0.0, 0.7], // Use the defined gradient colors
                        ).createShader(Rect.fromLTWH(200.0, 100.0, 150.0, 70.0)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Please follow some of the basic rules. Happy Checkin!',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  buildInfoCard(
                    title: 'Safety First',
                    description:
                        'Protect your personal information. Avoid sharing sensitive details like your address or financial information with anyone on the app.',
                  ),
                  buildInfoCard(
                    title: 'Respect Boundaries',
                    description:
                        'Always obtain consent before engaging in any form of communication or interaction. Respect the preferences and boundaries of others, and promptly report any inappropriate behaviour.',
                  ),
                  buildInfoCard(
                    title: 'Consent',
                    description:
                        'Being checked into a venue does not equal consent, as consent must be informed, freely given, and specific to each activity.',
                  ),
                  buildInfoCard(
                    title: 'Report Suspicious Activity',
                    description:
                        'If you encounter any suspicious profiles or behaviour, report using the apps report function immediately. Your vigilance helps maintain a safe and welcoming community for all users.',
                  ),
                  buildInfoCard(
                    title: 'Communicate Responsibly',
                    description:
                        'Choose your words thoughtfully and respectfully. Avoid harassment, discrimination, or any form of offensive language or behaviour.',
                  ),
                  buildInfoCard(
                    title: 'Meet Safely',
                    description:
                        'If you decide to meet someone in person, inform a friend or family member about your plans. Trust your instincts and prioritise your safety at all times.',
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.06,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: LinearGradient(
                    colors: [gradientLeft, gradientRight],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Action when Next button is pressed
                    Get.offAll(() => BottomNavigation());
                    print("Next pressed");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0, // Remove shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [gradientLeft, gradientRight],
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "I Agree",
                        style: TextStyle(
                          color: textInvertColor,
                          fontFamily: 'SFProDisplay',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget buildInfoCard({required String title, required String description}) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0,
      child: Container(
        color:  Color(0x4DEEEEEE),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 5),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: textBlackColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
