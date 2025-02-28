import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '/core/utils/assets_data.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
    super.key,
    this.backgroundColor,
    this.height,
  });
  final Color? backgroundColor;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.all(10.w),
      height: height ?? .25.sh,
      alignment: Alignment.center,
      child: Lottie.asset(
        AssetsData.loadingAnimation,
        repeat: true,
        height: height != null ? (height! - 0.03) : 0.21.sh,
      ),
    );
  }
}
