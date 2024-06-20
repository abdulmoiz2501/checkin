// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class VenueSelectedScreen extends StatelessWidget {
//   const VenueSelectedScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Map background
//           Positioned.fill(
//             child: Image.asset(
//               'assets/map_background.png', // Replace with your map background asset
//               fit: BoxFit.cover,
//             ),
//           ),
//           // AppBar with back button
//           Positioned(
//             top: MediaQuery.of(context).padding.top,
//             left: 16,
//             child: IconButton(
//               icon: Icon(Icons.arrow_back, color: Colors.black),
//               onPressed: () {
//                 Get.back();
//               },
//             ),
//           ),
//           // Foreground content
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(16),
//                   topRight: Radius.circular(16),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 10,
//                     spreadRadius: 5,
//                   ),
//                 ],
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           "Forrester's Pub",
//                           style: TextStyle(
//                             fontSize: 24,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         ElevatedButton(
//                           onPressed: () {
//                             // Handle check-in action
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.orange,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                           ),
//                           child: Row(
//                             children: [
//                               Text("Checkin"),
//                               SizedBox(width: 8),
//                               Icon(Icons.check_circle, color: Colors.white),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Icon(Icons.location_on, color: Colors.orange),
//                         SizedBox(width: 4),
//                         Text("12 Riley St, Surry Hills"),
//                       ],
//                     ),
//                     SizedBox(height: 8),
//                     Row(
//                       children: [
//                         Text("Open", style: TextStyle(color: Colors.green)),
//                         Text(" · Closes 1 am"),
//                       ],
//                     ),
//                     SizedBox(height: 16),
//                     Row(
//                       children: [
//                         Container(
//                           padding: EdgeInsets.symmetric(
//                             vertical: 4,
//                             horizontal: 8,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.red,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             "LIVE",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                         SizedBox(width: 8),
//                         Text("30 people currently checked in"),
//                       ],
//                     ),
//                     SizedBox(height: 16),
//                     Text("What are people looking for here?"),
//                     SizedBox(height: 8),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         _buildInterestCount("Dates", 8),
//                         _buildInterestCount("Friends", 12),
//                         _buildInterestCount("Drinks", 10),
//                         _buildInterestCount("Food", 3),
//                       ],
//                     ),
//                     SizedBox(height: 16),
//                     Text("Forrester's"),
//                     SizedBox(height: 8),
//                     Row(
//                       children: [
//                         _buildImageThumbnail('assets/image1.png'), // Replace with your assets
//                         SizedBox(width: 8),
//                         _buildImageThumbnail('assets/image2.png'), // Replace with your assets
//                         SizedBox(width: 8),
//                         _buildImageThumbnail('assets/image3.png'), // Replace with your assets
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInterestCount(String label, int count) {
//     return Column(
//       children: [
//         Text(
//           count.toString(),
//           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//         ),
//         SizedBox(height: 4),
//         Text(label),
//       ],
//     );
//   }
//
//   Widget _buildImageThumbnail(String assetPath) {
//     return Expanded(
//       child: AspectRatio(
//         aspectRatio: 1,
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: Image.asset(
//             assetPath,
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }
