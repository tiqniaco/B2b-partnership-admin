// ignore_for_file: avoid_print

import 'package:b2b_partnership_admin/models/client_model.dart';

import '/core/crud/custom_request.dart';
import '/core/network/api_constance.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../core/enums/status_request.dart';

class ManageClientsController extends GetxController {
  List<AdminModel> clients = [];

  StatusRequest statusRequest = StatusRequest.loading;

  @override
  Future<void> onInit() async {
    await getClients();

    super.onInit();
  }

  deleteClient(String id) async {
    statusRequest = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.deleteClient(id),
        fromJson: (json) {
          return json['data'];
        }).sendDeleteRequest();
    response.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      Get.back();
      getClients();
    });
    update();
  }

  Future<void> getClients() async {
    statusRequest = StatusRequest.loading;
    final response = await CustomRequest(
        queryParameters: {"page": 1},
        path: ApiConstance.getClients(1),
        fromJson: (json) {
          return json['data']
              .map<AdminModel>((e) => AdminModel.fromJson(e))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      clients.clear();
      clients = r;

      if (r.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
    });
    update();
  }
}
