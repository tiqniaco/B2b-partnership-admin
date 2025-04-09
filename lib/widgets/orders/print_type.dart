import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PrintType extends StatelessWidget {
  const PrintType({super.key, required this.type});
  final String type;
  @override
  Widget build(BuildContext context) {
    return switch (type) {
      "pending" => containerType("Pending".tr, Colors.teal),
      "approved" => containerType("Active".tr, orange),
      "completed" => containerType("Complete".tr, green),
      "canceled" => containerType("Checked".tr, redColor),
      "delivered" => containerType("Delivered".tr, Colors.blue),
      _ => containerType(
          "Unknown".tr,
          whiteColor,
        )
    };
  }

  Widget containerType(String title, Color color) {
    return Material(
      color: color,
      borderRadius: BorderRadius.circular(5.r),
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 5.h,
        ),
        child: Text(
          title,
          style: getLightStyle.copyWith(
            fontSize: Get.context!.isTablet ? 7.5.sp : null,
            color: whiteColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
