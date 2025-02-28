import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/core/utils/app_snack_bars.dart';
import '/models/order_details_model.dart';
import 'package:get/get.dart';

class OrderDetailsController extends GetxController {
  String orderId = "";
  StatusRequest statusRequest = StatusRequest.loading;
  OrderDetailsModel? model;

  @override
  void onInit() {
    orderId = Get.arguments["id"] ?? "";
    getOrderDetails();
    super.onInit();
  }

  Future<void> getOrderDetails() async {
    statusRequest = StatusRequest.loading;
    update();
    final result = await CustomRequest<OrderDetailsModel>(
      path: ApiConstance.getOrderDetails(orderId),
      fromJson: (json) {
        return OrderDetailsModel.fromJson(json);
      },
    ).sendGetRequest();
    result.fold((l) {
      statusRequest = StatusRequest.error;
      AppSnackBars.error(message: l.errMsg);
      update();
    }, (r) {
      model = r;
      statusRequest = StatusRequest.success;
      update();
    });
  }
}
