import 'package:b2b_partnership_admin/app_routes.dart';
import 'package:b2b_partnership_admin/core/functions/get_text_direction.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/core/theme/themes.dart';
import 'package:b2b_partnership_admin/models/job_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class JobWidget extends StatelessWidget {
  const JobWidget({super.key, required this.model, required this.onTapDelete});
  final JobDetailsModel model;
  final void Function() onTapDelete;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          AppRoutes.jobDetails,
          arguments: {
            "job": model,
          },
        );
      },
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 10.h,
            ),
            decoration: BoxDecoration(
              color: whiteColor,
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: whiteColor,
                  radius: 35.r,
                  child: CustomNetworkImage(
                    imageUrl: model.image,
                    fit: BoxFit.contain,
                    shape: BoxShape.circle,
                  ),
                ),
                Gap(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      rowWidget("Job Title".tr, model.title, context),
                      Gap(5),
                      rowWidget(
                          "Contract Type".tr, model.contractType.name, context),
                      Gap(5),
                      rowWidget("Expiry Date".tr, model.expiryDate, context),
                      if (model.salary != "null") ...[
                        Gap(5),
                        rowWidget("Salary".tr, model.salary, context),
                      ],
                      Gap(10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: customBorderRadius,
                            ),
                            child: Text(
                              "View Now".tr,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.r,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          InkWell(
              onTap: onTapDelete,
              child: Icon(Icons.remove_circle, size: 25.sp, color: Colors.red))
        ],
      ),
    );
  }
}

Widget rowWidget(String title, String value, BuildContext context) {
  return Row(
    children: [
      Text(
        "$title:",
        style: TextStyle(fontSize: 12.r),
      ),
      Gap(8),
      Expanded(
        child: Text(
          value,
          textDirection:
              containsArabic(value) ? TextDirection.rtl : TextDirection.ltr,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12.r,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ],
  );
}
