import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../constants/colors.dart';
import '../controllers/accept_request_controller.dart';
import '../controllers/get_request_controller.dart';
import '../controllers/reject_request_controller.dart';
import '../controllers/user_controller.dart';
import '../models/accept_request_model.dart';
import '../models/request_reject_model.dart';
import '../widgets/profile_card_request.dart';
import '../widgets/profile_card_request_grid.dart';
import 'SubscriptionScreen.dart';

class LikeScreenBlur extends StatefulWidget {
  const LikeScreenBlur({super.key});

  @override
  State<LikeScreenBlur> createState() => _LikeScreenBlurState();
}

class _LikeScreenBlurState extends State<LikeScreenBlur> {
  final GetRequestController getRequestController =
      Get.put(GetRequestController());
  final AcceptRequestController acceptRequestController =
      Get.put(AcceptRequestController());
  final RejectRequestController rejectRequestController =
      Get.put(RejectRequestController());
  String? currentUserId;
  final UserController userController = Get.find();

  @override
  void initState() {
    super.initState();
/*    SchedulerBinding.instance.addPostFrameCallback((_)async {
      await _getCurrentUserId();
    });*/
    _getCurrentUserId();
  }

  Future<void> _getCurrentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        currentUserId = user.uid;
      });
      print('Current User ID: ${user.uid}');
      getRequestController.fetchRequests(user.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('In the like blurred screen');

    return Scaffold(
      body: Stack(
        children: [
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            shrinkWrap: true,
            itemCount: getRequestController.recRequests.length,
            itemBuilder: (context, index) {
              final request = getRequestController.recRequests[index];
              print(
                  '::: Request from: ${request.sender.name}, Subscribed: ${request.sender.subscribed}');
              return buildProfileCard(
                request.sender.userPictures.map((e) => e.imageUrl).toList(),
                request.sender.name,
                request.sender.age,
                request.sender.uid,
                acceptRequestController,
                rejectRequestController,
                currentUserId!,
                getRequestController,
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [gradientLeft, gradientRight],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: GestureDetector(
                onTap: () {
                  //
                  Get.to(
                    () => SubscriptionScreen(),
                  );
                },
                child: const Text(
                  'Get premium pass to see their profiles',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'SFProDisplay',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProfileCard(
      List<String> imageUrls,
      String name,
      int age,
      String senderUid,
      AcceptRequestController acceptRequestController,
      RejectRequestController rejectRequestController,
      String receiverUid,
      GetRequestController getRequestController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ProfileCardRequestGrid(
        imageUrls: imageUrls,
        name: name,
        age: age,
        senderUid: senderUid,
        receiverUid: receiverUid,
        onRejectPressed: () async {
          print('Reject pressed for $name');
          print('Sender UID: $senderUid');
          print('Receiver UID: $receiverUid');
          final rejectRequestModel =
              RejectRequestModel(userId: receiverUid, senderId: senderUid);
          await rejectRequestController.rejectRequest(
              rejectRequestModel.userId, rejectRequestModel.senderId);
          await getRequestController.fetchRequests(receiverUid);
        },
        onHeartPressed: () async {
          print('Accept pressed for $name');
          print('Sender UID: $senderUid');
          print('Receiver UID: $receiverUid');
          final acceptRequestModel =
              AcceptRequestModel(userId: receiverUid, senderId: senderUid);
          await acceptRequestController.acceptRequest(
              acceptRequestModel.userId, acceptRequestModel.senderId);
          await getRequestController.fetchRequests(receiverUid);
        },
      ),
    );
  }
}
