import 'dart:async';

import '../enums/language_enum.dart';
import '../../app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_constants.dart';
import '/core/services/app_prefs.dart';

Future<void> changeAppLang({
  required LanguageEnum lang,
  required BuildContext context,
}) async {
  await Get.updateLocale(Locale(lang.name));
  kAppLanguageCode = lang.name;
  await Get.find<AppPreferences>().setAppLanguageCode(lang.name);
  Get.offAllNamed(AppRoutes.initial);
}
