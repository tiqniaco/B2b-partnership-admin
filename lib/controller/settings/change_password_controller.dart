import '/app_routes.dart';
import '/core/crud/custom_request.dart';
import '/core/network/api_constance.dart';
import '/core/utils/app_snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  late TextEditingController oldPasswordController;
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool oldPasswordObscure = true;
  bool newPasswordObscure = true;
  bool confirmPasswordObscure = true;

  @override
  void onInit() {
    oldPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  Future<void> changePassword() async {
    if (formKey.currentState?.validate() ?? false) {
      final result = await CustomRequest<String>(
        path: ApiConstance.resetPassword,
        data: {
          "old_password": oldPasswordController.text,
          "new_password": newPasswordController.text,
        },
        fromJson: (json) {
          return json['message'];
        },
      ).sendPostRequest();

      result.fold(
        (l) {
          debugPrint("----------------------------------");
          debugPrint("Error: ${l.errMsg}");
          debugPrint("----------------------------------");
          AppSnackBars.error(message: l.errMsg);
        },
        (data) {
          AppSnackBars.success(message: data);
          Get.offAllNamed(AppRoutes.adminHomeLayout);
        },
      );
    }
  }

  void changeOldPasswordVisibility() {
    oldPasswordObscure = !oldPasswordObscure;
    update();
  }

  void changeNewPasswordVisibility() {
    newPasswordObscure = !newPasswordObscure;
    update();
  }

  void changeConfirmPasswordVisibility() {
    confirmPasswordObscure = !confirmPasswordObscure;
    update();
  }
}
