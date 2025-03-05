import 'dart:io';

import '/controller/settings/setting_controller.dart';
import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';
import '/core/utils/app_snack_bars.dart';
import '/models/city_model.dart';
import '/models/client_model.dart';
import '/models/country_model.dart';
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
  String governmentId = '';

  List<CountryModel> countries = [];
  List<CityModel> cities = [];

  late CountryModel selectedCountry;
  late CityModel selectedCity;

  StatusRequest statusRequestCountry = StatusRequest.loading;
  StatusRequest statusRequestCity = StatusRequest.loading;

  AdminModel? model;

  @override
  Future<void> onInit() async {
    model = Get.arguments['model'] as AdminModel;
    await getCountries();
    selectedCountry = countries.firstWhere(
      (element) => element.id.toString() == model?.countryId,
    );
    await getCities();
    selectedCity = cities.firstWhere(
      (element) => element.id.toString() == model?.governmentId,
    );
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

  Future<void> getCountries() async {
    final result = await CustomRequest<List<CountryModel>>(
      path: ApiConstance.countries,
      fromJson: (json) {
        return json['data']
            .map<CountryModel>((element) => CountryModel.fromJson(element))
            .toList(); //. json['data'];
      },
    ).sendGetRequest();

    result.fold((l) {
      statusRequestCountry = StatusRequest.error;
      Logger().e(l.errMsg);
      update();
    }, (r) {
      countries = r;
      selectedCountry = r[0];
      if (r.isEmpty) {
        statusRequestCountry = StatusRequest.noData;
      } else {
        statusRequestCountry = StatusRequest.success;
      }
      update();
    });
  }

  Future<void> getCities() async {
    final response = await CustomRequest(
        path: ApiConstance.cities,
        data: {"country_id": selectedCountry.id},
        fromJson: (json) {
          return json['data']
              .map<CityModel>((city) => CityModel.fromJson(city))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestCity = StatusRequest.error;
    }, (r) {
      cities.clear();
      cities = r;
      if (r.isEmpty) {
        statusRequestCity = StatusRequest.noData;
      } else {
        selectedCity = r[0];
        statusRequestCity = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      update();
    }
  }

  onCountryChanged(value) {
    selectedCountry = value;
    debugPrint('Selected Country: $value');
    phoneController.clear();
    getCities();
    update();
  }

  onCityChanged(value) {
    selectedCity = value;
    debugPrint('Selected city: $value');
    update();
  }

  Future<void> updateProfile() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      update();
      final id = Get.find<AppPreferences>().getUserRoleId();

      final result = await CustomRequest<String>(
        path: ApiConstance.updateAdminProfile(id),
        fromJson: (json) {
          return json['message'];
        },
        data: {
          "name": nameController.text,
          "email": emailController.text,
          "country_code": selectedCountry.code,
          "phone": phoneController.text,
          "government_id": selectedCity.id,
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
        Get.put(SettingController()).getMenuModel();
        update();
      });
    }
  }
}
