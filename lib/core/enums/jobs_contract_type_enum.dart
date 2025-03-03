import 'package:get/get.dart';

enum JobsContractTypeEnum {
  fullTime,
  partTime,
  intern,
  freelance,
}

extension JobsContractTypeExtension on JobsContractTypeEnum {
  String get text {
    switch (this) {
      case JobsContractTypeEnum.fullTime:
        return "Full Time".tr;
      case JobsContractTypeEnum.partTime:
        return "Part Time".tr;
      case JobsContractTypeEnum.intern:
        return "Intern".tr;
      case JobsContractTypeEnum.freelance:
        return "Freelance".tr;
    }
  }

  String get value {
    switch (this) {
      case JobsContractTypeEnum.fullTime:
        return "full_time";
      case JobsContractTypeEnum.partTime:
        return "part_time";
      case JobsContractTypeEnum.intern:
        return "intern";
      case JobsContractTypeEnum.freelance:
        return "freelance";
    }
  }
}
