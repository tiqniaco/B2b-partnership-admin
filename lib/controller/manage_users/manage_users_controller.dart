// ignore_for_file: avoid_print

import '/core/crud/custom_request.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';
import '/models/provider_model.dart';

import 'package:get/get.dart';

import '../../core/enums/status_request.dart';

class UsersController extends GetxController {
  List<ProviderModel> favorites = [];
  StatusRequest statusRequestProviders = StatusRequest.loading;

  @override
  Future<void> onInit() async {
    getProviders();
    super.onInit();
  }

  Future<void> getProviders() async {
    statusRequestProviders = StatusRequest.loading;
    update();
    final response = await CustomRequest(
        path: ApiConstance.getUserFavorite,
        data: {"user_id": Get.find<AppPreferences>().getUserId()},
        fromJson: (json) {
          return json["data"]
              .map<ProviderModel>((service) => ProviderModel.fromJson(service))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestProviders = StatusRequest.error;
    }, (r) {
      favorites.clear();
      favorites = r;
      if (r.isEmpty) {
        statusRequestProviders = StatusRequest.noData;
      } else {
        statusRequestProviders = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> onTapFavorite(String provId) async {
    statusRequestProviders = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.toggleFavorite,
        data: {
          "user_id": Get.find<AppPreferences>().getUserId(),
          "provider_id": provId
        },
        fromJson: (json) {
          return json["message"];
        }).sendPostRequest();
    response.fold((l) {
      statusRequestProviders = StatusRequest.error;
    }, (r) async {
      favorites.clear();
      await getProviders();
      statusRequestProviders = StatusRequest.success;
    });
    update();
  }
}
