import 'dart:ui';

import 'package:checkin/constants/colors.dart';
import 'package:checkin/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'bottom_modal_sheet.dart';
import 'custom_pop_up.dart';

class ProfileCardRequestGrid extends StatefulWidget {
  final List<String> imageUrls;
  final String name;
  final int age;
  final String senderUid;
  final String receiverUid;
  final Future<void> Function() onRejectPressed;
  final Future<void> Function() onHeartPressed;

  ProfileCardRequestGrid({
    required this.imageUrls,
    required this.name,
    required this.age,
    required this.senderUid,
    required this.receiverUid,
    required this.onRejectPressed,
    required this.onHeartPressed,
  });

  @override
  _ProfileCardRequestGridState createState() => _ProfileCardRequestGridState();
}

class _ProfileCardRequestGridState extends State<ProfileCardRequestGrid> {
  OverlayEntry? _popupDialog;
  bool isRejectLoading = false;
  bool isHeartLoading = false;

  @override
  Widget build(BuildContext context) {
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
            Stack(
              children: [
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width / 2,
                  child: PageView.builder(
                    itemCount: widget.imageUrls.length,
                    onPageChanged: (int page) {
                      setState(() {
                        //_currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      return ImageFiltered(
                        imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Image.network(
                          widget.imageUrls[index],
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            // White bar with details
            Container(
              padding:
                  EdgeInsets.all(8), // Reduce padding for smaller container
              color: Colors.white,
              child: Stack(
                children: [
                  Flexible(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: 100,
                          height: 10,
                        ),
                        SizedBox(width: 8), // Reduce spacing
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFD9D9D9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          width: 30,
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Flexible(
                  //       child: Row(
                  //         crossAxisAlignment: CrossAxisAlignment.center,
                  //         children: [
                  //           Flexible(
                  //             child: Text(
                  //               widget.name,
                  //               style: TextStyle(
                  //                 fontSize: 18, // Reduce font size
                  //                 fontWeight: FontWeight.bold,
                  //                 color: Colors.black,
                  //                 fontFamily: 'SFProDisplay',
                  //               ),
                  //               overflow:
                  //                   TextOverflow.ellipsis, // Handle overflow
                  //             ),
                  //           ),
                  //           SizedBox(width: 8), // Reduce spacing
                  //           Text(
                  //             '${widget.age}',
                  //             style: TextStyle(
                  //               fontSize: 18, // Reduce font size
                  //               color: Colors.grey,
                  //               fontFamily: 'SFProDisplay',
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
