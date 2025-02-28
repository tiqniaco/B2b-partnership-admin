import 'package:get/get.dart';

enum StoreOrderStatusEnum {
  all,
  pending,
  approved,
  completed,
  canceled,
}

extension StoreOrderStatusEnumExtension on StoreOrderStatusEnum {
  String get value {
    switch (this) {
      case StoreOrderStatusEnum.all:
        return 'all';
      case StoreOrderStatusEnum.pending:
        return 'pending';
      case StoreOrderStatusEnum.approved:
        return 'approved';
      case StoreOrderStatusEnum.completed:
        return 'completed';
      case StoreOrderStatusEnum.canceled:
        return 'canceled';
    }
  }
}

extension StoreOrderStatusEnumView on StoreOrderStatusEnum {
  String get text {
    switch (this) {
      case StoreOrderStatusEnum.all:
        return 'All'.tr;
      case StoreOrderStatusEnum.pending:
        return 'Pending'.tr;
      case StoreOrderStatusEnum.approved:
        return 'Approved'.tr;
      case StoreOrderStatusEnum.completed:
        return 'Completed'.tr;
      case StoreOrderStatusEnum.canceled:
        return 'Cancelled'.tr;
    }
  }
}
