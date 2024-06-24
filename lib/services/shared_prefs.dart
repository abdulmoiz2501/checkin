import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../View/NameScreen.dart';
import '../View/rules_screen.dart';

Future<void> _checkCompletionStatusAndNavigate() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isCompleted = prefs.getBool('isCompleted') ?? false;
  if (isCompleted) {
    Get.to(() => RulesScreen());
  } else {
    Get.to(() => NameScreen());
  }
}