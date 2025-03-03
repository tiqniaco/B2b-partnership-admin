// ignore_for_file: avoid_print

import 'dart:io';

import 'package:b2b_partnership_admin/core/utils/app_snack_bars.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '/core/crud/custom_request.dart';
import '/core/network/api_constance.dart';
import '/models/specialize_model.dart';
import '/models/sub_specialize_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../core/enums/status_request.dart';

class ManageCategoriesController extends GetxController {
  int length = 6;
  late SpecializeModel selectedCategory;
  int selectedIndex = 0;
  List<SpecializeModel> specializations = [];
  List<SubSpecializeModel> subSpecializations = [];
  StatusRequest statusRequestSpecialization = StatusRequest.loading;
  StatusRequest statusRequestSubSpecialization = StatusRequest.loading;

  GlobalKey<FormState> subFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameArController = TextEditingController();
  TextEditingController nameEnController = TextEditingController();
  File? imageFile;
  String? image;

  @override
  Future<void> onInit() async {
    await getSpecialization();
    getSubSpecialization();
    super.onInit();
  }

  onEdit(SpecializeModel model) {
    nameArController.text = model.nameAr!;
    nameEnController.text = model.nameEn!;
    image = model.image!;

    update();
  }

  onEditCancel() {
    nameArController.clear();
    nameEnController.clear();
    image = "";
    update();
  }

  onTapSeeMore() {
    length = specializations.length;
    update();
  }

  onTapSeeLess() {
    length = 6;
    update();
  }

  onTapCategory(int index) {
    selectedIndex = index;
    selectedCategory = specializations[index];
    print(selectedCategory.id);
    getSubSpecialization();
    update();
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

  deleteSpecialization(int id) async {
    statusRequestSpecialization = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.deleteCategory(id),
        fromJson: (json) {
          return json['data'];
        }).sendDeleteRequest();
    response.fold((l) {
      statusRequestSpecialization = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      Get.back();
      getSpecialization();
    });
    update();
  }

  addSpecialization() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (imageFile == null) {
        AppSnackBars.error(message: "image is required".tr);
      } else {
        statusRequestSpecialization = StatusRequest.loading;

        final response = await CustomRequest(
            files: {
              "image": imageFile!.path,
            },
            data: {
              "name_ar": nameArController.text,
              "name_en": nameEnController.text
            },
            path: ApiConstance.addCategory,
            fromJson: (json) {
              return json['data'];
            }).sendPostRequest();
        response.fold((l) {
          statusRequestSpecialization = StatusRequest.error;
          Logger().e(l.errMsg);
        }, (r) {
          Get.back();
          getSpecialization();
          nameArController.clear();
          nameEnController.clear();
          imageFile = null;
        });
        update();
      }
    } else {
      print("not valid");
    }
  }

  editSpecialization(int id) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      statusRequestSpecialization = StatusRequest.loading;

      final response = await CustomRequest(
          files: {
            if (imageFile != null) "image": imageFile!.path,
          },
          data: {
            "name_ar": nameArController.text,
            "name_en": nameEnController.text
          },
          path: ApiConstance.editCategory(id),
          fromJson: (json) {
            return json['data'];
          }).sendPostRequest();
      response.fold((l) {
        statusRequestSpecialization = StatusRequest.error;
        Logger().e(l.errMsg);
      }, (r) {
        Get.back();
        getSpecialization();
        nameArController.clear();
        nameEnController.clear();
        imageFile = null;
      });
      update();
    } else {
      print("not valid");
    }
  }

  deleteSubSpecialization(int id) async {
    statusRequestSubSpecialization = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.deleteSubCategory(id),
        fromJson: (json) {
          return json['data'];
        }).sendDeleteRequest();
    response.fold((l) {
      statusRequestSubSpecialization = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      getSubSpecialization();
    });
    update();
  }

  addSubSpecialization() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      statusRequestSubSpecialization = StatusRequest.loading;
      final response = await CustomRequest(
          data: {
            "specialization_id": selectedCategory.id,
            "name_ar": nameArController.text,
            "name_en": nameEnController.text
          },
          path: ApiConstance.addSubCategory,
          fromJson: (json) {
            return json['data'];
          }).sendPostRequest();
      response.fold((l) {
        statusRequestSubSpecialization = StatusRequest.error;
        Logger().e(l.errMsg);
      }, (r) {
        Get.back();
        getSubSpecialization();
        nameArController.clear();
        nameEnController.clear();
      });
      update();
    } else {
      print("not valid");
    }
  }

  Future<void> getSubSpecialization() async {
    statusRequestSubSpecialization = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getSupSpecialization,
        data: {"specialization_id": selectedCategory.id},
        fromJson: (json) {
          return json['data']
              .map<SubSpecializeModel>(
                  (type) => SubSpecializeModel.fromJson(type))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestSubSpecialization = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      subSpecializations.clear();
      subSpecializations = r;
      if (r.isEmpty) {
        statusRequestSubSpecialization = StatusRequest.noData;
      } else {
        statusRequestSubSpecialization = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> getSpecialization() async {
    statusRequestSpecialization = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getSpecialization,
        fromJson: (json) {
          return json['data']
              .map<SpecializeModel>((e) => SpecializeModel.fromJson(e))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestSpecialization = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      specializations.clear();
      specializations = r;
      selectedCategory = r[0];
      if (r.isEmpty) {
        statusRequestSpecialization = StatusRequest.noData;
      } else {
        statusRequestSpecialization = StatusRequest.success;
      }
    });
    update();
  }
}
