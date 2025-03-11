import '/controller/auth/forget_password_reset_controller.dart';
import '/core/global/widgets/custom_loading_button.dart';
import '/core/theme/text_style.dart';
import '/widgets/auth/auth_text_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ForgetPasswordResetView extends StatelessWidget {
  const ForgetPasswordResetView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordResetController>(
      init: ForgetPasswordResetController(),
      builder: (ForgetPasswordResetController controller) {
        return Scaffold(
            appBar: AppBar(
              title: Text("Reset Password".tr),
            ),
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Please enter your new Password and Confirm your new Password"
                            .tr,
                        textAlign: TextAlign.center,
                        style: getMediumStyle.copyWith(height: 1.5),
                        maxLines: 3,
                      ),
                      Gap(25.h),
                      AuthTextForm(
                        textFormController: controller.newPasswordController,
                        lable: "New Password".tr,
                        preicon: CupertinoIcons.lock,
                        hintText: 'New Password'.tr,
                        obscureText: controller.newPasswordObscure,
                        onTapIconsuf: controller.changeNewPasswordVisibility,
                        suficon: controller.newPasswordObscure
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off_outlined,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "New Password is required".tr;
                          } else if (value.length < 6) {
                            return "Password must be >= 6 letter".tr;
                          }
                          return null;
                        },
                      ),
                      Gap(12.h),
                      AuthTextForm(
                        textFormController:
                            controller.confirmNewPasswordController,
                        lable: "Confirm Password".tr,
                        preicon: CupertinoIcons.lock,
                        hintText: 'Confirm password'.tr,
                        obscureText: controller.confirmPasswordObscure,
                        onTapIconsuf:
                            controller.changeConfirmPasswordVisibility,
                        suficon: controller.confirmPasswordObscure
                            ? Icons.remove_red_eye_outlined
                            : Icons.visibility_off_outlined,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Confirm Password is required".tr;
                          } else if (value.length < 6) {
                            return "Confirm Password must be >= 6 letter".tr;
                          } else if (value !=
                              controller.newPasswordController.text) {
                            return "Not match!".tr;
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              height: 0.08.sh,
              child: CustomLoadingButton(
                text: "Reset".tr,
                onPressed: () {
                  return controller.resetPassword();
                },
              ),
            ));
      },
    );
  }
}
