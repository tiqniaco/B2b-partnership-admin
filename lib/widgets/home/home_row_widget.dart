import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class HomeRowWidget extends StatelessWidget {
  const HomeRowWidget({super.key, required this.title, required this.onTap});
  final String title;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title,
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
                fontSize: 17.sp)),
        Spacer(),
        InkWell(
          onTap: onTap,
          child: Row(
            children: [
              Text(
                "See all",
                style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp),
              ),
              Gap(10),
              Icon(
                Icons.arrow_forward_ios,
                size: 15.sp,
                color: primaryColor,
              )
            ],
          ),
        )
      ],
    );
  }
}
