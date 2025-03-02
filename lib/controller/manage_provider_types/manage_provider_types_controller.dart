// ignore_for_file: avoid_print

import 'package:b2b_partnership_admin/models/provider_type_model.dart';
import 'package:flutter/cupertino.dart';

import '/core/crud/custom_request.dart';
import '/core/network/api_constance.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../core/enums/status_request.dart';

class ManageProviderTypesController extends GetxController {
  List<ProviderTypeModel> types = [];

  StatusRequest statusRequest = StatusRequest.loading;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameArController = TextEditingController();
  TextEditingController nameEnController = TextEditingController();

  @override
  Future<void> onInit() async {
    await getProviderTypes();
    super.onInit();
  }

  validUserData(val) {
    if (val?.isEmpty ?? true) {
      return "can't be empty".tr;
    }
  }

  deleteProviderType(int id) async {
    statusRequest = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.deleteProviderTypes(id),
        fromJson: (json) {
          return json['data'];
        }).sendDeleteRequest();
    response.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      Get.back();
      getProviderTypes();
    });
    update();
  }

  addProviderType() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      statusRequest = StatusRequest.loading;
      final response = await CustomRequest(
          data: {
            "name_ar": nameArController.text,
            "name_en": nameEnController.text
          },
          path: ApiConstance.addProviderTypes,
          fromJson: (json) {
            return json['data'];
          }).sendPostRequest();
      response.fold((l) {
        statusRequest = StatusRequest.error;
        Logger().e(l.errMsg);
      }, (r) {
        Get.back();
        getProviderTypes();
        nameArController.clear();
        nameEnController.clear();
      });
      update();
    } else {
      print("not valid");
    }
  }

  Future<void> getProviderTypes() async {
    statusRequest = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getProviderTypes,
        fromJson: (json) {
          return json['data']
              .map<ProviderTypeModel>((e) => ProviderTypeModel.fromJson(e))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      types.clear();
      types = r;
      if (r.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
    });
    update();
  }
}
