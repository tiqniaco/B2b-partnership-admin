import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';
import '/core/utils/assets_data.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    this.message,
  });
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 0.25.sh,
      child: Column(
        children: [
          Lottie.asset(
            AssetsData.serverErrorAnimation,
            repeat: false,
            height: 0.21.sh,
          ),
          Text(
            message != null
                ? message ?? ''
                : Get.locale?.languageCode == 'ar'
                    ? 'حدث خطأ ما، يرجى المحاولة مرة أخرى'
                    : 'Error occurred, please try again later!',
            style: getMediumStyle.copyWith(
              color: blackWithOpacityColor,
              fontSize: 16.sp,
            ),
          ),
        ],
      ),
    );
  }
}
