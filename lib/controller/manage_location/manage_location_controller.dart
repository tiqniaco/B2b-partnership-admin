// ignore_for_file: avoid_print

import 'package:b2b_partnership_admin/core/local_data/countries.dart';
import 'package:b2b_partnership_admin/core/utils/app_snack_bars.dart';
import 'package:b2b_partnership_admin/models/city_model.dart';
import 'package:b2b_partnership_admin/models/country_model.dart';
import 'package:flutter/cupertino.dart';

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

  Country? newCountry;

  @override
  Future<void> onInit() async {
    await getCountries();
    getCities();
    super.onInit();
  }

  onChangedCountry(Country? country) {
    newCountry = country;
    print(newCountry!.code);
    print(newCountry!.minLength);
    print(newCountry!.maxLength);
    print(newCountry!.name);
    print(newCountry!.nameTranslations['ar']);
    update();
  }

  onAddCancel() {
    Get.back();
    newCountry = null;
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
    if (newCountry == null) {
      AppSnackBars.error(message: "Please select a country".tr);
    } else {
      statusRequestCountry = StatusRequest.loading;

      final response = await CustomRequest(
          data: {
            "name_ar": newCountry!.nameTranslations['ar'],
            "name_en": newCountry!.name,
            "code": newCountry!.dialCode,
            "flag": newCountry!.flag,
            "phone_length": newCountry!.minLength,
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
      });
      update();
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
