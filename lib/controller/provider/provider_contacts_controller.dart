import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';
import '/core/utils/app_snack_bars.dart';
import '/models/provider_contacts_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProviderContactsController extends GetxController {
  ProviderContactsModel? model;
  StatusRequest statusRequest = StatusRequest.loading;
  String errorMessage = "";
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final whatsappController = TextEditingController();
  final telegramController = TextEditingController();
  final instagramController = TextEditingController();
  final facebookController = TextEditingController();
  final linkedinController = TextEditingController();
  final websiteController = TextEditingController();

  @override
  Future<void> onInit() async {
    await getProviderContacts();
    phoneController.text = model?.phone ?? "";
    emailController.text = model?.email ?? "";
    whatsappController.text = model?.whatsapp ?? "";
    telegramController.text = model?.telegram ?? "";
    instagramController.text = model?.instagram ?? "";
    facebookController.text = model?.facebook ?? "";
    linkedinController.text = model?.linkedin ?? "";
    websiteController.text = model?.website ?? "";
    super.onInit();
  }

  @override
  void onClose() {
    phoneController.dispose();
    emailController.dispose();
    whatsappController.dispose();
    telegramController.dispose();
    instagramController.dispose();
    facebookController.dispose();
    linkedinController.dispose();
    websiteController.dispose();
    super.onClose();
  }

  Future<void> getProviderContacts() async {
    final providerId = Get.find<AppPreferences>().getUserRoleId();
    final result = await CustomRequest<ProviderContactsModel>(
      path: ApiConstance.getProviderContacts(providerId),
      fromJson: (json) {
        return ProviderContactsModel.fromJson(json['data']);
      },
    ).sendGetRequest();

    result.fold(
      (error) {
        errorMessage = error.errMsg;
        statusRequest = StatusRequest.error;
        update();
      },
      (data) {
        model = data;
        statusRequest = StatusRequest.success;
        update();
      },
    );
  }

  Future<void> updateProviderContacts() async {
    final result = await CustomRequest<String>(
      path: ApiConstance.addOrUpdateProviderContacts,
      data: ProviderContactsModel(
        phone: phoneController.text.isEmpty ? null : phoneController.text,
        email: emailController.text.isEmpty ? null : emailController.text,
        whatsapp:
            whatsappController.text.isEmpty ? null : whatsappController.text,
        telegram:
            telegramController.text.isEmpty ? null : telegramController.text,
        instagram:
            instagramController.text.isEmpty ? null : instagramController.text,
        facebook:
            facebookController.text.isEmpty ? null : facebookController.text,
        linkedin:
            linkedinController.text.isEmpty ? null : linkedinController.text,
        website: websiteController.text.isEmpty ? null : websiteController.text,
      ).toJson(),
      fromJson: (json) {
        return json['message'];
      },
    ).sendPostRequest();

    result.fold(
      (error) {
        AppSnackBars.error(message: error.errMsg);
      },
      (data) {
        Get.back();
        AppSnackBars.success(message: data);
        update();
      },
    );
  }
}
