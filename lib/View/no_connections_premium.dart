import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../controllers/get_request_controller.dart';

class NoConnectionsPremium extends StatefulWidget {
  const NoConnectionsPremium({Key? key}) : super(key: key);

  @override
  State<NoConnectionsPremium> createState() => _NoConnectionsPremiumState();
}

class _NoConnectionsPremiumState extends State<NoConnectionsPremium> {
  String? currentUserId;
  final GetRequestController getRequestController = Get.find();
  @override
  void initState() {
    super.initState();
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   _getCurrentUserId();
    // });
    // _getCurrentUserId();
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
  Future<void> _refreshData() async {
    if (currentUserId != null) {
      await getRequestController.fetchRequests(currentUserId!);
    }
  }
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshData,
      child: SingleChildScrollView(
        child: Container(
              height: MediaQuery.of(context).size.height*0.9,
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          'No connections right now',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'SFProDisplay',
                          ),
                        ),
                      ),
            
                      SizedBox(height: 10),
                      Text(
                        'Check back later',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          fontFamily: 'SFProDisplay',
                        ),
                      ),
                      SizedBox(height: 200),
                    ],
                  ),
        
        
        ),
      ),
    );
  }
}
