import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class VoidFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('dd-MMM-yyyy').format(date);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

  static String formatPhoneNumber(String phoneNumber) {
    return phoneNumber;
  }

  static String formatFirestoreTimestamp(Timestamp timestamp) {
    // Convert Timestamp to DateTime
    DateTime dateTime = timestamp.toDate();

    // Format DateTime to a string
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);

    return formattedDate;
    }

  static String finalTimeOnChats(String timestampString) {
    Timestamp timestamp = parseTimestampString(timestampString);
    return formatTimestampToTime(timestamp);
  }

  static String formatStringTimestampToTime(String timestampString) {
    DateTime dateTime = DateTime.parse(timestampString);
    return DateFormat('h:mm a').format(dateTime);
  }
  static String formatTimestampToTime(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    return DateFormat('h:mm a').format(dateTime);
  }

  static Timestamp parseTimestampString(String timestampString) {
    final RegExp regex = RegExp(r"Timestamp\(seconds=(\d+), nanoseconds=(\d+)\)");
    final Match? match = regex.firstMatch(timestampString);

    if (match != null) {
      final int seconds = int.parse(match.group(1)!);
      final int nanoseconds = int.parse(match.group(2)!);
      return Timestamp(seconds, nanoseconds);
    } else {
      throw FormatException("Invalid timestamp format");
    }
  }
}