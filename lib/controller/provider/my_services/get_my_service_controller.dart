import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';
import '/models/services_model.dart';
import 'package:get/get.dart';

class GetMyServiceController extends GetxController {
  List<ServiceRequestModel> providerServices = [];

  StatusRequest statusRequestServices = StatusRequest.loading;
  StatusRequest statusRequest = StatusRequest.loading;

  @override
  Future<void> onInit() async {
    getServices();

    super.onInit();
  }

  Future<void> getServices() async {
    statusRequestServices = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getProviderServices(
            Get.find<AppPreferences>().getUserRoleId()),
        fromJson: (json) {
          return json["data"]
              .map<ServiceRequestModel>(
                  (service) => ServiceRequestModel.fromJson(service))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestServices = StatusRequest.error;
    }, (r) {
      providerServices.clear();
      providerServices = r;
      if (r.isEmpty) {
        statusRequestServices = StatusRequest.noData;
      } else {
        statusRequestServices = StatusRequest.success;
      }
    });
    update();
  }
}
