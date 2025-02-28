import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';
import '/core/utils/assets_data.dart';

class CustomNoConnectionWidget extends StatelessWidget {
  const CustomNoConnectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 0.25.sh,
      child: Column(
        children: [
          Lottie.asset(
            AssetsData.noConnectionAnimation,
            repeat: true,
            height: 0.21.sh,
          ),
          Text(
            Get.locale?.languageCode == 'ar'
                ? 'لا يوجد اتصال بالانترنت'
                : 'No Internet Connection',
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
