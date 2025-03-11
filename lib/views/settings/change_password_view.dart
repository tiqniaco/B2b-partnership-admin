import '/controller/settings/change_password_controller.dart';
import '/core/global/widgets/custom_loading_button.dart';
import '/core/theme/text_style.dart';
import '/widgets/auth/auth_text_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChangePasswordController>(
      init: ChangePasswordController(),
      builder: (ChangePasswordController controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Change Password".tr),
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
                      "Please enter your old, new and confirm new Password".tr,
                      textAlign: TextAlign.center,
                      style: getMediumStyle.copyWith(height: 1.5),
                      maxLines: 3,
                    ),
                    Gap(25.h),
                    AuthTextForm(
                      textFormController: controller.oldPasswordController,
                      lable: "Old Password".tr,
                      preicon: CupertinoIcons.lock,
                      hintText: 'Old Password'.tr,
                      obscureText: controller.oldPasswordObscure,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Old Password is required".tr;
                        } else if (value.length < 6) {
                          return "Password must be >= 6 letter".tr;
                        }
                        return null;
                      },
                      onTapIconsuf: controller.changeOldPasswordVisibility,
                      suficon: controller.oldPasswordObscure
                          ? Icons.remove_red_eye_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    Gap(10.h),
                    AuthTextForm(
                      textFormController: controller.newPasswordController,
                      lable: "New Password".tr,
                      preicon: CupertinoIcons.lock,
                      hintText: 'New Password'.tr,
                      obscureText: controller.newPasswordObscure,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "New Password is required".tr;
                        } else if (value.length < 6) {
                          return "Password must be >= 6 letter".tr;
                        }
                        return null;
                      },
                      onTapIconsuf: controller.changeNewPasswordVisibility,
                      suficon: controller.newPasswordObscure
                          ? Icons.remove_red_eye_outlined
                          : Icons.visibility_off_outlined,
                    ),
                    Gap(10.h),
                    AuthTextForm(
                      textFormController: controller.confirmPasswordController,
                      lable: "Confirm Password".tr,
                      preicon: CupertinoIcons.lock,
                      hintText: 'Confirm Password'.tr,
                      obscureText: controller.confirmPasswordObscure,
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
                      onTapIconsuf: controller.changeConfirmPasswordVisibility,
                      suficon: controller.confirmPasswordObscure
                          ? Icons.remove_red_eye_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            notchMargin: 10,
            height: 0.08.sh,
            child: CustomLoadingButton(
              text: "Change".tr,
              onPressed: () {
                return controller.changePassword();
              },
            ),
          ),
        );
      },
    );
  }
}
