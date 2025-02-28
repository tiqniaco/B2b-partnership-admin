// ignore_for_file: avoid_print

import '/controller/save/saved_controller.dart';
import '/core/crud/custom_request.dart';
import '/core/network/api_constance.dart';
import '/core/utils/app_snack_bars.dart';
import '/models/city_model.dart';
import '/models/country_model.dart';
import '/models/provider_model.dart';
import '/models/specialize_model.dart';
import '/models/sub_specialize_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../core/enums/status_request.dart';

class SearchControllerIM extends GetxController {
  double rating = 0;
  List<ProviderModel> topProviders = [];
  List<ProviderModel> searchList = [];
  List<CountryModel> countries = [];
  List<CityModel> cities = [];
  StatusRequest statusRequestProviders = StatusRequest.loading;
  late TextEditingController searchController;
  CountryModel? selectedCountry;
  CityModel? selectedCity;
  SpecializeModel? selectedSpecialization;
  SubSpecializeModel? selectedSubSpecialization;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  List<SpecializeModel> specializations = [];
  List<SubSpecializeModel> subSpecializations = [];
  late String role;
  int currentStep = 0;
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestSearch = StatusRequest.loading;
  StatusRequest statusRequestCity = StatusRequest.loading;
  StatusRequest statusRequestSpecialization = StatusRequest.loading;
  StatusRequest statusRequestSupSpecialization = StatusRequest.loading;
  late String id;
  bool enable = false;
  bool isSearch = false;

  @override
  Future<void> onInit() async {
    getProviders();
    searchController = TextEditingController();

    await getCountries();
    // getCities();
    await getSpecialization();
    getProviders();
    super.onInit();
  }

  onCountryChanged(value) {
    selectedCountry = value;
    debugPrint('Selected Country: $value');
    enable = true;
    getCities();
    update(['location']);
  }

  onCityChanged(value) {
    selectedCity = value;
    debugPrint('Selected city: $value');
    update(['location']);
  }

  onSpecializeChanged(value) async {
    selectedSpecialization = value;
    debugPrint('Selected specialize: $value');
    await getSupSpecialization();
    update(['category']);
  }

  onSubSpecializeChanged(value) {
    selectedSubSpecialization = value;
    debugPrint('Selected sub specialize: $value');
    update(['category']);
  }

  validUserData(val) {
    if (val.isEmpty) {
      return "can't be empty".tr;
    }
  }

  Future<void> search() async {
    if (formKey.currentState!.validate()) {
      statusRequestSearch = StatusRequest.loading;
      final result = await CustomRequest<List<ProviderModel>>(
          path: ApiConstance.search,
          fromJson: (json) {
            return json['data']
                .map<ProviderModel>(
                    (element) => ProviderModel.fromJson(element))
                .toList();
          },
          data: {
            if (searchController.text.isNotEmpty)
              "search": searchController.text,
            if (selectedSubSpecialization != null)
              "sub_specialization_id": selectedSubSpecialization!.id,
            if (selectedSpecialization != null)
              "specialization_id": selectedSpecialization!.id,
            if (selectedCountry != null) "country_id": selectedCountry!.id,
            if (selectedCity != null) "government_id": selectedCity!.id,
            if (rating != 0) "rate": rating.toInt(),
          }).sendPostRequest();
      result.fold((l) {
        statusRequestSearch = StatusRequest.error;
        Logger().e(l.errMsg);
        AppSnackBars.error(message: l.errMsg);
        update();
      }, (r) {
        isSearch = true;
        Get.back();
        searchList.clear();
        searchList = r;
        print(searchList);
        if (searchList.isEmpty) {
          statusRequestSearch = StatusRequest.noData;
        } else {
          statusRequestSearch = StatusRequest.success;
        }
        update();
      });
    }
  }

  resetFunction() {
    searchController.clear();
    selectedCity = null;
    selectedCountry = null;
    selectedSpecialization = null;
    selectedSubSpecialization = null;
    searchList.clear();
    rating = 0;
    isSearch = false;

    update();
  }

  resetLocation() {
    selectedCountry = null;
    selectedCity = null;
    update(['location']);
  }

  resetCategory() {
    selectedSpecialization = null;
    selectedSubSpecialization = null;
    update(['category']);
  }

  Future<void> getCountries() async {
    statusRequest = StatusRequest.loading;
    final result = await CustomRequest<List<CountryModel>>(
      path: ApiConstance.countries,
      fromJson: (json) {
        return json['data']
            .map<CountryModel>((element) => CountryModel.fromJson(element))
            .toList(); //. json['data'];
      },
    ).sendGetRequest();

    result.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
      update();
    }, (r) {
      print(r);
      countries = r;
      //selectedCountry = r[0];
      if (r.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
      update();
    });
  }

  Future<void> getCities() async {
    statusRequestCity = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.cities,
        data: {"country_id": selectedCountry!.id},
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
        //selectedCity = r[0];
        statusRequestCity = StatusRequest.success;
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
      statusRequestSpecialization = StatusRequest.success;
      specializations = r;
      if (r.isEmpty) {
        statusRequestSpecialization = StatusRequest.noData;
      } else {
        //selectedSpecialization = r[0];
        statusRequestSpecialization = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> getSupSpecialization() async {
    statusRequestSupSpecialization = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getSupSpecialization,
        data: {"specialization_id": selectedSpecialization!.id},
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
        //  selectedSubSpecialization = r[0];
        statusRequestSupSpecialization = StatusRequest.success;
      }
    });
    update();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  onTapRating(double index) {
    rating = index;
    print(rating);
    update(["rating"]);
  }

  resetRating() {
    rating = 0;
    update(['rating']);
  }

  Future<void> getProviders() async {
    statusRequestProviders = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getTopProviders,
        fromJson: (json) {
          return json["data"]
              .map<ProviderModel>((service) => ProviderModel.fromJson(service))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestProviders = StatusRequest.error;
    }, (r) {
      topProviders.clear();
      topProviders = r;
      if (r.isEmpty) {
        statusRequestProviders = StatusRequest.noData;
      } else {
        statusRequestProviders = StatusRequest.success;
      }
    });
    update();
  }

  toggleFavorites(String provId) async {
    final savedController = SavedController();
    await savedController.onTapFavorite(provId);
    getProviders();

    update();
  }
}
