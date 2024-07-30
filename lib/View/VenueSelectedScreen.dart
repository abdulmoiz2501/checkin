import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../constants/colors.dart';
import '../controllers/venue_controller.dart';
import '../controllers/venue_details_controller.dart';
import '../models/venue_model.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/singular_map_widget.dart';
import 'SelectInterestScreen.dart';

class VenueSelectedScreen extends StatelessWidget {
  const VenueSelectedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> venue = Get.arguments;
    final String title = venue['title'];
    final String subtitle = venue['subtitle'];
    final bool openNow = venue['openNow'];
    final String placeId = venue['placeId'];
    //final String imageUrl = venue['images'!];

    final VenueController venueController = Get.find();
    final VenueDetailsController venueDetailsController = Get.put(VenueDetailsController());

    final Venue selectedVenue = venueController.venues.value.firstWhere((v) => v.placeId == placeId);
    //print(imageUrl);
    venueDetailsController.fetchVenueDetails(placeId);

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.68,
                child: SingularMapWidget(
                  venueLocation: LatLng(selectedVenue.latitude, selectedVenue.longitude),
                  venueTitle: title, placeId: placeId,
                ),
              ),
              Expanded(
                child: Obx((){
                  if(venueDetailsController.isLoading.value){
                    return Center(child: CustomCircularProgressIndicator());
                  }else{
                    final interests = venueDetailsController.interests.where((interest) => interest['count'] > 0).toList();
                    final totalPeopleCheckedIn = venueDetailsController.totalPeopleCheckedIn.value;


                    return Container(
                        decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  ),
                  ), child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.6,
                                  child: Text(
                                    title,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'SFProDisplay',
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Get.to(() => SelectInterestScreen(), arguments: {
                                      'placeId': placeId,
                                      'title': title,
                                      'subtitle': subtitle,
                                      'openNow': openNow
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
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
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 24.0, vertical: 12.0),
                                      constraints: BoxConstraints(
                                          minWidth: 100.0, minHeight: 48.0),
                                      alignment: Alignment.center,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            "Checkin",
                                            style: TextStyle(
                                              fontSize: 14, // Adjust font size if needed
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
                                Flexible(
                                  child: Text(
                                    subtitle,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'SFProDisplay',
                                      color: Color(0xFF7A7D81),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  openNow ? "Open" : "Closed",
                                  style: TextStyle(
                                      color: openNow ? Colors.green : Colors.red,
                                      fontFamily: 'SFProDisplay',
                                      fontWeight: FontWeight.bold),
                                ),
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
                                        text: '$totalPeopleCheckedIn people',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' currently checked in  ',
                                      ),
                                      WidgetSpan(
                                        child: ImageIcon(
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
                            if (interests.isEmpty)
                              Text(
                                "No people are currently checked in.",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'SFProDisplay',
                                ),
                              )
                            else
                            Container(
                              height: 50,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: interests.map((interest) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: _buildInterestCount(interest['label'] as String, interest['count'] as int),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                            SizedBox(height: 26),
                          ],
                        ),
                      ),
                    ),
                    );
                  }
                }),
              ),
            ],
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
        ],
      ),
    );
  }

  Widget _buildInterestCount(String label, int count) {
    return Row(
      children: [
        Container(
          height: 40,  // Adjust the height as needed
          width: 2,  // Adjust the thickness of the divider
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [gradientLeft, gradientRight],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        SizedBox(width: 10),  // Spacing after the divider, adjust as needed
        Column(
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
                  color: Colors.white,  // This color is actually overridden by the shader.
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
        ),
      ],
    );
  }



/*  Widget _buildImageThumbnail(String? imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: imageUrl != null
          ? Image.network(
        imageUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          color: Colors.grey,
          child: Center(
            child: Icon(Icons.image_not_supported, color: Colors.white),
          ),
        ),
      )
          : Container(
        color: Colors.grey,
        child: Center(
          child: Icon(Icons.image_not_supported, color: Colors.white),
        ),
      ),
    );
  }*/
}
