import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/core/utils/app_snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class EditWhatsappController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final numberController = TextEditingController();
  StatusRequest whatsAppStatus = StatusRequest.loading;

  StatusRequest statusRequest = StatusRequest.loading;

  @override
  Future<void> onInit() async {
    await getWhatsApp();

    super.onInit();
  }

  validUserData(val) {
    if (val.isEmpty) {
      return "can't be empty".tr;
    }
  }

  Future<void> getWhatsApp() async {
    whatsAppStatus = StatusRequest.loading;
    update();
    final result = await CustomRequest<Map<String, dynamic>>(
        path: ApiConstance.whatsContact,
        fromJson: (json) {
          return json;
        }).sendGetRequest();
    result.fold(
      (error) {
        Logger().e(error.errMsg);
        whatsAppStatus = StatusRequest.error;
        update();
      },
      (data) {
        whatsAppStatus = StatusRequest.success;
       
        numberController.text = data['whatsapp'];
        update();
      },
    );
  }

  Future<void> updateWhats() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      update();

      statusRequest = StatusRequest.loading;
      final result = await CustomRequest<String>(
        path: ApiConstance.editWhatsapp,
        fromJson: (json) {
          return json['message'];
        },
        data: {
          "whatsapp": numberController.text,
        },
      ).sendPostRequest();
      result.fold((l) {
        Logger().e(l.errMsg);
        AppSnackBars.error(message: l.errMsg);
        update();
      }, (r) {
        Get.back();
        AppSnackBars.success(message: r);
        statusRequest = StatusRequest.success;

        update();
      });
    }
  }
}
