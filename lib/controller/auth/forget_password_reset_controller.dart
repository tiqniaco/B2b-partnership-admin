import '/app_routes.dart';
import '/core/crud/custom_request.dart';
import '/core/network/api_constance.dart';
import '/core/utils/app_snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordResetController extends GetxController {
  //final _repo = Get.find<ForgetPasswordRepo>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late TextEditingController newPasswordController;
  late TextEditingController confirmNewPasswordController;
  String email = "";

  bool newPasswordObscure = true;
  bool confirmPasswordObscure = true;

  void changeNewPasswordVisibility() {
    newPasswordObscure = !newPasswordObscure;
    update();
  }

  void changeConfirmPasswordVisibility() {
    confirmPasswordObscure = !confirmPasswordObscure;
    update();
  }

  Future<void> resetPassword() async {
    if (formKey.currentState?.validate() ?? false) {
      final result = await CustomRequest<String>(
          path: ApiConstance.forgetPassword,
          data: {
            "email": email,
            "password": newPasswordController.text,
          },
          fromJson: (json) {
            return json['message'];
          }).sendPostRequest();

      result.fold(
        (error) {
          AppSnackBars.error(message: error.errMsg);
        },
        (data) {
          AppSnackBars.success(
            message: "Password reset successfully".tr,
          );
          Get.offAllNamed(AppRoutes.login);
        },
      );
    }
  }

  @override
  void onInit() {
    newPasswordController = TextEditingController();
    confirmNewPasswordController = TextEditingController();
    email = Get.arguments['email'] ?? "";
    super.onInit();
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
    super.onClose();
  }
}
