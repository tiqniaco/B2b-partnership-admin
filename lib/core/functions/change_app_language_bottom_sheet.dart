import '/core/enums/language_enum.dart';
import '/core/localization/app_strings.dart';
import '/core/utils/assets_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'change_app_lang.dart';

changeLanguageButtonSheet() {
  Get.bottomSheet(
    Container(
      height: 0.2.sh,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        color: Colors.white,
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(AppStrings.english.tr),
            leading: Image.asset(
              AssetsData.englishImage,
              width: 20.w,
            ),
            onTap: () {
              changeAppLang(
                context: Get.context!,
                lang: LanguageEnum.en,
              );
            },
          ),
          ListTile(
            title: Text(AppStrings.arabic.tr),
            leading: Image.asset(
              AssetsData.arabicImage,
              width: 20.w,
            ),
            onTap: () {
              changeAppLang(
                context: Get.context!,
                lang: LanguageEnum.ar,
              );
            },
          ),
        ],
      ),
    ),
  );
}
