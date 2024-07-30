import 'package:checkin/constants/colors.dart';
import 'package:checkin/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'bottom_modal_sheet.dart';
import 'custom_pop_up.dart';

class ProfileCardRequest extends StatefulWidget {
  final List<String> imageUrls;
  final String name;
  final int age;
  final String senderUid;
  final String receiverUid;
  final Future<void> Function() onRejectPressed;
  final Future<void> Function() onHeartPressed;

  ProfileCardRequest({
    required this.imageUrls,
    required this.name,
    required this.age,
    required this.senderUid,
    required this.receiverUid,
    required this.onRejectPressed,
    required this.onHeartPressed,
  });

  @override
  _ProfileCardRequestState createState() => _ProfileCardRequestState();
}

class _ProfileCardRequestState extends State<ProfileCardRequest> {
  int _currentPage = 0;
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
            // Swipeable images with indicator bar
            Stack(
              children: [
                Container(
                  height: 300, // Set a specific height for the image
                  width: double.infinity,
                  child: PageView.builder(
                    itemCount: widget.imageUrls.length,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.network(
                        widget.imageUrls[index],
                        fit: BoxFit.cover,
                      );
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
                      children: List.generate(widget.imageUrls.length, (index) {
                        return Container(
                          width: (MediaQuery.of(context).size.width - 52) /
                                  widget.imageUrls.length -
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
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff21262D),
                        ),
                        child: IconButton(
                          icon: isRejectLoading
                              ? CustomCircularProgressIndicator()
                              : Icon(Icons.close, color: Colors.white,),
                          onPressed: () async {
                            setState(() {
                              isRejectLoading = true;
                            });
                            await widget.onRejectPressed();
                            setState(() {
                              isRejectLoading = false;
                            });
                          },
                        ),
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
                          icon: isHeartLoading
                              ? CustomCircularProgressIndicator()
                              : Icon(Icons.favorite, color: Colors.white,),
                          onPressed: () async {
                            setState(() {
                              isHeartLoading = true;
                            });
                            await widget.onHeartPressed();
                            setState(() {
                              isHeartLoading = false;
                            });
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
