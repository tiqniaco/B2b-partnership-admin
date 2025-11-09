import 'package:b2b_partnership_admin/controller/service_details_controller.dart';
import 'package:b2b_partnership_admin/core/functions/get_year_date.dart';
import 'package:b2b_partnership_admin/core/functions/translate_database.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/core/theme/text_style.dart';
import 'package:b2b_partnership_admin/widgets/manage_users/provider_profile/about_content_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SellerWidget extends StatelessWidget {
  const SellerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ServiceDetailsController());
    return GetBuilder<ServiceDetailsController>(builder: (controller) {
      return Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Gap(20),
            InkWell(
              // onTap: () {
              //   Get.toNamed(AppRoutes.providerProfile, arguments: {
              //     'id': controller.service!.provider!.providerId
              //   });
              // },
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 27.r,
                    backgroundImage: CachedNetworkImageProvider(
                        controller.service!.provider!.image),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.service!.provider!.name,
                        style: getMediumStyle.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Gap(8),
                      Row(
                        children: [
                          Text(
                            'Seller Rating'.tr,
                            style: getLightStyle.copyWith(
                              color: Colors.black54,
                            ),
                          ),
                          Gap(10),
                          Text(
                            controller.service!.provider!.rating,
                            style: getMediumStyle.copyWith(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold),
                          ),
                          Gap(3),
                          Icon(
                            Icons.circle,
                            size: 3.r,
                            color: greyColor,
                          ),
                          Gap(3),
                          Icon(
                            Icons.star,
                            size: 15.r,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Gap(20),
            Container(
              padding: EdgeInsets.all(20),
              height: 160.h,
              decoration: BoxDecoration(
                border: Border.all(
                  color: borderColor,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleWidget("From".tr),
                      Gap(10),
                      valueWidget(translateDatabase(
                          arabic: controller.service!.provider!.countryNameAr,
                          english:
                              controller.service!.provider!.countryNameEn)),
                      Spacer(),
                      titleWidget("Provider type".tr),
                      Gap(10),
                      valueWidget(translateDatabase(
                          arabic:
                              controller.service!.provider!.providerTypeNameAr,
                          english: controller
                              .service!.provider!.providerTypeNameEn)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleWidget("City".tr),
                      Gap(10),
                      valueWidget(translateDatabase(
                          arabic:
                              controller.service!.provider!.governmentNameAr,
                          english:
                              controller.service!.provider!.governmentNameEn)),
                      Spacer(),
                      titleWidget("Seller Since".tr),
                      Gap(10),
                      valueWidget(
                          getYear(controller.service!.provider!.createdAt)
                              .toString()),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
