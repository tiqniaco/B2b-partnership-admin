// ignore_for_file: avoid_print

import 'package:b2b_partnership_admin/models/admins_model.dart';
import 'package:b2b_partnership_admin/models/provider_model.dart';

import '/core/crud/custom_request.dart';
import '/core/network/api_constance.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../core/enums/status_request.dart';

class ManageProviderController extends GetxController {
  List<ProviderModel> providers = [];
  List<AdminModel> admins = [];
  StatusRequest statusRequest = StatusRequest.loading;

  @override
  Future<void> onInit() async {
    await getProvider();

    super.onInit();
  }

  deleteProvider(String id) async {
    statusRequest = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.deleteProvider(id),
        fromJson: (json) {
          return json['data'];
        }).sendDeleteRequest();
    response.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      Get.back();
      getProvider();
    });
    update();
  }

  Future<void> getProvider() async {
    statusRequest = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getProviders(1),
        fromJson: (json) {
          return json['data']
              .map<ProviderModel>((e) => ProviderModel.fromJson(e))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      providers.clear();
      providers = r;
      if (r.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
    });
    update();
  }
}
