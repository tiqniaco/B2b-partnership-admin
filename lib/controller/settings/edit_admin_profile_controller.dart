import 'dart:io';

import 'package:b2b_partnership_admin/models/admin_model.dart';

import '/controller/settings/setting_controller.dart';
import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';
import '/core/utils/app_snack_bars.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class EditAdminProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  File? image;

  StatusRequest statusRequest = StatusRequest.loading;

  AdminModel? model;

  @override
  Future<void> onInit() async {
    model = Get.arguments['model'] as AdminModel;

    nameController.text = model?.name ?? '';
    emailController.text = model?.email ?? '';
    phoneController.text = model?.phone ?? '';
    super.onInit();
  }

  validUserData(val) {
    if (val.isEmpty) {
      return "can't be empty".tr;
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      update();
    }
  }

  Future<void> updateProfile() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      update();
      final id = Get.find<AppPreferences>().getUserRoleId();
      statusRequest = StatusRequest.loading;
      final result = await CustomRequest<String>(
        path: ApiConstance.updateAdminProfile(id),
        fromJson: (json) {
          return json['message'];
        },
        data: {
          "name": nameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
        },
        files: {
          if (image != null) "image": image?.path ?? '',
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
        Get.put(SettingController()).getMenuModel();
        update();
      });
    }
  }
}
