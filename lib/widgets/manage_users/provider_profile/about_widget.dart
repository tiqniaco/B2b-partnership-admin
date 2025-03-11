import 'package:b2b_partnership_admin/app_routes.dart';

import '../../../controller/manage_users/provider_profile/provider_profile_controller.dart';
import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AboutWidget extends StatelessWidget {
  const AboutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProviderProfileController());
    return GetBuilder<ProviderProfileController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Gap(20),
              Divider(
                thickness: 3,
              ),
              Gap(10),
              titleWidget("Name".tr, controller.providerModel!.name!,
                  CupertinoIcons.person),
              Gap(15),

              titleWidget(
                  "Phone".tr,
                  "+${controller.providerModel!.countryCode!}${controller.providerModel!.phone!}",
                  CupertinoIcons.phone),
              Gap(15),
              titleWidget(
                  "Department".tr,
                  "${translateDatabase(arabic: controller.providerModel!.specializationNameAr!, english: controller.providerModel!.specializationNameEn!)}",
                  CupertinoIcons.rectangle_3_offgrid),
              Gap(15),
              titleWidget(
                  "Specialization".tr,
                  "${translateDatabase(arabic: controller.providerModel!.subSpecializationNameAr!, english: controller.providerModel!.subSpecializationNameEn!)}",
                  Icons.account_tree_outlined),
              Gap(15),
              titleWidget("Email".tr, controller.providerModel!.email!,
                  CupertinoIcons.mail),
              Gap(15),
              titleWidget(
                  "From".tr,
                  "${translateDatabase(arabic: controller.providerModel!.countryNameAr!, english: controller.providerModel!.countryNameEn!)}",
                  CupertinoIcons.map_pin_ellipse),
              Gap(15),
              titleWidget(
                  "City".tr,
                  "${translateDatabase(arabic: controller.providerModel!.governmentNameAr!, english: controller.providerModel!.governmentNameEn!)}",
                  Icons.location_city),
              Gap(20),
              Row(
                children: [
                  Gap(10),
                  Text(
                    "${"Commercial Papers".tr}: ",
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.pdfView, arguments: {
                        "file": controller.providerModel!.commercialRegister
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          "View".tr,
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Gap(5.w),
                        Icon(Icons.arrow_circle_right_outlined,
                            size: 20.sp, color: primaryColor)
                      ],
                    ),
                  ),
                ],
              ),
              Gap(20),
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: primaryColor, width: 2)
                  ),
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: PDF().cachedFromUrl(
                      controller.providerModel!.commercialRegister!,
                      placeholder: (progress) =>
                          Center(child: Text('loading...'.tr)),
                      errorWidget: (error) =>
                          Center(child: Text(error.toString())),
                    ),
                  ),
                ),
              ),
              Gap(40),
              Row(
                children: [
                  Gap(10),
                  Text(
                    "${"Tax Papers".tr}: ",
                    style: TextStyle(
                        fontSize: 13.sp,
                        color: blackColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.pdfView, arguments: {
                        "file": controller.providerModel!.taxCard
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          "View".tr,
                          style: TextStyle(
                              fontSize: 13.sp,
                              color: primaryColor,
                              fontWeight: FontWeight.w500),
                        ),
                        Gap(5.w),
                        Icon(Icons.arrow_circle_right_outlined,
                            size: 20.sp, color: primaryColor)
                      ],
                    ),
                  ),
                ],
              ),
              Gap(20),
              Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    // border: Border.all(color: primaryColor, width: 2)
                  ),
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: PDF().cachedFromUrl(
                      controller.providerModel!.taxCard!,
                      placeholder: (progress) =>
                          Center(child: Text('loading...'.tr)),
                      errorWidget: (error) =>
                          Center(child: Text(error.toString())),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget titleWidget(String title, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Gap(10),
              Text(
                "$title: ",
                style: TextStyle(
                    fontSize: 13.sp,
                    color: blackColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        //Gap(10.w),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Gap(30.w),
              Text(
                value,
                style: TextStyle(fontSize: 13.sp, color: Colors.black54),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
              ),
            ],
          ),
        )
      ],
    );
  }
}
