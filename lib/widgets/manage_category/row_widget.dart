import 'package:get/get.dart';

import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class RowWidget extends StatelessWidget {
  const RowWidget({super.key, required this.title, required this.onTap});
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
                "add more".tr,
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: greyColor,
                    color: greyColor,
                    //fontWeight: FontWeight.w500,
                    fontSize: 14.sp),
              ),
              Gap(10),
              Icon(
                Icons.add,
                size: 17.sp,
                color: greyColor,
              )
            ],
          ),
        )
      ],
    );
  }
}
