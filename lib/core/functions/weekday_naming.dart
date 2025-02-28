import '/core/localization/app_strings.dart';
import 'package:get/get.dart';

String weekdayNaming(int id) {
  return switch (id) {
    1 => AppStrings.monday.tr,
    2 => AppStrings.tuesday.tr,
    3 => AppStrings.wednesday.tr,
    4 => AppStrings.thursday.tr,
    5 => AppStrings.friday.tr,
    6 => AppStrings.saturday.tr,
    7 => AppStrings.sunday.tr,
    _ => "Not Valid Weekday id",
  };
}


