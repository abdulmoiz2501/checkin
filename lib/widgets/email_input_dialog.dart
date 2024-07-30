// import 'package:flutter/material.dart';
//
// class EmailInputDialog {
//   static void show(BuildContext context, Function(String) onEmailSubmitted) {
//     final TextEditingController emailController = TextEditingController();
//
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Enter your email'),
//           content: TextField(
//             controller: emailController,
//             decoration: InputDecoration(hintText: "Email"),
//             keyboardType: TextInputType.emailAddress,
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Cancel'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Submit'),
//               onPressed: () {
//                 final String email = emailController.text.trim();
//                 onEmailSubmitted(email);
//                 Navigator.of(context).pop();
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
