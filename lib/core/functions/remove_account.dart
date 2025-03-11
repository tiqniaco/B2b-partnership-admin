import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/crud/custom_request.dart';
import '/core/network/api_constance.dart';
import '/core/utils/app_snack_bars.dart';
import 'package:get/get.dart';

import 'logout.dart';

void removeAccountDialog({
  required bool removeAccountLoading,
  required void Function([List<Object>? ids, bool condition]) update,
}) {
  Get.defaultDialog(
    title: "Remove Account".tr,
    content: Text(
      "Are you sure you want to remove your account?".tr,
      style: TextStyle(fontSize: 15.sp),
      textAlign: TextAlign.center,
    ),
    textCancel: "No".tr,
    textConfirm: "Yes".tr,
    onConfirm: () {
      Get.back();
      _removeAccount(removeAccountLoading, update);
    },
  );
}

Future<void> _removeAccount(
  bool removeAccountLoading,
  void Function([List<Object>? ids, bool condition]) update,
) async {
  removeAccountLoading = true;
  update();
  final result = await CustomRequest<String>(
    path: ApiConstance.deleteAccount,
    fromJson: (json) {
      return json['message'];
    },
  ).sendPostRequest();
  result.fold((l) {
    AppSnackBars.error(message: l.errMsg);
    removeAccountLoading = false;
    update();
  }, (r) {
    AppSnackBars.success(message: r);
    removeAccountLoading = false;
    logout();
    update();
  });
}
