import 'package:get/get.dart';
import '/core/localization/app_strings.dart';

String monthNaming(int id) {
  return switch (id) {
    1 => AppStrings.january.tr,
    2 => AppStrings.february.tr,
    3 => AppStrings.march.tr,
    4 => AppStrings.april.tr,
    5 => AppStrings.may.tr,
    6 => AppStrings.june.tr,
    7 => AppStrings.june.tr,
    8 => AppStrings.august.tr,
    9 => AppStrings.september.tr,
    10 => AppStrings.october.tr,
    11 => AppStrings.november.tr,
    12 => AppStrings.december.tr,
    _ => "Not Valid Mounth id",
  };
}
