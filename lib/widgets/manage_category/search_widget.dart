import '/core/theme/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 40.h,
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.black12.withAlpha(10)),
        child: Row(
          children: [
            InkWell(
                onTap: () {},
                child: Icon(
                  CupertinoIcons.search,
                  color: greyColor,
                  size: 21.sp,
                )),
            Gap(20),
            Text(
              "Search ...",
              style: TextStyle(
                  fontSize: 14.sp,
                  color: const Color.fromARGB(255, 124, 124, 124),
                  fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Icon(
              FontAwesomeIcons.sliders,
              size: 15.sp,
              color: greyColor,
            )
          ],
        ),
      ),
    );
  }
}
