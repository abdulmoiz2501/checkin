import 'package:checkin/View/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  final Color gradientLeft = const Color(0xFFF83600); // Example color, replace with your actual color

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildIconWithColor(String iconAssetPath, String selectedIconAssetPath, int index) {
    bool isSelected = _selectedIndex == index;
    return Image.asset(
      isSelected ? selectedIconAssetPath : iconAssetPath,
      height: 24, // Adjust the size as needed
      width: 24,  // Adjust the size as needed
      color: isSelected ? gradientLeft : const Color(0XFFC3B6B6), // Color overlay based on selection
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
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
        children: const [
          HomeScreen(),
          Center(child: Text('Favorites Screen')),
          Center(child: Text('Chat Screen')),
          Center(child: Text('People Screen')),
          Center(child: Text('Profile Screen')),
        ],
      ),
    );
  }
}
