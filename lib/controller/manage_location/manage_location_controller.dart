// ignore_for_file: avoid_print

import 'dart:io';

import 'package:b2b_partnership_admin/core/utils/app_snack_bars.dart';
import 'package:b2b_partnership_admin/models/city_model.dart';
import 'package:b2b_partnership_admin/models/country_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

import '/core/crud/custom_request.dart';
import '/core/network/api_constance.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../core/enums/status_request.dart';

class ManageLocationController extends GetxController {
  int length = 6;
  late CountryModel selectedCountry;
  late int selectedId;
  List<CountryModel> countries = [];
  List<CityModel> cities = [];
  StatusRequest statusRequestCountry = StatusRequest.loading;
  StatusRequest statusRequestCity = StatusRequest.loading;

  GlobalKey<FormState> subFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameArController = TextEditingController();
  TextEditingController nameEnController = TextEditingController();
  File? imageFile;
  String? image;

  @override
  Future<void> onInit() async {
    await getCountries();
    getCities();
    super.onInit();
  }

  onEdit(CountryModel model) {
    nameArController.text = model.nameAr!;
    nameEnController.text = model.nameEn!;
    image = model.flag!;

    update();
  }

  onEditCancel() {
    nameArController.clear();
    nameEnController.clear();
    image = "";
    update();
  }

  onTapSeeMore() {
    length = countries.length;
    update();
  }

  onTapSeeLess() {
    length = 6;
    update();
  }

  onTapCountry(CountryModel model) {
    selectedId = model.id!;
    selectedCountry = model;
    print(selectedCountry.id);
    getCities();
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

  deleteCountry(int id) async {
    statusRequestCountry = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.deleteCountry(id),
        fromJson: (json) {
          return json['data'];
        }).sendDeleteRequest();
    response.fold((l) {
      statusRequestCountry = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      Get.back();
      getCountries();
    });
    update();
  }

  addCountry() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (imageFile == null) {
        AppSnackBars.error(message: "image is required".tr);
      } else {
        statusRequestCountry = StatusRequest.loading;

        final response = await CustomRequest(
            files: {
              "image": imageFile!.path,
            },
            data: {
              "name_ar": nameArController.text,
              "name_en": nameEnController.text
            },
            path: ApiConstance.addCountry,
            fromJson: (json) {
              return json['data'];
            }).sendPostRequest();
        response.fold((l) {
          statusRequestCountry = StatusRequest.error;
          Logger().e(l.errMsg);
        }, (r) {
          Get.back();
          getCountries();
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

  editCountry(int id) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      statusRequestCountry = StatusRequest.loading;

      final response = await CustomRequest(
          files: {
            if (image != null) "image": imageFile!.path,
          },
          data: {
            "name_ar": nameArController.text,
            "name_en": nameEnController.text
          },
          path: ApiConstance.editCountry(id),
          fromJson: (json) {
            return json['data'];
          }).sendPostRequest();
      response.fold((l) {
        statusRequestCountry = StatusRequest.error;
        Logger().e(l.errMsg);
      }, (r) {
        Get.back();
        getCountries();
        nameArController.clear();
        nameEnController.clear();
        imageFile = null;
      });
      update();
    } else {
      print("not valid");
    }
  }

  deleteCity(int id) async {
    statusRequestCity = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.deleteCity(id),
        fromJson: (json) {
          return json['data'];
        }).sendDeleteRequest();
    response.fold((l) {
      statusRequestCity = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      getCities();
    });
    update();
  }

  addCity() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      statusRequestCity = StatusRequest.loading;
      final response = await CustomRequest(
          data: {
            "country_id": selectedCountry.id,
            "name_ar": nameArController.text,
            "name_en": nameEnController.text
          },
          path: ApiConstance.addCity,
          fromJson: (json) {
            return json['data'];
          }).sendPostRequest();
      response.fold((l) {
        statusRequestCity = StatusRequest.error;
        Logger().e(l.errMsg);
      }, (r) {
        Get.back();
        getCities();
        nameArController.clear();
        nameEnController.clear();
      });
      update();
    } else {
      print("not valid");
    }
  }

  Future<void> getCities() async {
    statusRequestCity = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.cities,
        data: {"country_id": selectedCountry.id},
        fromJson: (json) {
          return json['data']
              .map<CityModel>((type) => CityModel.fromJson(type))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestCity = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      cities.clear();
      cities = r;
      if (r.isEmpty) {
        statusRequestCity = StatusRequest.noData;
      } else {
        statusRequestCity = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> getCountries() async {
    statusRequestCountry = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.countries,
        fromJson: (json) {
          return json['data']
              .map<CountryModel>((e) => CountryModel.fromJson(e))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestCountry = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      countries.clear();
      countries = r;
      selectedCountry = r[0];
      selectedId = r[0].id;
      if (r.isEmpty) {
        statusRequestCountry = StatusRequest.noData;
      } else {
        statusRequestCountry = StatusRequest.success;
      }
    });
    update();
  }
}
