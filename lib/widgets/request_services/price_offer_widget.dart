import 'package:b2b_partnership_admin/core/functions/get_text_direction.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partnership_admin/core/theme/text_style.dart';
import 'package:b2b_partnership_admin/core/theme/themes.dart';

import '/controller/request_services/service_request_details_controller.dart';
import '/core/theme/app_color.dart';
import '/models/price_offer_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PriceOfferWidget extends GetView<ServiceRequestDetailsController> {
  const PriceOfferWidget({super.key, required this.model});
  final PriceOfferModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          backgroundColor: backgroundColor,
          titlePadding: EdgeInsets.symmetric(vertical: 10),
          title: "Offer Details".tr,
          titleStyle: TextStyle(
              fontSize: 13.sp, color: blackColor, fontWeight: FontWeight.bold),
          content: SizedBox(
            height: 400.h,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildRow("Price".tr, model.requestOfferPrice,
                      Icons.payments_outlined),
                  Gap(16),
                  buildRow("Duration".tr, model.requestOfferDuration,
                      Icons.watch_later_outlined),
                  Gap(16),
                  buildRow("Description".tr, model.offerDescription,
                      Icons.note_alt_outlined),
                  // Gap(24),
                  // InkWell(
                  //   onTap: () {
                  //     // Get.toNamed(
                  //     //     model.userRole == "provider"
                  //     //         ? AppRoutes.providerProfile
                  //     //         : AppRoutes.clientProfile,
                  //     //     arguments: {"id": model.roleId});
                  //   },
                  //   child: Container(
                  //       padding: EdgeInsets.all(10),
                  //       decoration: BoxDecoration(
                  //         color: primaryColor,
                  //         borderRadius: customBorderRadius,
                  //       ),
                  //       alignment: Alignment.center,
                  //       child: Text(
                  //         "View Applicant Profile".tr,
                  //         style: TextStyle(
                  //           fontSize: 14.r,
                  //           color: whiteColor,
                  //           fontWeight: FontWeight.bold,
                  //         ),
                  //       )),
                  // )
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: greyCart,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          children: [
            Container(
              height: 46.h,
              width: 46.h,
              decoration: BoxDecoration(),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CustomNetworkImage(imageUrl: model.userImage)),
            ),
            Gap(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.userName,
                    style: getBoldStyle.copyWith(
                        fontSize: 14.r, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      Text(
                        "Price".tr,
                        style: getMediumStyle.copyWith(fontSize: 14.r),
                      ),
                      Gap(4),
                      Text(
                        model.requestOfferPrice,
                        style: getMediumStyle.copyWith(fontSize: 14.r),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(10),
            Container(
              width: 90.w,
              height: 26.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: customBorderRadius,
                color: primaryColor,
              ),
              child: Text(
                "Accepted".tr,
                style: getLightStyle.copyWith(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow(String title, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: primaryColor),
        borderRadius: customBorderRadius,
      ),
      child: Row(
        children: [
          Icon(icon, color: primaryColor, size: 15.r),
          Gap(10),
          Text(
            "${title.tr}:",
            style: TextStyle(
                fontSize: 13.r, color: blackColor, fontWeight: FontWeight.bold),
          ),
          Gap(8),
          // Spacer(),
          Expanded(
            child: Text(
              value,
              textDirection:
                  containsArabic(value) ? TextDirection.rtl : TextDirection.ltr,
              style: TextStyle(
                  fontSize: 12.r,
                  color: blackColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
