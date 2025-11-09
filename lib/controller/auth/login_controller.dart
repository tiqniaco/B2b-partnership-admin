// ignore_for_file: avoid_print

import '/app_routes.dart';
import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/functions/subscripe_topics.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';
import '/core/utils/app_snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class LoginController extends GetxController {
  late TextEditingController loginController;
  late TextEditingController passwordController;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  StatusRequest statusRequest = StatusRequest.loading;

  bool obscureText = true;
  bool obscurePassword = true;
  bool isLoading = false;

  @override
  void onInit() {
    loginController = TextEditingController();
    passwordController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    loginController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  ontapSupfix() {
    obscureText = !obscureText;
    update();
  }

  validUserData(val) {
    if (val.isEmpty) {
      return "can't be empty";
    }
  }

  Future<void> login() async {
    if (loginFormKey.currentState!.validate()) {
      statusRequest = StatusRequest.loading;

      final result = await CustomRequest<Map<String, dynamic>>(
          path: ApiConstance.login,
          fromJson: (json) {
            return json;
          },
          data: {
            "login": loginController.text,
            "password": passwordController.text,
          }).sendPostRequest();
      result.fold((l) {
        statusRequest = StatusRequest.error;
        Logger().e(l.errMsg);
        AppSnackBars.error(message: l.errMsg);
        update();
      }, (r) {
        if (r['role'] == 'admin') {
          AppSnackBars.success(message: r['message']);
          statusRequest = StatusRequest.success;
          subscribeTopics(
            r['user_id'],
            r['role'],
          );
          Get.find<AppPreferences>().setToken(r['token']);
          Get.find<AppPreferences>().setUserId(r['user_id'].toString());
          Get.find<AppPreferences>().setUserRoleId(r['role_id'].toString());
          Get.find<AppPreferences>().setUserRole(r['role']);
          ApiConstance.token = r['token'];
          Get.offAllNamed(AppRoutes.adminHomeLayout);
        }else{
           AppSnackBars.error(message: "account not found".tr);
        }


        update();
      });
    }
  }
}
