import '/controller/auth/login_controller.dart';
import '/core/global/widgets/custom_loading_button.dart';
import '/core/theme/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../app_routes.dart';
import '../../widgets/auth/auth_text_form.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      backgroundColor: whiteColor,
      body: SingleChildScrollView(
        child: SafeArea(
          bottom: false,
          child: GetBuilder<LoginController>(
            init: LoginController(),
            builder: (controller) => Form(
              key: controller.loginFormKey,
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: 130.h,
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Gap(10.h),
                        Text(
                          "Welcome Back!".tr,
                          style: TextStyle(
                              fontSize: 17.sp,
                              color: blackColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Login with your email or phone and password".tr,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black54,
                          ),
                        ),
                        Gap(0.03.sh),
                        AuthTextForm(
                          validator: (val) {
                            return controller.validUserData(val);
                          },
                          textFormController: controller.loginController,
                          lable: "Email or Phone".tr,
                          preicon: CupertinoIcons.phone,
                          hintText: "Enter your email or phone".tr,
                        ),
                        Gap(20.h),
                        AuthTextForm(
                          validator: (val) {
                            return controller.validUserData(val);
                          },
                          textFormController: controller.passwordController,
                          onTapIconsuf: () {
                            controller.ontapSupfix();
                          },
                          obscureText: controller.obscureText,
                          lable: "Password".tr,
                          sufcolor: Colors.black54,
                          suficon: controller.obscureText
                              ? Icons.remove_red_eye_outlined
                              : Icons.visibility_off_outlined,
                          preicon: CupertinoIcons.lock,
                          hintText: "Enter password".tr,
                        ),
                        Gap(10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.toNamed(AppRoutes.forgetPassword);
                              },
                              child: Text(
                                "Forget Password?".tr,
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  color: blackColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Gap(0.03.sh),
                        SizedBox(
                          height: 38.h,
                          child: CustomLoadingButton(
                            text: "Login".tr,
                            onPressed: () {
                              return controller.login();
                            },
                            backgroundColor: primaryColor,
                            height: 0.06.sh,
                          ),
                        ),
                        Gap(0.02.sh),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have account?".tr,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black54,
                              ),
                            ),
                            Gap(5.w),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
