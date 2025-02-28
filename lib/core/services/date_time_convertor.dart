import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class DateTimeConvertor {
  static String formatDateTime(String dateTime) {
    final date = DateTime.parse(dateTime);
    final formattedDate =
        "${date.day}-${date.month}-${date.year} ${date.hour}:${date.minute}";
    return formattedDate;
  }

  static String formatDate(String dateTime) {
    final date = DateTime.parse(dateTime);
    final formattedDate = "${date.year}-${date.month}-${date.day}";
    return formattedDate;
  }

  static String formatTime(String dateTime) {
    final date = DateTime.parse(dateTime);
    final formattedTime = date.hour < 12
        ? "${date.hour}:${date.minute} AM"
        : "${date.hour - 12}:${date.minute} PM";

    return formattedTime;
  }

  static String stringToTime(String time) {
    TimeOfDay timeOfDay = TimeOfDay(
      hour: int.parse(time.split(":")[0]),
      minute: int.parse(time.split(":")[1]),
    );

    return timeOfDay.format(Get.context!).toString();
  }

  static String timeAgo(String dateTime, {String locale = 'en'}) {
    // Parse the input date string
    DateTime parsedDate = DateTime.parse(dateTime).add(
      const Duration(hours: 2),
    );

    // Register Arabic messages if locale is 'ar'
    if (locale == 'ar') {
      timeago.setLocaleMessages('ar', timeago.ArMessages());
    }

    // Format and return the relative time
    return timeago.format(parsedDate, locale: locale);
  }
}
