import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PrintType extends StatelessWidget {
  const PrintType({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    return switch (type) {
      "pending" => containerType("Pending".tr, greyColor),
      "active" => containerType("Active".tr, orange),
      "completed" => containerType("Complete".tr, green),
      "canceled" => containerType("Checked".tr, redColor),
      "delivered" => containerType("Delivered".tr, Colors.blue),
      _ => containerType("Unknown".tr, Colors.black)
    };
  }

  Widget containerType(String title, Color color) {
    return Container(
      height: 27.h,
      padding:
          EdgeInsets.symmetric(horizontal: Get.context!.isTablet ? 6.w : 10.w),
      decoration: BoxDecoration(
          color: pageColor.withAlpha(80),
          borderRadius: BorderRadius.circular(30)),
      alignment: Alignment.center,
      child: Text(
        title,
        style: getLightStyle.copyWith(
          fontSize: Get.context!.isTablet ? 7.5.sp : null,
          color: whiteColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
