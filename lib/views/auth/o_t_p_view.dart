import '/controller/auth/otp_controller.dart';
import '/core/theme/text_style.dart';

import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OTPView extends StatelessWidget {
  const OTPView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OTPController>(
      init: OTPController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text("Verification Code".tr),
        ),
        body: Stack(
          children: [
            Container(
              width: 1.sw,
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(24.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 30.w,
                    ),
                    child: Text(
                      "We have sent a verification code to your email".tr,
                      textAlign: TextAlign.center,
                      style: getMediumStyle,
                      maxLines: 3,
                    ),
                  ),
                  Gap(24.h),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: OtpTextField(
                      numberOfFields: 6,
                      borderColor: primaryColor,
                      focusedBorderColor: primaryColor,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      fillColor: whiteColor,
                      filled: true,

                      fieldWidth: 0.128.sw,
                      // styles: [
                      //   getSemiBoldStyle,
                      //   getSemiBoldStyle,
                      //   getSemiBoldStyle,
                      //   getSemiBoldStyle,
                      //   getSemiBoldStyle,
                      //   getSemiBoldStyle,
                      // ],
                      contentPadding: EdgeInsets.zero,
                      borderRadius: BorderRadius.circular(10),
                      showFieldAsBox: true,
                      keyboardType: TextInputType.number,
                      textStyle: getSemiBoldStyle.copyWith(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      onCodeChanged: (String code) {
                        controller.onCodeChange(code);
                      },
                      onSubmit: (String verificationCode) {
                        controller.onCodeSubmit(verificationCode);
                      }, // end onSubmit
                    ),
                  ),
                  Gap(15.h),
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: InkWell(
                      onTap: () {
                        controller.resendOTP();
                      },
                      child: Text(
                        'Re Send'.tr,
                        textAlign: TextAlign.start,
                        style: getSemiBoldStyle.copyWith(
                            color: secondaryColor, fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (controller.isLoading)
              Container(
                width: 1.sw,
                height: 1.sh,
                color: Colors.black26.withAlpha(80),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...[
                      Container(
                        width: 100.w,
                        height: 100.w,
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            Gap(12.h),
                            if (controller.message.isNotEmpty)
                              Text(
                                controller.message,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                  color: primaryColor,
                                ),
                              ),
                          ],
                        ),
                      )
                    ],
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
