import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
import '/models/specialize_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectSpecializationWidget extends StatelessWidget {
  const SelectSpecializationWidget({
    super.key,
    required this.value,
    required this.models,
    required this.onChanged,
  });
  final SpecializeModel value;
  final List<SpecializeModel> models;
  final void Function(SpecializeModel?) onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<SpecializeModel>(
        isExpanded: true,
        value: value, //controller.selectedSpecialization,
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
          label: Text(
            'Select Category',
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
        items: models.map((item) {
          return DropdownMenuItem<SpecializeModel>(
            value: item,
            child: Text(
              translateDatabase(arabic: item.nameAr!, english: item.nameEn!),
              style: TextStyle(
                  fontSize: 12.sp,
                  color: greyColor.withAlpha(160),
                  fontWeight: FontWeight.bold),
            ),
          );
        }).toList(),
        onChanged: onChanged
        // (value) {
        //   controller.onSpecializeChanged(value);
        // },

        );
  }
}
