import 'package:b2b_partnership_admin/controller/manage_categories/manage_categories_controller.dart';
import 'package:gap/gap.dart';
import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
import '/models/sub_specialize_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SubCategoryWidget extends StatelessWidget {
  const SubCategoryWidget({super.key, required this.subSpecializations});
  final List<SubSpecializeModel> subSpecializations;

  @override
  Widget build(BuildContext context) {
    Get.put(ManageCategoriesController());
    return GetBuilder<ManageCategoriesController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: subSpecializations.map((subSpecialization) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.withAlpha(80)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      translateDatabase(
                        arabic: subSpecialization.nameAr!,
                        english: subSpecialization.nameEn!,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  Gap(10.w),
                  InkWell(
                      onTap: () {
                        Get.defaultDialog(
                          title: 'Delete Sub Category'.tr,
                          titleStyle: TextStyle(fontSize: 13.sp),
                          middleText: "Are you sure to delete?".tr,
                          textConfirm: 'Yes',
                          textCancel: 'No',
                          onConfirm: () {
                            controller
                                .deleteSubSpecialization(subSpecialization.id!);
                            Get.back();
                          },
                        );
                      },
                      child: Icon(Icons.remove_circle,
                          color: primaryColor, size: 20.sp)),
                ],
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
