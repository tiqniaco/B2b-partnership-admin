import '/app_bindings.dart';
import '/core/theme/app_color.dart';
import '/core/theme/themes.dart';
import 'app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/constants/app_constants.dart';
import 'core/localization/localization.dart';

class B2BApp extends StatelessWidget {
  const B2BApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        ScreenUtil.init(context);
        return GetMaterialApp(
          localizationsDelegates: const [
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    FlutterQuillLocalizations.delegate,
  ],
          debugShowCheckedModeBanner: false,
          locale: Get.locale ?? kDefaultLocale,
          defaultTransition: kDefaultAppTransitionAnimation,
          initialBinding: AppBindings(),
          theme: AppThemes.light,
          darkTheme: AppThemes.light,
          color: primaryColor,
          translations: AppLocalization(),
          initialRoute: AppRoutes.initial,
          getPages: AppRoutes.pages,
          title: kAppName,
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
          ),
        );
      },
    );
  }
}
