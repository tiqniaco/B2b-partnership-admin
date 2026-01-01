// ignore_for_file: avoid_print

import 'package:b2b_partnership_admin/controller/iso/iso_controller.dart';
import 'package:b2b_partnership_admin/core/crud/custom_request.dart';
import 'package:b2b_partnership_admin/core/network/api_constance.dart';
import 'package:b2b_partnership_admin/models/iso_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../core/enums/status_request.dart';

class EditIsoController extends GetxController {
  StatusRequest statusRequestAddIso = StatusRequest.loading;
  final formKey = GlobalKey<FormState>();
  late IsoModel iso;
  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  String? pdfFileName;

  @override
  Future<void> onInit() async {
    iso = Get.arguments['iso'];

    titleController.text = iso.title!;
    descriptionController.text = iso.description!;
    priceController.text = iso.price!.toString();

    print(iso.title);
    print(iso.description);
    print(iso.price);
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

  Future<void> editIso() async {
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
          path: ApiConstance.isoWithId(iso.id),
          fromJson: (json) {
            return json['data'];
          }).sendPutRequest();
      response.fold((l) {
        statusRequestAddIso = StatusRequest.error;
        Logger().e(l.errMsg);
      }, (r) {
        Get.back();
        Get.put(IsoController()).getIso();
      });
      update();
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
}
