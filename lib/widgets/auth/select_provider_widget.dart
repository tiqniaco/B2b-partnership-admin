import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
import '/models/provider_type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectProviderWidget extends StatelessWidget {
  const SelectProviderWidget({
    super.key,
    required this.onChanged,
    required this.value,
    required this.providerTypes,
  });

  final void Function(ProviderTypeModel?)? onChanged;
  final ProviderTypeModel? value;
  final List<ProviderTypeModel> providerTypes;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<ProviderTypeModel>(
      value: value,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
          borderSide: const BorderSide(color: blackColor, width: 1),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7),
          borderSide: const BorderSide(color: pageColor, width: 1.5),
        ),
        label: Text(
          'Provider Type',
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
      items: providerTypes.map((item) {
        return DropdownMenuItem<ProviderTypeModel>(
          value: item,
          child: Row(
            children: [
              Text(
                translateDatabase(arabic: item.nameAr!, english: item.nameEn!),
                style: TextStyle(
                    fontSize: 12.sp,
                    color: greyColor.withAlpha(160),
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
