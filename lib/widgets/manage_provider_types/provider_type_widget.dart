import 'package:b2b_partnership_admin/controller/manage_provider_types/manage_provider_types_controller.dart';
import 'package:b2b_partnership_admin/models/provider_type_model.dart';
import 'package:gap/gap.dart';
import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProviderTypeWidget extends StatelessWidget {
  const ProviderTypeWidget({super.key, required this.types});
  final List<ProviderTypeModel> types;

  @override
  Widget build(BuildContext context) {
    Get.put(ManageProviderTypesController());
    return GetBuilder<ManageProviderTypesController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: types.map((type) {
            return Container(
              // width: MediaQuery.of(context).size.width * 0.4,
              // height: 100.h,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.withAlpha(80)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    translateDatabase(
                      arabic: type.nameAr!,
                      english: type.nameEn!,
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: blackColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Gap(10.w),
                  InkWell(
                      onTap: () {
                        Get.defaultDialog(
                          title: 'Delete Type',
                          titleStyle: TextStyle(fontSize: 13.sp),
                          middleText:
                              'Are you sure you want to\ndelete this type?',
                          textConfirm: 'Yes',
                          textCancel: 'No',
                          onConfirm: () {
                            controller.deleteProviderType(type.id!);
                          },
                        );
                        // city(city.id!);
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
