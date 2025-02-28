import '/core/theme/text_style.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '/core/global/widgets/custom_loading_widget.dart';
import '/core/theme/app_color.dart';

class CustomLoadingButton extends StatelessWidget {
  const CustomLoadingButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.backgroundColor,
      this.height,
      this.width,
      this.alignment,
      this.borderRadius = 30});

  final Function onPressed;
  final String text;
  final Color? backgroundColor;
  final double? height;
  final double? width;
  final Alignment? alignment;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.center,
      child: EasyButton(
        onPressed: () {
          return onPressed();
        },
        type: EasyButtonType.elevated,
        borderRadius: borderRadius,
        buttonColor: backgroundColor ?? primaryColor,
        height: height ?? 0.055.sh,
        width: width ?? 100.sw,
        idleStateWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: getRegularStyle.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
        loadingStateWidget: const CustomLoadingWidget(),
      ),
    );
  }
}
