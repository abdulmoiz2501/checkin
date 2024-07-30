import 'package:checkin/constants/colors.dart';
import 'package:flutter/material.dart';

class GenderSelectionTile extends StatelessWidget {
  final String title;
  final String iconPath; // Asset path for the icon
  final bool isSelected;
  final VoidCallback onTap;

  GenderSelectionTile({
    required this.title,
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60,
        margin: EdgeInsets.symmetric(vertical: 3),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10),

        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Image.asset(
                iconPath,
                width: 24,
                height: 24,
              ),
            ),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'SFProDisplay',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Icon(
                isSelected
                    ? Icons.radio_button_on
                    : Icons.radio_button_off_sharp,
                color: isSelected ? gradientLeft: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}