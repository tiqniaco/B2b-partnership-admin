// ignore_for_file: avoid_print

import 'package:b2b_partnership_admin/core/crud/custom_request.dart';
import 'package:b2b_partnership_admin/core/network/api_constance.dart';
import 'package:b2b_partnership_admin/models/iso_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../core/enums/status_request.dart';

class IsoController extends GetxController {
  List<IsoModel> isoList = [];
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestAddIso = StatusRequest.loading;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  String? pdfFileName;

  @override
  Future<void> onInit() async {
    getIso();
    super.onInit();
  }

  validUserData(val) {
    if (val?.isEmpty ?? true) {
      return "can't be empty".tr;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  Future<void> deleteIso(int id) async {
    statusRequest = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.isoWithId(id),
        fromJson: (json) {
          return json['data'];
        }).sendDeleteRequest();
    response.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      getIso();
    });
    update();
  }

  Future<void> addIso() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // if (pdfFileName == null) {
      //   AppSnackBars.error(message: "image is required".tr);
      // } else {
      statusRequestAddIso = StatusRequest.loading;

      final response = await CustomRequest(
          // files: {
          //   "image": imageFile!.path,
          // },
          data: {
            "name": nameController.text,
            "title": titleController.text,
            "description": descriptionController.text,
            "price": priceController.text
          },
          path: ApiConstance.iso,
          fromJson: (json) {
            return json['data'];
          }).sendPostRequest();
      response.fold((l) {
        statusRequestAddIso = StatusRequest.error;
        Logger().e(l.errMsg);
      }, (r) {
        Get.back();
        // AppSnackBars.success(message: "iso added successfully".tr);
        getIso();
        // nameArController.clear();
        // nameEnController.clear();
        // imageFile = null;
      });
      update();
      //}
    } else {
      print("not valid");
    }
  }

  Future<void> pickPdfFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      pdfFileName = result.files.single.name;
      update();
    }
  }

  Future<void> getIso() async {
    statusRequest = StatusRequest.loading;
    update();
    final response = await CustomRequest<List<IsoModel>>(
        path: ApiConstance.iso,
        //data: {"user_id": Get.find<AppPreferences>().getUserId()},
        fromJson: (json) {
          return json["data"]
              .map<IsoModel>((service) => IsoModel.fromJson(service))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequest = StatusRequest.error;
      update();
    }, (r) {
      isoList.clear();
      isoList = r;
      if (r.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
      update();
    });
  }
}
