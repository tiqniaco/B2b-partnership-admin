import '/controller/service_details_controller.dart';
import '/core/functions/get_year_date.dart';
import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
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
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.grey[200],
                  radius: 27.sp,
                  backgroundImage: CachedNetworkImageProvider(
                      controller.service!.provider!.image!),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.service!.provider!.name!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.sp),
                    ),
                    Gap(8),
                    Row(
                      children: [
                        Text(
                          'Seller Rating'.tr,
                          style: TextStyle(color: Colors.black54),
                        ),
                        Gap(10),
                        Text(
                          controller.service!.provider!.rating!,
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Gap(3),
                        Icon(
                          Icons.circle,
                          size: 3.sp,
                          color: greyColor,
                        ),
                        Gap(3),
                        Icon(
                          Icons.star,
                          size: 15.sp,
                          color: Colors.orange,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
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
                          arabic: controller.service!.provider!.countryNameAr!,
                          english:
                              controller.service!.provider!.countryNameEn!)),
                      Spacer(),
                      titleWidget("Seller Since".tr),
                      Gap(10),
                      valueWidget(
                          getYear(controller.service!.provider!.createdAt!)
                              .toString()),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      titleWidget("Department".tr),
                      Gap(10),
                      valueWidget(translateDatabase(
                          arabic: controller
                              .service!.provider!.specializationNameAr!,
                          english: controller
                              .service!.provider!.specializationNameEn!)),
                      Spacer(),
                      titleWidget("Specialization".tr),
                      Gap(10),
                      valueWidget(translateDatabase(
                          arabic: controller
                              .service!.provider!.subSpecializationNameAr!,
                          english: controller
                              .service!.provider!.subSpecializationNameEn!)),
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

  Widget titleWidget(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 15.sp, color: Colors.black54),
    );
  }

  Widget valueWidget(String value) {
    return Text(
      value,
      style: TextStyle(
          fontSize: 16.sp, color: blackColor, fontWeight: FontWeight.w500),
    );
  }
}
