import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget(
      {super.key,
      required this.image,
      required this.title,
      required this.description,
      required this.buttonTitle,
      required this.onPressed});
  final String image;
  final String title;
  final String description;
  final String buttonTitle;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: primaryColor, width: 0)),
      height: 133.h,
      width: double.infinity,
      child: Stack(
        children: [
          ClipRRect(
              child: Image.asset(
            image, // "assets/images/man.jpeg",
            fit: BoxFit.cover,
            width: double.infinity,
          )),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title, //"Need Custom Service?",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  description,
                  // "you can post your custom services",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.normal),
                ),
                Gap(20),
                ElevatedButton(
                    style: ButtonStyle(
                        padding: WidgetStatePropertyAll(
                            EdgeInsets.symmetric(horizontal: 10)),
                        backgroundColor: WidgetStatePropertyAll(whiteColor)),
                    onPressed: onPressed,
                    child: Text(
                      buttonTitle,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.sp,
                          color: blackColor),
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
