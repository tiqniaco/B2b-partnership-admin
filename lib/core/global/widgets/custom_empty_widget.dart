import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({
    super.key,
    this.height,
    this.text,
  });
  final double? height;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          height: height ?? 0.22.sh,
          child: Lottie.asset(
            "assets/lottie/nodata.json",
            repeat: false,
          ),
        ),
        Text(
          text != null
              ? text!
              : Get.locale?.languageCode == 'ar'
                  ? 'لا يوجد بيانات'
                  : 'No Data',
          style: getMediumStyle.copyWith(
            color: blackWithOpacityColor,
            fontSize: 14.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
