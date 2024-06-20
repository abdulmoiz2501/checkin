import 'package:flutter/material.dart';

class HorizontalListView extends StatelessWidget {
  final List<Map<String, String>> items;

  HorizontalListView({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(items[index]['image']!),
                ),
                SizedBox(height: 2),
                Text(
                  items[index]['title']!,
                  style: TextStyle(fontSize: 12, fontFamily: 'SFProDisplay'),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
