import 'package:b2b_partnership_admin/controller/manage_location/manage_location_controller.dart';
import 'package:b2b_partnership_admin/models/country_model.dart';

import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CountryWidget extends StatelessWidget {
  CountryWidget({super.key, required this.countries, required this.length});
  final List<CountryModel> countries;
  final int length;
  final controller =
      Get.put(ManageLocationController()); // ManageCategoriesController(),
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageLocationController>(
        builder: (controller) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: countries.map((country) {
                  return InkWell(
                    onTap: () {
                      controller.onTapCountry(country);
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                      decoration: BoxDecoration(
                          color: controller.selectedId == country.id
                              ? primaryColor.withAlpha(40)
                              : pageColor.withAlpha(60),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.withAlpha(80))),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            country.flag!,
                            style: TextStyle(
                              fontSize: 23.sp,
                            ),
                          ),
                          Gap(10.w),
                          Text(
                            translateDatabase(
                                arabic: country.nameAr!,
                                english: country.nameEn!),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w400),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Gap(15.w),
                          InkWell(
                              onTap: () {
                                controller.onTapCountry(country);
                                onTapMoreIcon(country.id!, model: country);
                              },
                              child: Icon(Icons.more_vert, size: 17.sp)),
                          Gap(5)
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ));
  }

  onTapMoreIcon(int id, {required CountryModel model}) {
    return Get.defaultDialog(
        titlePadding: EdgeInsets.zero,
        title: " ".tr,
        content: GetBuilder<ManageLocationController>(
            builder: (con) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "More Options:".tr,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 17.sp,
                          ),
                        ),
                        Gap(20.h),
                        Divider(),
                        Gap(10.h),
                        InkWell(
                          onTap: () {
                            Get.back();
                            Get.defaultDialog(
                              titlePadding: EdgeInsets.symmetric(vertical: 10),
                              title: "Delete Country".tr,
                              contentPadding: EdgeInsets.only(bottom: 15.h),
                              content: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Are you sure to delete?"
                                      .tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ),
                              onConfirm: () => controller.deleteCountry(id),
                              textConfirm: "Yes".tr,
                              textCancel: "No".tr,
                              onCancel: () {},
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                size: 20.sp,
                              ),
                              Gap(10.w),
                              Text(
                                "Delete".tr,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: blackColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ]),
                )));
  }
}
