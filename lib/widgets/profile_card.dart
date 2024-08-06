import 'package:checkin/constants/colors.dart';
import 'package:checkin/models/user_model.dart';
import 'package:checkin/widgets/user_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'bottom_modal_sheet.dart';
import 'custom_pop_up.dart';

class ProfileCard extends StatefulWidget {
  final List<String> imageUrls;
  final String name;
  final int age;
  final String senderUid;
  final String receiverUid;
  final VoidCallback onBlockPressed;
  final VoidCallback onHeartPressed;
  final VoidCallback onReportPressed;
  final UserModel user;

  ProfileCard({
    required this.imageUrls,
    required this.name,
    required this.age,
    required this.senderUid,
    required this.receiverUid,
    required this.onBlockPressed,
    required this.onHeartPressed,
    required this.onReportPressed,
    required this.user,
  });

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  int _currentPage = 0;
  OverlayEntry? _popupDialog;
  String? _selectedOption;
  bool showSendTick = false;

  void _showOptions(BuildContext context) {
    if (_popupDialog != null) {
      _popupDialog!.remove();
    }

    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);

    _popupDialog = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () {
          if (_popupDialog != null) {
            _popupDialog!.remove();
            _popupDialog = null;
          }
        },
        child: Material(
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                left: position.dx + renderBox.size.width - 280,
                top: position.dy + renderBox.size.height,
                child: GestureDetector(
                  onTap: () {
                    print('Heart');
                  },
                  child: Material(
                    elevation: 15.0,
                    color: Colors.transparent,
                    child: Container(
                      width: 190,
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading:
                                const Icon(Icons.block, color: Colors.white),
                            title: const Text(
                              'Block',
                              style: TextStyle(
                                fontFamily: 'SFProDisplay',
                              ),
                            ),
                            minLeadingWidth: 0,
                            dense: true,
                            horizontalTitleGap: 4,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16.0),
                            onTap: () {
                              widget.onBlockPressed();
                              _popupDialog!.remove();
                              _popupDialog = null;
                            },
                          ),
                          Divider(height: 1, color: Colors.grey[300]),
                          ListTile(
                            leading: Icon(Icons.flag_sharp, color: Colors.red),
                            title: const Text(
                              'Report Profile',
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'SFProDisplay',
                              ),
                            ),
                            minLeadingWidth: 0,
                            dense: true,
                            horizontalTitleGap: 4,
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 16.0),
                            onTap: () {
                              widget.onReportPressed();
                              _showReportBottomSheet(
                                context,
                                widget.name,
                                widget.senderUid,
                                widget.receiverUid,
                              );
                              _popupDialog!.remove();
                              _popupDialog = null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    Overlay.of(context)!.insert(_popupDialog!);
  }

  void _showReportBottomSheet(
      BuildContext context, String name, String userUID, String reportUserUID) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      builder: (BuildContext context) {
        return ReportOptionsModal(
            name: name, userUID: userUID, reportUserUID: reportUserUID);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(
        '/////////////This is the length of the imageUrls: ${widget.imageUrls.length} ////////////  ');
    return WillPopScope(
      onWillPop: () async {
        if (_popupDialog != null) {
          _popupDialog!.remove();
          _popupDialog = null;
          return false;
        }
        return true;
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Swipeable images with indicator bar
            Stack(
              children: [
                Container(
                  height: 300, // Set a specific height for the image
                  width: double.infinity,
                  child: PageView.builder(
                    itemCount: widget.imageUrls.length + 1,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Image.network(
                          widget.imageUrls[index],
                          fit: BoxFit.cover,
                        );
                      }
                      if (index == 1) {
                        // SHOW CARD HERE
                        return UserCard(
                            imageUrl: widget.imageUrls.first,
                            name: widget.user.name,
                            age: widget.user.age,
                            gender: widget.user.gender,
                            height: '129',
                            sexualPreference: widget.user.sex,
                            showSexualOrientation:
                                widget.user.showSexualOrientation,
                            description: widget.user.description,
                            checkinGoals: widget.user.checkInGoals == null
                                ? ['No Check-In Goals']
                                : widget.user.checkInGoals!.isNotEmpty
                                    ? widget.user.checkInGoals
                                    : ['No Check-In Goals']);
                      } else {
                        return Image.network(
                          widget.imageUrls[index - 1],
                          fit: BoxFit.cover,
                        );
                      }
                    },
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 10,
                    margin: EdgeInsets.all(6.0), // Add margin to the sides
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:
                          List.generate(widget.imageUrls.length + 1, (index) {
                        return Container(
                          width: (MediaQuery.of(context).size.width - 52) /
                                  (widget.imageUrls.length + 1) -
                              4, // Adjust width and add spacing
                          margin: EdgeInsets.symmetric(
                              horizontal: 3.0), // Add space between segments
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: index == _currentPage
                                  ? [gradientLeft, gradientRight]
                                  : [Colors.grey, Colors.grey],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
            // White bar with details
            Container(
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'SFProDisplay',
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        '${widget.age}',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.grey,
                          fontFamily: 'SFProDisplay',
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.more_horiz),
                        onPressed: () => _showOptions(context),
                      ),
                      SizedBox(width: 16),
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [gradientLeft, gradientRight],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: IconButton(
                          icon: Icon(
                              !showSendTick ? Icons.favorite : Icons.done,
                              color: Colors.white),
                          onPressed: () {
                            if (!showSendTick) {
                              widget.onHeartPressed();
                              // Show the popup
                              showCustomPopup(
                                context: context,
                                headingText: 'Request sent!',
                                subText:
                                    'We\'ve informed the other user of your interest. You\'ll be notified once they accept your request. Remember to follow the guidelines.',
                                buttonText: 'Continue',
                                belowButtonText: 'Don\'t show again',
                                onButtonPressed: () {
                                  setState(() {
                                    showSendTick = true;
                                  });
                                  // Handle continue button press
                                  //Get.back();
                                },
                                onBelowButtonPressed: () {
                                  /// Handle "Don't show again" button press
                                  // Get.back();
                                  print("Don't show again tapped");
                                },
                                onGuidelinesPressed: () {
                                  ///TODO route to guidelines
                                },
                                showGuidelines: true,
                              );
                            } else {
                              Get.snackbar("Already Sent",
                                  "You have already sent a request to this user");
                              //VoidLoaders.errorSnackBar(title: 'Already Sent' , message: 'You have already sent a request to this user');
                            }
                          },
                        ),
                      ),
                    ],
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
