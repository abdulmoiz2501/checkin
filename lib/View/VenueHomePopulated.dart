import 'package:checkin/View/NewConnection.dart';
import 'package:checkin/View/SubscriptionScreen.dart';
import 'package:checkin/utils/device/device.dart';
import 'package:checkin/widgets/horizontal_view_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../constants/colors.dart';
import '../controllers/block_user_controller.dart';
import '../controllers/check_in_controller.dart';
import '../controllers/check_out_controller.dart';
import '../controllers/send_request_controller.dart';
import '../controllers/venue_refresh_controller.dart';
import '../models/block_user_model.dart';
import '../models/check_out_model.dart';
import '../models/send_request_model.dart';
import '../widgets/custom_pop_up.dart';
import '../widgets/profile_card.dart';
import 'Preferences_Screen.dart';

class VenueHomePopulated extends StatelessWidget {
  const VenueHomePopulated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CheckInController checkInController = Get.find();
    final CheckOutController checkOutController = Get.put(CheckOutController());
    final SendRequestController sendRequestController =
        Get.put(SendRequestController());
    final BlockUserController blockUserController =
        Get.put(BlockUserController());
    final VenueRefreshController venueRefreshController =
        Get.put(VenueRefreshController()); // Initialize VenueRefreshController
    User? user = FirebaseAuth.instance.currentUser;

    venueRefreshController.currentPlaceId.value =
        checkInController.currentPlaceId.value;
    Future<void> _refreshData() async {
      print(
          'Refreshing data for place ${checkInController.currentPlaceId.value}...');
      // Rehit the API to fetch updated list of checked-in users
      await venueRefreshController.fetchVenueData();
      // print('The length of the checked in users is ${checkInController.checkedInUsers.length} ');
      // print('the user of the current place is ${checkInController.checkedInUsers.value[0].name} ');
    }

