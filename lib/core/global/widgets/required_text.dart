import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RequiredText extends StatelessWidget {
  const RequiredText({
    super.key,
    required this.title,
    this.titleStyle,
  });
  final String title;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(end: 8.w),
          child: Text(
            title,
            style: titleStyle,
          ),
        ),
        const PositionedDirectional(
          end: 0,
          top: 0,
          child: Text(
            "*",
            style: TextStyle(
              color: dangerColor,
            ),
          ),
        ),
      ],
    );
  }
}
