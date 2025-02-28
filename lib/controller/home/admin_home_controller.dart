// ignore_for_file: avoid_print

import '/controller/save/saved_controller.dart';
import '/core/crud/custom_request.dart';
import '/core/network/api_constance.dart';
import '/models/banner_model.dart';
import '/models/provider_model.dart';
import '/models/specialize_model.dart';
import '/models/sub_specialize_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../core/enums/status_request.dart';

class AdminHomeController extends GetxController {
  int currentPage = 0;
  List<BannersModel> banners = [];
  List<SpecializeModel> specializations = [];
  List<ProviderModel> topProviders = [];
  List<ProviderModel> topEgypt = [];
  List<ProviderModel> topSaudi = [];
  List<ProviderModel> topUAE = [];
  List<SubSpecializeModel> jobs = [];
  StatusRequest statusRequestBanner = StatusRequest.loading;
  StatusRequest statusRequestJop = StatusRequest.loading;
  StatusRequest statusRequestProviders = StatusRequest.loading;
  StatusRequest statusRequestSpecialization = StatusRequest.loading;
  StatusRequest statusRequestTopEgypt = StatusRequest.loading;
  StatusRequest statusRequestTopSaudi = StatusRequest.loading;
  StatusRequest statusRequestTopUAE = StatusRequest.loading;

  @override
  Future<void> onInit() async {
    getBanners();
    getSpecialization();
    getProviders();
    getTopEgypt();
    getTopSaudi();
    getTopUAE();
    super.onInit();
  }

  changeSlider(int index) {
    print(index);
    currentPage = index;
    update(["slider"]);
  }

  Future<void> getBanners() async {
    print("----------------get banners--------------");
    statusRequestBanner = StatusRequest.loading;
    final result = await CustomRequest<List<BannersModel>>(
      path: ApiConstance.getBanners,
      fromJson: (json) {
        return json['data']
            .map<BannersModel>((element) => BannersModel.fromJson(element))
            .toList(); //. json['data'];
      },
    ).sendGetRequest();
    result.fold((l) {
      statusRequestBanner = StatusRequest.error;
      Logger().e(l.errMsg);
      update(["slider"]);
    }, (r) {
      print(r);
      print("----------------success--------------");

      banners = r;
      if (r.isEmpty) {
        statusRequestBanner = StatusRequest.noData;
      } else {
        statusRequestBanner = StatusRequest.success;
      }
      update(["slider"]);
    });
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

  Future<void> getTopEgypt() async {
    statusRequestTopEgypt = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getTopCountriesProv("11"),
        fromJson: (json) {
          return json["data"]
              .map<ProviderModel>((service) => ProviderModel.fromJson(service))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestTopEgypt = StatusRequest.error;
    }, (r) {
      topEgypt.clear();
      topEgypt = r;
      if (r.isEmpty) {
        statusRequestTopEgypt = StatusRequest.noData;
      } else {
        statusRequestTopEgypt = StatusRequest.success;
      }
    });
    update();
  }

  toggleFavorites(String provId) async {
    final savedController = SavedController();
    await savedController.onTapFavorite(provId);
    getProviders();
    getTopEgypt();
    getTopSaudi();
    getTopUAE();
    update();
  }

  Future<void> getTopSaudi() async {
    statusRequestTopSaudi = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getTopCountriesProv("12"),
        fromJson: (json) {
          return json['data']
              .map<ProviderModel>((type) => ProviderModel.fromJson(type))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestTopSaudi = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      topSaudi.clear();
      topSaudi = r;
      if (r.isEmpty) {
        statusRequestTopSaudi = StatusRequest.noData;
      } else {
        statusRequestTopSaudi = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> getTopUAE() async {
    statusRequestTopUAE = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getTopCountriesProv("14"),
        fromJson: (json) {
          return json['data']
              .map<ProviderModel>((type) => ProviderModel.fromJson(type))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestTopUAE = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      topUAE.clear();
      statusRequestTopUAE = StatusRequest.success;
      topUAE = r;
      if (r.isEmpty) {
        statusRequestTopUAE = StatusRequest.noData;
      } else {
        statusRequestTopUAE = StatusRequest.success;
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
        statusRequestSpecialization = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> getJobs() async {
    statusRequestJop = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getJobs,
        fromJson: (json) {
          return json['data']
              .map<SubSpecializeModel>(
                  (type) => SubSpecializeModel.fromJson(type))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestJop = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      jobs.clear();
      statusRequestJop = StatusRequest.success;
      jobs = r;
      if (r.isEmpty) {
        statusRequestJop = StatusRequest.noData;
      } else {
        statusRequestJop = StatusRequest.success;
      }
    });
    update();
  }
}
