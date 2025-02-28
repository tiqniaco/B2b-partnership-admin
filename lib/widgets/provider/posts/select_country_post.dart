import '/controller/provider/posts/get_provider_posts_service_controller.dart';
import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
import '/models/country_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SelectCountryPost extends StatelessWidget {
  const SelectCountryPost({
    super.key,
    required this.enabled,
  });

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<GetProviderPostsServiceController>(
      builder: (controller) => DropdownButtonFormField<CountryModel>(
        // value: controller.selectedCountry,
        decoration: InputDecoration(
          enabled: enabled,
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
          hintText: "All Countries",
          label: Text(
            'Select Country',
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
        items: controller.countries.map((item) {
          return DropdownMenuItem<CountryModel>(
            value: item,
            child: Row(
              children: [
                Image.network(
                  item.flag!,
                  width: 23.h,
                  height: 23.h,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 10),
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
          controller.onCountryChanged(value);
        },
      ),
    );
  }
}
