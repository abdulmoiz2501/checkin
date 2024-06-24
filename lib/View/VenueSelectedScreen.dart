import 'package:checkin/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'SelectInterestScreen.dart';

class VenueSelectedScreen extends StatelessWidget {
  const VenueSelectedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map background
          Positioned.fill(
            child: Image.asset(
              'assets/venue_selected.png', // Replace with your map appi implementat
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 16,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF21262D),
              ),
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Get.back();
                },
              ),
            ),
          ),

          // Foreground content
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Forrester's Pub",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SFProDisplay',
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => SelectInterestScreen());
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30), // Increase border radius for more rounded corners
                            ),
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            shadowColor: Colors.transparent,
                          ),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [gradientLeft, gradientRight],
                              ),
                              borderRadius: BorderRadius.circular(
                                  30), // Match border radius with button
                            ),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                  vertical:
                                      12.0), // Adjust padding for bigger button
                              constraints: BoxConstraints(
                                  minWidth: 100.0,
                                  minHeight:
                                      48.0), // Adjust constraints for bigger button
                              alignment:
                                  Alignment.center, // Center align the content
                              child: Row(
                                mainAxisSize: MainAxisSize
                                    .min, // Adjust size based on content
                                children: [
                                  Text(
                                    "Checkin",
                                    style: TextStyle(
                                      fontSize:
                                          14, // Adjust font size if needed
                                      fontFamily: 'SFProDisplay',
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                      width: 8), // Adjust the spacing as needed
                                  Image.asset(
                                    'assets/checkin_icon.png',
                                    width: 24,
                                    height: 24,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        SizedBox(width: 2),
                        Text(
                          "Pub · 12 Riley St, Surry Hills",
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'SFProDisplay',
                            color: Color(0xFF7A7D81),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text("Open",
                            style: TextStyle(
                                color: Colors.green,
                                fontFamily: 'SFProDisplay',
                                fontWeight: FontWeight.bold)),
                        Text(" · Closes 1 am",
                            style: TextStyle(fontFamily: 'SFProDisplay')),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 4,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            "LIVE",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'SFProDisplay',
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        RichText(
                          text: TextSpan(
                            style: TextStyle(
                              fontFamily: 'SFProDisplay',
                              color: Color(0xFF7A7D81),
                            ),
                            children: [
                              TextSpan(
                                text: '30 people',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: ' currently checked in  ',
                              ),

                              WidgetSpan(child: ImageIcon(
                                AssetImage('assets/home_selected.png'),
                                size: 18,
                                color: gradientRight,
                              ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      "What are people looking for here?",
                      style: TextStyle(fontFamily: 'SFProDisplay'),
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildInterestCount("Dates", 8),
                        _buildInterestCount("Friends", 12),
                        _buildInterestCount("Drinks", 10),
                        _buildInterestCount("Food", 3),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text("Forrester's",
                        style: TextStyle(
                            fontFamily: 'SFProDisplay',
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    /*Row(
                      children: [
                        //Image.asset('assets/image1.png'),
                        _buildImageThumbnail(
                            'assets/image1.png'),
                        SizedBox(width: 8),
                        _buildImageThumbnail(
                            'assets/image2.png'),
                        SizedBox(width: 8),
                        _buildImageThumbnail(
                            'assets/image3.png'),
                      ],
                    ),*/
                    Row(
                      children: [
                        // First image taking half of the row
                        Expanded(
                          flex: 1,
                          child: _buildImageThumbnail('assets/image4.png'),
                        ),
                        SizedBox(width: 8),
                        // Column containing the second and third images
                        /*Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Expanded(
                                child:
                                    _buildImageThumbnail('assets/image2.png'),
                              ),
                              SizedBox(height: 8),
                              Expanded(
                                child:
                                    _buildImageThumbnail('assets/image3.png'),
                              ),
                            ],
                          ),
                        ),*/
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestCount(String label, int count) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [gradientLeft, gradientRight],
            tileMode: TileMode.mirror,
          ).createShader(bounds),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              fontFamily: 'SFProDisplay',
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 4),
        Text(
          '$count people',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.normal,
            fontFamily: 'SFProDisplay',
            color: Colors.black,
          ),
        ),
      ],
    );
  }


  Widget _buildImageThumbnail(String assetPath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        assetPath,
        fit: BoxFit.cover,
      ),
    );
  }
}
