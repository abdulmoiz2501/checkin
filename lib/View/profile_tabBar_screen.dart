import 'package:checkin/View/edit_profile_screen.dart';
import 'package:checkin/View/your_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';


class ProfileTabBArScreen extends StatefulWidget {
  ProfileTabBArScreen({
    Key? key,
  }) : super(key: key);


  @override
  State<ProfileTabBArScreen> createState() => _ProfileTabBArScreenState();
}

class _ProfileTabBArScreenState extends State<ProfileTabBArScreen> {
  var selectedIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'SFProDisplay',
              ),
            ).marginSymmetric(horizontal: 16.0),
            SizedBox(height: 8.0,),
          const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(
                  child: Text(
                    'Preview',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'SFProDisplay',
                    ),
                  )
                ),
                Tab(
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'SFProDisplay',
                      //color: textBlackColor,
                    ),
                  )
                ),
              ],
              indicatorColor: textMainColor,
              labelColor: textMainColor,
              unselectedLabelColor: Colors.grey,
            ),
            Expanded(
              child: TabBarView(
                // index: selectedIndex.value,
                children: [
                  YourProfileScreen(),
                  EditProfileScreen()
                ],
              ),
            ),
          ],
        )
      ),
    );
  }
}
