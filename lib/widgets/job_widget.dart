import 'package:b2b_partnership_admin/app_routes.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/core/theme/text_style.dart';
import 'package:b2b_partnership_admin/core/utils/font_manager.dart';
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
                      Text(
                        "${"Company".tr}: ${model.name}",
                        style: getRegularStyle.copyWith(
                          fontWeight: FontManager.mediumFontWeight,
                        ),
                      ),
                      Gap(5.h),
                      Text(
                        "${"Job Title".tr}: ${model.title}",
                        style: getRegularStyle.copyWith(
                          fontWeight: FontManager.mediumFontWeight,
                        ),
                      ),
                      Gap(5.h),
                      Text(
                        "${"Contract Type".tr}: ${model.contractType.name}",
                        style: getLightStyle,
                      ),
                      Gap(5.h),
                      Text(
                        "${"Expiry Date".tr}: ${model.expiryDate}",
                        style: getLightStyle,
                      ),
                      if (model.salary != "null") ...[
                        Gap(5.h),
                        Text(
                          "${"Salary".tr}: ${model.salary}",
                          style: getLightStyle,
                        )
                      ],
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