    return Obx(
      () => WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false, // Remove default back button
            leading: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    showCustomPopup(
                      context: context,
                      headingText: 'Leave this venue?',
                      subText:
                          'You will not be able to connect with someone new from this venue after checkout.',
                      buttonText: 'Check out',
                      belowButtonText: 'Don\'t show again',
                      onButtonPressed: () async {
                        // Handle continue button press
                        final userId = user?.uid;
                        final placeId = checkInController.currentPlaceId.value;

                        final request =
                            CheckOutRequest(userId: userId!, placeId: placeId);
                        await checkOutController.checkOutUser(request);
                        // Handle continue button press
                        print("Check out tapped");

                        // Get.back();
                      },
                      onBelowButtonPressed: () {
                        Get.back();
                        print("Don't show again tapped");
                      },
                      onGuidelinesPressed: () {
                        // TODO route to guidelines
                      },
                      showGuidelines: false,
                    );
                  },
                  child: ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: <Color>[gradientLeft, gradientRight],
                      ).createShader(bounds);
                    },
                    child: const Text(
                      '  Check out',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'SFProDisplay',
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            leadingWidth: 120,
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            actions: [
              IconButton(
                icon: Image.asset('assets/bell.png'), // Path to your bell icon
                onPressed: () {
                  Get.to(() => NewConnectionScreen());
                },
              ),
              IconButton(
                icon: Image.asset(
                    height: 35,
                    width: 35,
                    'assets/settings.png'), // Path to your settings icon
                onPressed: () {
                  //Get.to(()=> SubscriptionScreen());
                  Get.to(() => PreferencesScreen());
                },
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: _refreshData,
            child: checkInController.filteredUsers.isEmpty
                ? _buildEmptyVenue(checkInController)
                : _buildPopulatedVenue(context, checkInController,
                    sendRequestController, user, blockUserController),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyVenue(CheckInController checkInController) {
    return ListView(shrinkWrap: true, children: [
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20.0), // Adjust vertical padding as needed
            child: ToggleSwitch(
              minWidth: 100.0,
              initialLabelIndex:
                  checkInController.currentGenderFilterIndex.value,
              cornerRadius: 20.0,
              activeFgColor: Colors.black,
              inactiveBgColor: Colors.grey[200],
              totalSwitches: 4,
              labels: const ['Male', 'Female', 'Non binary', 'Everyone'],
              customTextStyles: const [
                TextStyle(fontFamily: 'SFProDisplay', fontSize: 12),
              ],
              activeBgColors: const [
                [Colors.white, Colors.white],
                [Colors.white, Colors.white],
                [Colors.white, Colors.white],
                [Colors.white, Colors.white],
              ],
              radiusStyle: true,
              onToggle: (index) {
                print('switched to: $index');
                String gender =
                    ['Male', 'Female', 'Non binary', 'Everyone'][index!];
                checkInController.filterUsersByGender(gender);
                print('Switched to: $gender');
                checkInController.currentGenderFilterIndex.value = index;
              },
            ),
          ),
          SizedBox(height: 130),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Image.asset(
                  'assets/checking_in.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Looks like it's just you for now. \n Hang tight!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SFProDisplay',
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Don't worry though, more users could pop in at any moment.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'SFProDisplay',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 180),
        ],
      ),
    ]);
  }

  Widget _buildPopulatedVenue(
      BuildContext context,
      CheckInController checkInController,
      SendRequestController sendRequestController,
      User? user,
      BlockUserController blockUserController) {
    List<Map<String, String?>> items =
        checkInController.filteredUsers.map((checkedInUser) {
      return {
        'image': checkedInUser.userPictures.isNotEmpty
            ? checkedInUser.userPictures.first.imageUrl
            : null,
        'title': checkedInUser.name,
        'placeId': checkedInUser.uid,
      };
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: ToggleSwitch(
            minWidth: 100.0,
            initialLabelIndex: checkInController.currentGenderFilterIndex.value,
            cornerRadius: 20.0,
            activeFgColor: Colors.black,
            inactiveBgColor: Colors.grey[200],
            totalSwitches: 4,
            labels: const ['Male', 'Female', 'Non binary', 'Everyone'],
            customTextStyles: const [
              TextStyle(fontFamily: 'SFProDisplay', fontSize: 12),
            ],
            activeBgColors: const [
              [Colors.white, Colors.white],
              [Colors.white, Colors.white],
              [Colors.white, Colors.white],
              [Colors.white, Colors.white],
            ],
            radiusStyle: true,
            onToggle: (index) {
              print('switched to: $index');
              String gender =
                  ['Male', 'Female', 'Non binary', 'Everyone'][index!];
              checkInController.filterUsersByGender(gender);
              print('Switched to: $gender');
              checkInController.currentGenderFilterIndex.value = index;
            },
          ),
        ),
        const Text(
          '   Currently Checked in:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            fontFamily: 'SFProDisplay',
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10),
        SizedBox(
          child: HorizontalListView(
            items: items,
          ),
          height: 100,
        ),
        Expanded(
          child: Obx(() {
            print(
                'Building ListView with ${checkInController.filteredUsers.length} users');
            return ListView.builder(
              itemCount: checkInController.filteredUsers.length,
              itemBuilder: (context, index) {
                final checkedInUser = checkInController.filteredUsers[index];
                var imageUrls = <String>[];
                for (var picture in checkedInUser.userPictures) {
                  if (picture.imageUrl.isNotEmpty) {
                    imageUrls.add(picture.imageUrl);
                  }
                }
                return buildProfileCard(
                  imageUrls,
                  checkedInUser.name,
                  checkedInUser.age,
                  checkedInUser.uid, // Pass user UID for sending request
                  sendRequestController, // Pass the controller to handle the request
                  blockUserController, // Pass the controller to handle blocking
                  user?.uid, // Pass the controller to handle the request
                );
              },
            );
          }),
        ),
      ],
    );
  }

  Widget buildProfileCard(
      List<String> imageUrls,
      String name,
      int age,
      String receiverUid,
      SendRequestController sendRequestController,
      BlockUserController blockUserController,
      String? senderUid) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ProfileCard(
        imageUrls: imageUrls,
        name: name,
        age: age,
        senderUid: senderUid!,
        receiverUid: receiverUid,
        onBlockPressed: () async {
          print('Block pressed for $name');
          if (senderUid != null) {
            print('Sender UID: $senderUid');
            print('Receiver UID: $receiverUid');
            final blockUserModel =
                BlockUserModel(userUID: senderUid, blockUID: receiverUid);
            await blockUserController.blockUser(blockUserModel);
          } else {
            print('User UID is null');
          }
        },
        onReportPressed: () {
          //Get.back();
          print('Report for $name');
        },
        onHeartPressed: () async {
          print('Heart pressed for $name');
          if (senderUid != null) {
            print('Sender UID: $senderUid');
            print('Receiver UID: $receiverUid');
            final request = SendRequestModel(
                senderUid: senderUid, receiverUid: receiverUid);
            await sendRequestController.sendRequest(request);
          } else {
            print('Sender UID is null');
          }
        },
      ),
    );
  }
}
