import '/core/localization/app_strings.dart';
import '/core/theme/app_color.dart';
import 'package:get/get.dart';

class AppSnackBars {
  static success({
    required String message,
    String? title,
  }) {
    Get.snackbar(
      title ?? AppStrings.success.tr,
      message,
      backgroundColor: successColor,
      colorText: whiteColor,
    );
  }

  static warning({
    required String message,
    String? title,
  }) {
    Get.snackbar(
      title ?? AppStrings.warning.tr,
      message,
      backgroundColor: warningColor,
      colorText: blackColor,
    );
  }

  static error({
    required String message,
    String? title,
  }) {
    Get.snackbar(
      title ?? AppStrings.error.tr,
      message,
      backgroundColor: dangerColor,
      colorText: whiteColor,
    );
  }
}
