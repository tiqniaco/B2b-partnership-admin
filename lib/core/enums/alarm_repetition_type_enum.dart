import '/core/localization/app_strings.dart';
import 'package:get/get.dart';

enum AlarmRepetitionTypeEnum {
  currentDayOnly,
  everyDay,
  // forASpecificPeriod,
  differentDays,
}

extension AlarmRepetitionTypeEnumExtension on AlarmRepetitionTypeEnum {
  String get getValue {
    switch (this) {
      case AlarmRepetitionTypeEnum.currentDayOnly:
        return AppStrings.currentDayOnly.tr;
      case AlarmRepetitionTypeEnum.everyDay:
        return AppStrings.everyDay.tr;
      // case AlarmRepetitionTypeEnum.forASpecificPeriod:
      //   return AppStrings.forASpecificPeriod.tr;
      case AlarmRepetitionTypeEnum.differentDays:
        return AppStrings.differentDays.tr;
    }
  }
}
