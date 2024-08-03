import 'package:checkin/controllers/settings_controller.dart';
import 'package:checkin/widgets/progress_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/colors.dart';
import 'SafetyCenterScreen.dart';
import 'SubscriptionScreen.dart';

class AccountSettingsScreen extends StatefulWidget {
  @override
  _AccountSettingsScreenState createState() => _AccountSettingsScreenState();
}

class _AccountSettingsScreenState extends State<AccountSettingsScreen> {
  final SettingsController settingsController = Get.put(SettingsController());
  // Manage checkbox states
  Map<String, bool> emailNotifications = {
    'All notifications': true,
    'New likes': true,
    'New connections': true,
    'New messages': true,
    'Promotions': false,
  };

  Map<String, bool> inAppNotifications = {
    'All notifications': true,
    'New likes': true,
    'New connections': false,
    'New messages': true,
    'Promotions': true,
  };

  bool isPaused = false;

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
            child: Image.asset(
                'assets/back_arrow.png'), // Load your back arrow image
          ),
          onPressed: () {
            Get.back();
          },
        ),
        centerTitle: true,
        title: Text(
          'Account Settings',
          style: TextStyle(
            fontFamily: 'SFProDisplay',
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Save action
            },
            child: Text(
              'Save',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..shader = LinearGradient(
                    colors: [gradientLeft, gradientRight],
                  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Phone & Email',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                color: Colors.grey,
              ),
            ),
            Divider(color: Color(0xFFEEEEEE)),
            Row(
              children: [
                Text(
                  '+92 333 888 929 60',
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    color: Colors.black,
                  ),
                ),
                SizedBox(width: 8.0),
                Image.asset('assets/verify_tick.png', width: 12, height: 12),
              ],
            ),
            Text(
              'Note: You cannot change the phone number associated with your account.',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
            Divider(color: Color(0xFFEEEEEE)),
            SizedBox(height: 10.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'name@email.com',
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    color: Colors.black,
                  ),
                ),
                // GestureDetector(
                //   onTap: () {
                //     // Edit action
                //   },
                //   child: Row(
                //     children: [
                //       Text(
                //         'Edit',
                //         style: TextStyle(
                //           fontFamily: 'SFProDisplay',
                //           color: Colors.black,
                //         ),
                //       ),
                //       // SizedBox(
                //       //     width:
                //       //         4), // Adjust the space between the text and the icon
                //       // Image.asset('assets/edit.png',
                //       //     width: 20, height: 20), // Load your edit image
                //     ],
                //   ),
                // ),
              ],
            ),
            SizedBox(height: 10.0),
            Divider(color: Color(0xFFEEEEEE)),
            SizedBox(height: 16.0),
            Text(
              'Notifications',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                color: Colors.grey,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(color: Color(0xFFEEEEEE)),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0), // Adjust padding as needed
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                          fontFamily: 'SFProDisplay',
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                      Text(
                        'In-app',
                        style: TextStyle(
                          fontFamily: 'SFProDisplay',
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildNotificationRow('All notifications'),
                _buildNotificationRow('New likes'),
                _buildNotificationRow('New connections'),
                _buildNotificationRow('New messages'),
                _buildNotificationRow('Promotions'),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Subscription',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                color: Colors.grey,
              ),
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildClickableRow('Subscribe to Checkin', onTap: () {
              Get.to(() => SubscriptionScreen());
            }),
            Divider(color: Color(0xFFEEEEEE)),
            _buildClickableRow('Restore purchase'),
            Divider(color: Color(0xFFEEEEEE)),
            SizedBox(height: 16.0),
            Text(
              'Safety',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                color: Colors.grey,
              ),
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildClickableRow('Safety Centre', onTap: () {
              Get.to(() => SafetyCenterScreen());
            }),
            Divider(color: Color(0xFFEEEEEE)),
            SizedBox(height: 16.0),
            Text(
              'Legal',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                color: Colors.grey,
              ),
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildClickableRow('Privacy policy'),
            Divider(color: Color(0xFFEEEEEE)),
            _buildClickableRow('Terms of service'),
            Divider(color: Color(0xFFEEEEEE)),
            _buildClickableRow('Licenses'),
            Divider(color: Color(0xFFEEEEEE)),
            SizedBox(height: 20.0),
            Text(
              'Account',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                color: Colors.grey,
              ),
            ),
            Divider(color: Color(0xFFEEEEEE)),
            _buildToggleRow('Pause my account'),
            Divider(color: Color(0xFFEEEEEE)),
            _buildLogoutRow('Logout'),
            Divider(color: Color(0xFFEEEEEE)),
            _buildLogoutRow('Delete account'),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationRow(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              color: Colors.black,
            ),
          ),
          Row(
            children: [
              Checkbox(
                value: emailNotifications[title],
                onChanged: (bool? value) {
                  setState(() {
                    emailNotifications[title] = value!;
                  });
                },
                activeColor: gradientLeft,
                checkColor: Colors.white,
              ),
              Checkbox(
                value: inAppNotifications[title],
                onChanged: (bool? value) {
                  setState(() {
                    inAppNotifications[title] = value!;
                  });
                },
                activeColor: gradientLeft,
                checkColor: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildClickableRow(String title, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                color: Colors.black,
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleRow(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'SFProDisplay',
              color: Colors.black,
            ),
          ),
          Switch(
            value: isPaused,
            onChanged: (bool value) {
              setState(() {
                isPaused = value;
              });
            },
            activeColor: gradientLeft,
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutRow(String title) {
    return GestureDetector(
      onTap: () {
        _showDeleteAccountDialog();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'SFProDisplay',
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Delete account?',
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 24.0,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'This action cannot be undone.',
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.0),
                Text(
                  'Are you sure you want to proceed?',
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    await settingsController.deleteAccount(FirebaseAuth
                        .instance.currentUser!.uid); // Pass the user ID here

                    ///DELETE ACC
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gradientLeft,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 78, vertical: 12),
                  ),
                  child: Obx(
                    () => settingsController.isLoading.value
                        ? CustomCircularProgressIndicator()
                        : Text(
                            'Delete',
                            style: TextStyle(
                              fontFamily: 'SFProDisplay',
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
                SizedBox(height: 8.0),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      color: gradientLeft,
                      decoration: TextDecoration.none, // Remove underline
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
