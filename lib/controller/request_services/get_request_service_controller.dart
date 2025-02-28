import 'dart:io';

import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';
import '/models/service_request_model.dart';
import '/models/specialize_model.dart';
import '/models/sub_specialize_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class GetRequestServiceController extends GetxController {
  // late CountryModel selectedCountry;
  // late CityModel selectedCity;
  late SpecializeModel selectedSpecialization;
  late SubSpecializeModel selectedSubSpecialization;

  // List<CountryModel> countries = [];
  // List<CityModel> cities = [];
  List<ServiceRequestModel> services = [];
  List<SpecializeModel> specializations = [];
  List<SubSpecializeModel> subSpecializations = [];

  StatusRequest statusRequest = StatusRequest.loading;
  // StatusRequest statusRequestCity = StatusRequest.loading;
  // StatusRequest statusRequestCountry = StatusRequest.loading;
  StatusRequest statusRequestSpecialization = StatusRequest.loading;
  StatusRequest statusRequestSupSpecialization = StatusRequest.loading;
  File? imageFile;

  @override
  Future<void> onInit() async {
    // await getCountries();
    // getCities();
    getServices();
    await getSpecialization();
    getSupSpecialization();
    super.onInit();
  }

  // onCountryChanged(value) {
  //   selectedCountry = value;
  //   debugPrint('Selected Country: $value');
  //   update();
  // }

  // onCityChanged(value) {
  //   selectedCity = value;
  //   debugPrint('Selected city: $value');
  //   update();
  // }

  onSpecializeChanged(value) {
    selectedSpecialization = value;
    debugPrint('Selected specialize: $value');
    getSupSpecialization();
    update();
  }

  onSubSpecializeChanged(value) {
    selectedSubSpecialization = value;
    debugPrint('Selected sub specialize: $value');
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
      statusRequestSpecialization = StatusRequest.success;
      specializations = r;
      if (r.isEmpty) {
        statusRequestSpecialization = StatusRequest.noData;
      } else {
        selectedSpecialization = r[0];
        statusRequestSpecialization = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> getSupSpecialization() async {
    statusRequestSupSpecialization = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getSupSpecialization,
        data: {"specialization_id": selectedSpecialization.id},
        fromJson: (json) {
          return json['data']
              .map<SubSpecializeModel>(
                  (type) => SubSpecializeModel.fromJson(type))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestSupSpecialization = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      subSpecializations.clear();
      statusRequestSupSpecialization = StatusRequest.success;
      subSpecializations = r;
      if (r.isEmpty) {
        statusRequestSupSpecialization = StatusRequest.noData;
      } else {
        selectedSubSpecialization = r[0];
        statusRequestSupSpecialization = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> getServices() async {
    statusRequest = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getClientServiceRequest(
            Get.find<AppPreferences>().getUserRoleId()),
        // data: {"specialization_id": selectedSpecialization.id},
        fromJson: (json) {
          return json['data']
              .map<ServiceRequestModel>(
                  (type) => ServiceRequestModel.fromJson(type))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      services.clear();
      statusRequest = StatusRequest.success;
      services = r;
      if (r.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        // selectedSubSpecialization = r[0];
        statusRequest = StatusRequest.success;
      }
    });
    update();
  }

  // Future<void> getCountries() async {
  //   statusRequestCountry = StatusRequest.loading;
  //   final result = await CustomRequest<List<CountryModel>>(
  //     path: ApiConstance.countries,
  //     fromJson: (json) {
  //       return json['data']
  //           .map<CountryModel>((element) => CountryModel.fromJson(element))
  //           .toList(); //. json['data'];
  //     },
  //   ).sendGetRequest();
  //   result.fold((l) {
  //     statusRequestCountry = StatusRequest.error;
  //     Logger().e(l.errMsg);
  //     update();
  //   }, (r) {
  //     countries = r;
  //     selectedCountry = r[0];
  //     if (r.isEmpty) {
  //       statusRequestCountry = StatusRequest.noData;
  //     } else {
  //       statusRequestCountry = StatusRequest.success;
  //     }
  //     update();
  //   });
  // }

  // Future<void> getCities() async {
  //   statusRequestCity = StatusRequest.loading;
  //   final response = await CustomRequest(
  //       path: ApiConstance.cities,
  //       data: {"country_id": selectedCountry.id},
  //       fromJson: (json) {
  //         return json['data']
  //             .map<CityModel>((city) => CityModel.fromJson(city))
  //             .toList();
  //       }).sendGetRequest();
  //   response.fold((l) {
  //     statusRequestCity = StatusRequest.error;
  //   }, (r) {
  //     cities.clear();
  //     cities = r;
  //     if (r.isEmpty) {
  //       statusRequestCity = StatusRequest.noData;
  //     } else {
  //       selectedCity = r[0];
  //       statusRequestCity = StatusRequest.success;
  //     }
  //   });
  //   update();
  // }
}
