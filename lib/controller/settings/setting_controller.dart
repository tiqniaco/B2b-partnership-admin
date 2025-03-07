// ignore_for_file: avoid_print

import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';
import '../../models/admin_menu_model.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SettingController extends GetxController {
  AdminMenuModel? menuModel;
  StatusRequest statusRequest = StatusRequest.loading;
  bool removeAccountLoading = false;

  @override
  void onInit() {
    getMenuModel();
    super.onInit();
  }

  Future<void> getMenuModel() async {
    print("get details .........");
    var id = Get.find<AppPreferences>().getUserRoleId();
    statusRequest = StatusRequest.loading;
    update();
    final result = await CustomRequest<AdminMenuModel>(
      path: ApiConstance.getUserMenu(id),
      fromJson: (json) {
        return AdminMenuModel.fromJson(json);
      },
    ).sendGetRequest();
    result.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
      update();
    }, (r) {
      menuModel = r;
      statusRequest = StatusRequest.success;
      update();
    });
  }
}
