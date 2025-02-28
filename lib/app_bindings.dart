import '/core/services/app_prefs.dart';
import '/core/services/notifications_service.dart';
import 'package:get/get.dart';
import 'core/network/dio_logger.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    /// General
    Get.put<AppPreferences>(AppPreferences());
    Get.put<DioLogger>(DioLogger());
    Get.put<NotificationsService>(NotificationsService());
  }
}
