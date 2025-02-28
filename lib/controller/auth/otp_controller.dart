import 'dart:developer';

import '/app_routes.dart';
import '/controller/auth/forget_password_controller.dart';
import '/core/crud/custom_request.dart';
import '/core/network/api_constance.dart';
import '/core/utils/app_snack_bars.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
  String otp = "";
  String email = "";
  String role = "";
  bool fromAuth = false;
  bool isLoading = false;
  String message = "";
  String? verifiedOTP = "";

  @override
  Future<void> onInit() async {
    email = Get.arguments['email'] ?? "";
    fromAuth = Get.arguments['fromAuth'] ?? false;
    role = Get.arguments['role'] ?? "";
    if (fromAuth) {
      verifiedOTP = await Get.put(ForgetPasswordController()).sendOtp(
        email: email,
      );
    }
    super.onInit();
  }

  void onCodeChange(String code) {
    otp = code;
    update();
  }

  void onCodeSubmit(String verificationCode) {
    otp = verificationCode;
    update();
    if (otp == "") {
      AppSnackBars.warning(message: "OTP must not be empty".tr);
      return;
    } else if (otp.length != 6) {
      AppSnackBars.warning(message: "OTP must be 6 digits".tr);
      return;
    } else {
      verifyOTP(verifiedOTP == otp);
    }
  }

  Future<void> verifyOTP(bool verified) async {
    isLoading = true;
    message = "Verifying OTP...".tr;
    update();
    if (fromAuth) {
      if (verified) {
        //   message = "Creating Account...".tr;
        //   update();
        //   final controller = Get.put(SignupController());
        //   await Future.wait([
        //     controller.role == "provider"
        //         ? controller.signupProvider()
        //         : controller.signupClient(),
        //   ]);
        //   isLoading = false;
        //   message = "";
        //   update();
        //   // Get.offAllNamed(AppRoutes.login);
        // } else {
        //   AppSnackBars.error(message: "Not a valid OTP".tr);
        //   message = "";
        //   isLoading = false;
        //   update();
        // }
      } else {
        final result = await CustomRequest<String>(
          path: ApiConstance.verifyOTP,
          data: {
            "email": email,
            "otp": otp,
          },
          fromJson: (json) {
            return json['message'];
          },
        ).sendPostRequest();
        result.fold(
          (error) {
            isLoading = false;
            message = "";
            update();
            AppSnackBars.error(message: error.errMsg);
          },
          (data) async {
            AppSnackBars.success(
              message: "OTP Verified Successfully".tr,
            );

            Get.offNamed(
              AppRoutes.forgetPasswordReset,
              arguments: {
                "email": email,
              },
            );
          },
        );
      }
    }
  }

  Future<void> resendOTP() async {
    log(email, name: 'Email');
    Get.put(ForgetPasswordController()).sendOtp(email: email);
  }
}
