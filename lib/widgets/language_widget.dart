import '/core/enums/language_enum.dart';
import '/core/functions/change_app_lang.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';
import '/core/utils/assets_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LanguageWidget extends StatelessWidget {
  const LanguageWidget({super.key, this.gradient});
  final Gradient? gradient;

  /// final LocalController localcontroller = Get.put(LocalController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(Container(
          height: 0.2.sh,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            color: Colors.white,
          ),
          padding: EdgeInsets.symmetric(
            // horizontal: 10.w,
            vertical: 10.h,
          ),
          child: Column(
            children: [
              ListTile(
                title: Text(
                  "English".tr,
                  style: getRegularStyle,
                ),
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
                title: Text(
                  'العربية',
                  style: getRegularStyle,
                ),
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
        ));
      },
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.sp,
            backgroundColor: borderColor.withAlpha(30),
            child: Icon(
              Icons.language,
              color: Colors.black54,
              size: 20.sp,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            "Change Language".tr,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
          ),
          const Spacer(),
          Text(
            Get.locale?.languageCode == 'ar' ? 'العربية 🇸🇦' : 'English 🇬🇧',
            style: getRegularStyle.copyWith(
              shadows: [
                const Shadow(
                  blurRadius: 10.0,
                  color: Colors.white, //.withOpacity(0.7),
                  offset: Offset(5.0, 5.0),
                ),
              ],
              fontVariations: [
                const FontVariation('wght', 400),
                const FontVariation('wdth', 100),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
