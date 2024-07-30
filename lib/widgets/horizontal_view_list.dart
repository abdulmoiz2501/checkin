import 'package:flutter/material.dart';

class HorizontalListView extends StatelessWidget {
  final List<Map<String, String?>> items;

  HorizontalListView({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90, // Adjust the height as needed
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          String imageUrl = items[index]['image']?? '';
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: imageUrl.isEmpty ? Colors.grey : null,
                  backgroundImage: imageUrl.isNotEmpty ? NetworkImage(imageUrl) : null,
                  child: imageUrl.isEmpty ? Icon(Icons.image_not_supported, color: Colors.white) : null,
                ),
                SizedBox(height: 2),
                Container(
                  width: 70,
                  child: Text(
                    items[index]['title']!,
                    style: TextStyle(fontSize: 12, fontFamily: 'SFProDisplay'),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
