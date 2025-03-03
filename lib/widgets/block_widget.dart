import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

Widget blockWidget(Color color, String title, IconData icon, Function() onTap) {
  {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100.h,
        height: 120.h,
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color.withAlpha(60),
          borderRadius: BorderRadius.circular(12),
          // border: Border.all(color: Colors.grey.withAlpha(80)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  // border: Border.all(color: primaryColor, width: 0.5),
                  // color: pageColor.withAlpha(60),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 27.sp,
                )),
            Gap(8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
