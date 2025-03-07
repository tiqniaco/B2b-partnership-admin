// ignore_for_file: avoid_print

import 'package:b2b_partnership_admin/models/provider_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/core/crud/custom_request.dart';
import '/core/network/api_constance.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../core/enums/status_request.dart';

class WaitingProvidersController extends GetxController {
  List<ProviderModel> providers = [];
  StatusRequest statusRequest = StatusRequest.loading;

  @override
  Future<void> onInit() async {
    await getProvider();

    super.onInit();
  }

  void deleteProviderDialog(id) {
    Get.defaultDialog(
        title: "Delete Provider",
        titleStyle: TextStyle(fontSize: 14.sp),
        middleText: "Are you sure you want to\ndelete this provider?",
        textConfirm: "Yes",
        textCancel: "No",
        onConfirm: () {
          _deleteProvider(id);
        });
  }

  _deleteProvider(String id) async {
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

  acceptProvider(String id) async {
    statusRequest = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.approveProviderProvider,
        data: {"provider_id": id},
        fromJson: (json) {
          return json['data'];
        }).sendPostRequest();
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
        path: ApiConstance.getWaitingProvider,
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
