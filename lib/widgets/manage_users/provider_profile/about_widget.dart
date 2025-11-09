import 'package:b2b_partnership_admin/controller/manage_users/provider_profile/provider_profile_controller.dart';
import 'package:b2b_partnership_admin/core/functions/get_text_direction.dart';
import 'package:b2b_partnership_admin/core/functions/translate_database.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/core/theme/text_style.dart';
import 'package:b2b_partnership_admin/widgets/app_pdf_view.dart';
import 'package:b2b_partnership_admin/widgets/manage_users/provider_profile/about_content_widget.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(
                thickness: 3,
              ),
              Gap(10),
              titleWidget("Country".tr),
              Gap(5.h),
              valueWidget(translateDatabase(
                  arabic: controller.providerModel!.countryNameAr,
                  english: controller.providerModel!.countryNameEn)),
              Gap(20),
              titleWidget("City".tr),
              Gap(5.h),
              valueWidget(translateDatabase(
                  arabic: controller.providerModel!.governmentNameAr,
                  english: controller.providerModel!.governmentNameEn)),
              Gap(20),
              titleWidget("Phone".tr),
              Gap(5.h),
              valueWidget(
                  "+${controller.providerModel!.countryCode}${controller.providerModel!.phone}"),
              Gap(20),
              titleWidget("Email".tr),
              Gap(5.h),
              valueWidget(controller.providerModel!.email),
              Gap(20),
              Text(
                "Provider Type".tr,
                style: getRegularStyle.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
              Gap(5.h),
              Text(
                translateDatabase(
                    arabic: controller.providerModel!.providerTypeNameAr,
                    english: controller.providerModel!.providerTypeNameEn),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: context.isTablet ? 8.sp : 14.sp,
                  color: Colors.black,
                ),
              ),
              if (controller.providerModel!.commercialRegisterNumber != "") ...[
                Gap(20),
                titleWidget("Commercial No.".tr),
                Gap(5.h),
                valueWidget(controller.providerModel!.commercialRegisterNumber
                    .toString()),
                Gap(20),
                titleWidget("VAT No.".tr),
                Gap(5.h),
                valueWidget(controller.providerModel!.vat.toString())
              ],
              if (controller.providerModel!.commercialRegisterNumber != "") ...[
                Gap(20.h),
                titleWidget("Tax No.".tr),
                Gap(5.h),
                valueWidget(controller.providerModel!.taxCardNumber),
                // Gap(20.h),
              ],
              Gap(20),
              Text(
                "Bio",
                style: getRegularStyle.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
              Gap(10),
              Text(
                controller.providerModel!.bio,
                textDirection: containsArabic(controller.providerModel!.bio)
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: context.isTablet ? 8.sp : 14.sp,
                  color: Colors.black,
                ),
              ),
              Gap(15.h),
              if (controller.providerModel!.commercialRegisterNumber != "") ...[
                Row(
                  children: [
                    Text(
                      "${"Commercial Papers".tr}: ",
                      style: getRegularStyle.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => AppPdfView(
                            url: controller.providerModel!.commercialRegister,
                          ),
                        );
                      },
                      child: Text(
                        "View".tr,
                        style: getRegularStyle.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 200.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: PDF().cachedFromUrl(
                      controller.providerModel!.commercialRegister,
                      placeholder: (progress) =>
                          Center(child: Text('loading...'.tr)),
                      errorWidget: (error) =>
                          Center(child: Text(error.toString())),
                    ),
                  ),
                ),
                Gap(40),
                Row(
                  children: [
                    Gap(10),
                    Text(
                      "${"Tax Papers".tr}: ",
                      style: getRegularStyle.copyWith(
                        color: Colors.black54,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        Get.to(
                          () => AppPdfView(
                            url: controller.providerModel!.taxCard,
                          ),
                        );
                      },
                      child: Text(
                        "View".tr,
                        style: getRegularStyle.copyWith(
                            color: primaryColor, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                Gap(20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 270,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: PDF().cachedFromUrl(
                      controller.providerModel!.taxCard,
                      placeholder: (progress) =>
                          Center(child: Text('loading...')),
                      errorWidget: (error) =>
                          Center(child: Text(error.toString())),
                    ),
                  ),
                ),
                Gap(100),
              ]
            ],
          ),
        ),
      );
    });
  }
}
