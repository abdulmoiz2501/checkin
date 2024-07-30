import 'package:checkin/View/HomeScreen.dart';
import 'package:checkin/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../View/ChatScreen.dart';
import '../View/LikeScreen.dart';
import '../View/VenuesScreen.dart';
import '../View/profile_tabBar_screen.dart';
import '../constants/colors.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;
  //final UserController userController = Get.put(UserController());

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildIconWithColor(String iconAssetPath, String selectedIconAssetPath, int index) {
    bool isSelected = _selectedIndex == index;
    return Image.asset(
      isSelected ? selectedIconAssetPath : iconAssetPath,
      height: 24,
      width: 24,
      color: isSelected ? gradientLeft : const Color(0XFFC3B6B6), // Color overlay
    );
  }
  Key _generateKey(int index) {
    return Key('$index-${DateTime.now().millisecondsSinceEpoch}');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

          return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _buildIconWithColor('assets/home_unselected.png', 'assets/home_selected.png', 0),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildIconWithColor('assets/star_unselected.png', 'assets/star_selected.png', 1),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildIconWithColor('assets/heart_unselected.png', 'assets/heart_selected.png', 2),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildIconWithColor('assets/chat_unselected.png', 'assets/chat_selected.png', 3),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: _buildIconWithColor('assets/people_unselected.png', 'assets/people_selected.png', 4),
              label: '',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children:  [
            HomeScreen(),
            VenueScreen(),
            LikeScreen(key: _generateKey(3),),
            Chatscreen(),
            //Center(child: Text('Profile Screen')),
            ProfileTabBArScreen(),
          ],
        ),
      ),
    );
  }
}
