import '../manage_users/manage_users_controller.dart';
import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/models/provider_model.dart';
import '/models/specialize_model.dart';
import '/models/sub_specialize_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ProvidersInCategoryController extends GetxController {
  StatusRequest statusRequestServices = StatusRequest.loading;
  List<ProviderModel> providers = [];
  late SpecializeModel specialization;
  List<SubSpecializeModel> subSpecializations = [];
  late SubSpecializeModel selectedSubSpecialization;
  StatusRequest statusRequestSupSpecialization = StatusRequest.loading;

  @override
  Future<void> onInit() async {
    specialization = Get.arguments['model'];
    await getSupSpecialization();
    getProviders();
    super.onInit();
  }

  onTapSub(SubSpecializeModel model) {
    selectedSubSpecialization = model;
    getProviders();
    update();
  }

  Future<void> getProviders() async {
    statusRequestServices = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getProvidersInCategory,
        data: {
          "sub_specialization_id": selectedSubSpecialization.id,
          "specialization_id": specialization.id,
        },
        fromJson: (json) {
          return json["data"]
              .map<ProviderModel>((service) => ProviderModel.fromJson(service))
              .toList();
        }).sendPostRequest();
    response.fold((l) {
      statusRequestServices = StatusRequest.error;
    }, (r) {
      providers.clear();
      providers = r;
      if (r.isEmpty) {
        statusRequestServices = StatusRequest.noData;
      } else {
        statusRequestServices = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> getSupSpecialization() async {
    statusRequestSupSpecialization = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getSupSpecialization,
        data: {"specialization_id": specialization.id},
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
        update();
      }
    });
    update();
  }

  toggleFavorites(String provId) async {
    final savedController = UsersController();
    await savedController.onTapFavorite(provId);
    getProviders();
    update();
  }
}
