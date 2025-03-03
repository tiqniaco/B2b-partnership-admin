import 'package:b2b_partnership_admin/controller/orders/orders_controller.dart';
import 'package:b2b_partnership_admin/core/enums/store_order_status_enum.dart';

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

  StoreOrderStatusWithoutAllEnum status =
      StoreOrderStatusWithoutAllEnum.pending;

  @override
  void onInit() {
    orderId = Get.arguments["id"] ?? "";
    getOrderDetails();

    super.onInit();
  }

  Future<void> getOrderDetails({bool hasLoading = true}) async {
    if (hasLoading) {
      statusRequest = StatusRequest.loading;
      update();
    }
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
      status = StoreOrderStatusWithoutAllEnum.values.firstWhere(
        (element) => element.name == model?.data.status,
      );
      statusRequest = StatusRequest.success;
      update();
    });
  }

  Future<void> updateOrderStatus() async {
    // log(status.name);
    // return;
    final result = await CustomRequest<String>(
      path: ApiConstance.updateOrderStatus(orderId),
      data: {
        "status": status.name,
      },
      fromJson: (json) {
        return json['message'];
      },
    ).sendPutRequest();
    result.fold((l) {
      AppSnackBars.error(message: l.errMsg);
    }, (r) {
      AppSnackBars.success(message: 'Order status updated successfully');
      getOrderDetails(hasLoading: false);
      Get.put(OrdersController()).getOrders(isRefresh: true);
    });
  }

  void onChangeStatus(StoreOrderStatusWithoutAllEnum value) {
    status = value;
    update();
  }
}
