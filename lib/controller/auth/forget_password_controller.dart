import '/app_routes.dart';
import '/core/crud/custom_request.dart';
import '/core/network/api_constance.dart';
import '/core/utils/app_snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  //final _repo = Get.find<ForgetPasswordRepo>();
  late TextEditingController emailController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    emailController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<String?> sendOtp({String? email}) async {
    String otp = "";
    if (formKey.currentState?.validate() ?? false || email != null) {
      final result = await CustomRequest<String>(
        path: ApiConstance.sendOTP,
        data: {
          "email": email ?? emailController.text,
        },
        fromJson: (json) {
          otp = json['otp'].toString();
          return json['message'];
        },
      ).sendPostRequest();

      return result.fold(
        (error) {
          AppSnackBars.error(message: error.errMsg);
          return null;
        },
        (data) {
          AppSnackBars.success(
            message: "OTP Send Successfully, please check your mail!".tr,
          );
          Get.toNamed(
            AppRoutes.otp,
            arguments: {
              "email": emailController.text,
            },
          );
          return otp;
        },
      );
    }
    return null;
  }
}
