import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Formats a time string (HH:mm) into a localized AM/PM format.
/// Example: "14:30" -> "2:30 م" (for 'ar' locale)
String formatTimeOfDayString(String timeString, {String locale = 'ar'}) {
  try {
    final hour = int.parse(timeString.split(':')[0]);
    final minute = int.parse(timeString.split(':')[1]);
    final timeOfDay = TimeOfDay(hour: hour, minute: minute);

    // Create a DateTime object to use DateFormat for localization
    final now = DateTime.now();
    final dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );

    // Use intl package for localized time formatting (e.g., "h:mm a")
    final format = DateFormat.jm(
      locale,
    ); // jm provides localized hour, minute, and AM/PM
    return format.format(dateTime);
  } catch (e) {
    log("Error formatting time string '$timeString': $e");
    return timeString; // Return original string if formatting fails
  }
}
