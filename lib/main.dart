import 'dart:convert';

import 'package:checkin/View/SplashScreen.dart';
import 'package:checkin/services/notification_service.dart';
import 'package:checkin/services/stripe.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/user_controller.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();


Future _firebaseBackgroundMessage(RemoteMessage message) async {
  if (message.notification != null) {
    print("Some notification Received in background...");
  }
}
 



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StripeServices.instance.initialize(); // Ini
  await _initializeFirebase();
  Get.put(UserController());
  await PushNotifications.init();
  await PushNotifications.localNotiInit();

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);

  Stripe.publishableKey = "pk_test_51Pc5xWRunBM6ve3yZWEL79EuXgWoxHiUZ09UzdjnNzir9t6RTAC3S9XLou4xxQ4wOySh0SyQNde0paoC6LWD5DuS00ROhdZRcN";
  await Stripe.instance.applySettings();

  // on background notification tapped
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    if (message.notification != null) {
      print("Background Notification Tapped");
      //navigatorKey.currentState!.pushNamed("/message", arguments: message);
    }
  });

  // to handle foreground notifications
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    print("Got a message in foreground");
    if (message.notification != null) {
/*      if (kIsWeb) {
        showNotification(
            title: message.notification!.title!,
            body: message.notification!.body!);
      } else {*/
        PushNotifications.showSimpleNotification(
            title: message.notification!.title!,
            body: message.notification!.body!,
            payload: payloadData);
      //}
    }
  });

  // for handling in terminated state
  final RemoteMessage? message =
  await FirebaseMessaging.instance.getInitialMessage();

  if (message != null) {
    print("Launched from terminated state");
    Future.delayed(Duration(seconds: 1), () {
     // navigatorKey.currentState!.pushNamed("/message", arguments: message);
    });
  }

  runApp(const MyApp());
}

Future<void> _initializeFirebase() async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  } catch (e) {
    // Handle any errors here if necessary
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        //primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      //home: NumberScreen(),
    );
  }
}
