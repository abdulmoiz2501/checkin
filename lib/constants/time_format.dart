import 'package:intl/intl.dart';

String formatTime(String time) {
  final parsedTime = DateTime.parse('1970-01-01 $time:00Z');
  final formattedTime = DateFormat.jm().format(parsedTime.toLocal());
  return formattedTime;
}
