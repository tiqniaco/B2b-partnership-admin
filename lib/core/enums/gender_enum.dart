import '/core/localization/app_strings.dart';
import 'package:get/get.dart';

enum GenderEnum {
  male,
  female,
}

extension Value on GenderEnum {
  String getValue() {
    switch (this) {
      case GenderEnum.male:
        return AppStrings.male.tr;
      case GenderEnum.female:
        return AppStrings.female.tr;
    }
  }
}
