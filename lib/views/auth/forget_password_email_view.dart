import '/controller/auth/forget_password_controller.dart';
import '/core/global/widgets/custom_loading_button.dart';
import '/core/theme/text_style.dart';
import '/widgets/auth/auth_text_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ForgetPasswordEmailView extends StatelessWidget {
  const ForgetPasswordEmailView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      init: ForgetPasswordController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Forget Password".tr),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 40.h),
              child: Form(
                key: controller.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Please enter your email to send an OTP to reset your password"
                          .tr,
                      textAlign: TextAlign.center,
                      style: getMediumStyle,
                      maxLines: 3,
                    ),
                    Gap(25.h),
                    AuthTextForm(
                      textFormController: controller.emailController,
                      lable: "Email".tr,
                      preicon: CupertinoIcons.mail,
                      hintText: 'Email Address'.tr,
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Email in required".tr;
                        } else if (!GetUtils.isEmail(value ?? "")) {
                          return 'please enter a valid email'.tr;
                        }
                        return null;
                      },
                    ),
                    Gap(20.h),
                    CustomLoadingButton(
                      text: "Send".tr,
                      onPressed: () {
                        return controller.sendOtp();
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
