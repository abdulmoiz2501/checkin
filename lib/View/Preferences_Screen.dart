import 'package:checkin/controllers/check_in_controller.dart';
import 'package:checkin/controllers/venue_refresh_controller.dart';
import 'package:checkin/widgets/multiple_Selectable_Buttons.dart';
import 'package:checkin/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:intl/intl.dart';
import '../constants/colors.dart';
import '../widgets/selectable_button.dart';

class PreferencesScreen extends StatelessWidget {
  final RxString selectedOption = ''.obs;
  final RxDouble minAge = 26.0.obs;
  final RxDouble maxAge = 70.0.obs;
  final RxBool showPeopleOutOfRange = false.obs;
  final VenueRefreshController venueRefreshController =
      Get.find<VenueRefreshController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SizedBox(
            width: 20,
            height: 20,
            child: Image.asset('assets/back_arrow.png'),
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Preferences',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Checkin Goals',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Let us know your intentions here. Your response will guide us in tailoring better recommendations for you.',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                fontSize: 14,
                color: Color(0xFF7A7D81),
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 7.0),
              child: Obx(
                () => MultipleSelectableButtons(
                  options: [
                    'Friends',
                    'Networking',
                    'Dates',
                    'Casual',
                    'Love',
                    'Food',
                    'Explore city',
                    'Parties',
                    'Pub crawls',
                    'Drinking buddies'
                  ],
                  initialSelected: venueRefreshController.checkinGoals.toList(),
                  onSelected: (selectedGoals) {
                    venueRefreshController.checkinGoals.value = selectedGoals;
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Age range',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.0),
            Obx(
              () => Stack(
                alignment: Alignment.center,
                children: [
                  SfRangeSlider(
                    min: 18.0,
                    max: 100.0,
                    values: SfRangeValues(
                      venueRefreshController.minAge.value,
                      venueRefreshController.maxAge.value,
                    ),
                    interval: 10,
                    showTicks: false,
                    showLabels: false,
                    enableTooltip: false,
                    activeColor: Color(0xFFFF7043),
                    inactiveColor: Color(0xFFEEEEEE),
                    numberFormat: NumberFormat('##'),
                    onChanged: (SfRangeValues values) {
                      venueRefreshController.minAge.value = values.start;
                      venueRefreshController.maxAge.value = values.end;
                    },
                    tooltipTextFormatterCallback: (actualValue, formattedText) {
                      return actualValue
                          .toInt()
                          .toString(); // Format the tooltip to show only integer values
                    }, // Custom thumb shape
                  ),
                  Align(
                    alignment: Alignment(
                      (2 *
                              ((venueRefreshController.minAge.value - 18) /
                                  (100 - 18)) -
                          0.978),
                      -1.5,
                    ),
                    child: Container(
                      transform: Matrix4.translationValues(0, -20, 0),
                      child: Text(
                        venueRefreshController.minAge.value.toInt().toString(),
                        style: TextStyle(
                          fontFamily: 'SFProDisplay',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(
                      (2 *
                              ((venueRefreshController.maxAge.value - 18) /
                                  (100 - 18)) -
                          1.04),
                      -12,
                    ),
                    child: Container(
                      transform: Matrix4.translationValues(0, -20, 0),
                      child: Text(
                        venueRefreshController.maxAge.value.toInt().toString(),
                        style: TextStyle(
                          fontFamily: 'SFProDisplay',
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Text(
                    'Show people slightly out of my preferred range if there are no profiles to see.',
                    //overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      fontSize: 14,
                      color: Color(0xFF7A7D81),
                    ),
                  ),
                ),
                Obx(
                  () => Switch(
                    value: venueRefreshController.peopleOutsideRange.value,
                    onChanged: (value) {
                      venueRefreshController.peopleOutsideRange.value = value;
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Color(0xFFFF7043),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.22),
            //Spacer(),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  colors: [gradientLeft, gradientRight],
                ),
              ),
              child: Obx(
                () => ElevatedButton(
                  onPressed: () async {
                    print(venueRefreshController.checkinGoals);
                    if (venueRefreshController.isLoading.value == false) {
                      venueRefreshController.isFirstHitDone.value = true;
                      await venueRefreshController.fetchVenueData().whenComplete(
                            () => Get.back());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
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
                    child: venueRefreshController.isLoading.value
                        ? CustomCircularProgressIndicator()
                        : Container(
                            alignment: Alignment.center,
                            child: Text(
                              "Back ",
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
          ],
        ),
      ),
    );
  }
}
