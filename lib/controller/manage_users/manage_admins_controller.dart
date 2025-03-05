// ignore_for_file: avoid_print

import 'dart:io';

import 'package:b2b_partnership_admin/core/utils/app_snack_bars.dart';
import 'package:b2b_partnership_admin/models/admins_model.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '/core/crud/custom_request.dart';
import '/core/network/api_constance.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../core/enums/status_request.dart';

class ManageAdminsController extends GetxController {
  List<AdminModel> admins = [];
  StatusRequest statusRequestAdmins = StatusRequest.loading;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? imageFile;
  String? image;

  @override
  Future<void> onInit() async {
    await getAdmins();
    super.onInit();
  }

  validUserData(val) {
    if (val?.isEmpty ?? true) {
      return "can't be empty".tr;
    }
  }

  galleryImage() async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = File(xfile!.path);
    Get.defaultDialog(
        content: SizedBox(
          width: 300,
          height: 300,
          child: Image.file(
            imageFile!,
            fit: BoxFit.cover,
          ),
        ),
        onCancel: () {
          imageFile = null;
          update();
        },
        onConfirm: () {
          Get.back();
        });
    update();
  }

  addAdmin() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      statusRequestAdmins = StatusRequest.loading;
      final response = await CustomRequest(
          files: {
            if (imageFile != null) "image": imageFile!.path,
          },
          data: {
            "name": nameController.text,
            "email": emailController.text,
            "phone": phoneController.text,
            "password": passwordController.text,
            "role": "admin",
          },
          path: ApiConstance.register,
          fromJson: (json) {
            return json['data'];
          }).sendPostRequest();
      response.fold((l) {
        AppSnackBars.error(message: l.errMsg);
        Logger().e(l.errMsg);
      }, (r) {
        Get.back();
        getAdmins();
        nameController.clear();
        emailController.clear();
        phoneController.clear();
        passwordController.clear();
        imageFile = null;
      });
      update();
    } else {
      print("not valid");
    }
  }

  deleteAdmin(String id) async {
    statusRequestAdmins = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.deleteAdmin(id),
        fromJson: (json) {
          return json['data'];
        }).sendDeleteRequest();
    response.fold((l) {
      statusRequestAdmins = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      getAdmins();
    });
    update();
  }

  Future<void> getAdmins() async {
    statusRequestAdmins = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getAdmins,
        fromJson: (json) {
          return json['data']
              .map<AdminModel>((e) => AdminModel.fromJson(e))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestAdmins = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      print(r);
      admins.clear();
      admins = r;
      if (r.isEmpty) {
        statusRequestAdmins = StatusRequest.noData;
      } else {
        statusRequestAdmins = StatusRequest.success;
      }
    });
    update();
  }
}
