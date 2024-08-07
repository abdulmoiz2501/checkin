import 'dart:ui';

import 'package:checkin/View/SubscriptionScreen.dart';
import 'package:checkin/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../constants/colors.dart';
import '../controllers/accept_request_controller.dart';
import '../controllers/get_request_controller.dart';
import '../controllers/reject_request_controller.dart';
import '../models/accept_request_model.dart';
import '../models/request_reject_model.dart';
import '../widgets/profile_card_request.dart';
import '../widgets/progress_indicator.dart';
import 'LikeScreen_blurred.dart';
import 'no_connections.dart';
import 'no_connections_premium.dart';

class LikeScreen extends StatefulWidget {
  LikeScreen({super.key});

  @override
  State<LikeScreen> createState() => _LikeScreenState();
}

class _LikeScreenState extends State<LikeScreen> {
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
    // _getCurrentUserId();
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await _getCurrentUserId();
    });
  }

  Future<void> _getCurrentUserId() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {

        currentUserId = user.uid;

      print('Current User ID: ${user.uid}');
      getRequestController.fetchRequests(user.uid);
    }
  }

  Future<void> _refreshData() async {
    if (currentUserId != null) {
      await getRequestController.fetchRequests(currentUserId!);
    }
  }

  void updateData() async {
    await _getCurrentUserId();
  }

  @override
  Widget build(BuildContext context) {
    print('In the like screen');

    return Obx(
      () => Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading:
                false, // This removes the default back button
            backgroundColor: Colors.white, // Set the background color as needed
            elevation: 0,
            centerTitle: true,
            title: Text(
              'People Who Liked You',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: getRequestController.isLoading.value
              ? const Center(
                  child: CustomCircularProgressIndicator(),
                )
              : _buildContent()),
    );
  }

  Widget _buildContent() {
     final isSubscribed = userController.user.value?.subscribed != false;
   // final isSubscribed = false;

    if (getRequestController.recRequests.isEmpty) {
      print('No requests found. Subscribed status: $isSubscribed');
      return isSubscribed ? NoConnectionsPremium() : NoConnections();
    } else {
      print('Requests found. Subscribed status: $isSubscribed');
      return RefreshIndicator(
        onRefresh: _refreshData,
        child: Stack(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: getRequestController.recRequests.length,
              itemBuilder: (context, index) {
                final request = getRequestController.recRequests[index];
                print(
                    'Request from: ${request.sender.name}, Subscribed: ${request.sender.subscribed}');
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
            if (!isSubscribed) ...[
              LikeScreenBlur(),
            ],
          ],
        ),
      );
    }
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
      child: ProfileCardRequest(
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
