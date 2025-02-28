import '/controller/search/search_controller.dart';
import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
import '/models/sub_specialize_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SelectSupSpecializationFilter extends StatelessWidget {
  const SelectSupSpecializationFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchControllerIM>(
      builder: (controller) => DropdownButtonFormField<SubSpecializeModel>(
        value: controller.selectedSubSpecialization, //CountryModel
        decoration: InputDecoration(
          contentPadding:
              EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.r),
            borderSide: const BorderSide(color: blackColor, width: 1),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7),
            borderSide: const BorderSide(color: pageColor, width: 1.5),
          ),
          hintText: "All sub Categories",
          label: Text(
            'Select Sub Category',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 17.sp,
                color: Colors.black87),
          ),
        ),
        icon: Icon(
          Icons.keyboard_arrow_down_outlined,
          size: 23.sp,
          color: greyColor,
        ),
        items: controller.subSpecializations.map((item) {
          return DropdownMenuItem<SubSpecializeModel>(
            value: item,
            child: Row(
              children: [
                Text(
                  translateDatabase(
                      arabic: item.nameAr!, english: item.nameEn!),
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: greyColor.withAlpha(160),
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }).toList(),
        onChanged: (value) {
          controller.onSubSpecializeChanged(value);
        },
      ),
    );
  }
}
