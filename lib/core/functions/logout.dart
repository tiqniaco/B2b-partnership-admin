// import 'package:firebase_messaging/firebase_messaging.dart';

// import 'dart:developer';

import '/core/theme/app_color.dart';

import '../../app_routes.dart';
import 'package:get/get.dart';
import '../constants/app_constants.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';

Future<void> logoutDialog() async {
  Get.defaultDialog<bool>(
    title: 'Logout?'.tr,
    middleText: 'Are you sure you want to logout?'.tr,
    textConfirm: 'Yes'.tr,
    confirmTextColor: whiteColor,
    textCancel: 'No'.tr,
    onConfirm: () {
      logout();
    },
  );
}

Future<void> logout() async {
  /// Clear all shared preferences
  await Get.find<AppPreferences>().clear();
  Get.offAllNamed(AppRoutes.initial);

  /// Reset all global variables
  kFirstTime = true;
  ApiConstance.token = '';

  /// Unsubscribe from all topics
  // FirebaseMessaging.instance.unsubscribeFromTopic('all');
  // FirebaseMessaging.instance.unsubscribeFromTopic('admins');
  // FirebaseMessaging.instance.unsubscribeFromTopic('admin$kUserId');

  /// Navigate to login screen
}
