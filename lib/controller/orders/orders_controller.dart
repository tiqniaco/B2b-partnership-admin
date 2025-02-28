import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/enums/store_order_status_enum.dart';
import '/core/network/api_constance.dart';
import '/core/utils/app_snack_bars.dart';
import '/models/order_model.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  StoreOrderStatusEnum selectedStatus = StoreOrderStatusEnum.all;
  List<OrderModel> orders = [];

  String selectedPayment = 'All';
  List<String> paymentStatus = [
    'All',
    'Pending',
    'Complete',
  ];

  @override
  void onInit() async {
    await getOrders();
    super.onInit();
  }

  onStatusChanged(StoreOrderStatusEnum newValue) {
    selectedStatus = newValue;
    getOrders();
    update();
  }

  onPaymentChanged(String newValue) {
    selectedPayment = newValue;
    update();
  }

  Future<void> getOrders() async {
    statusRequest = StatusRequest.loading;
    update();
    final result = await CustomRequest<List<OrderModel>>(
      path: ApiConstance.getOrders,
      data: {
        if (selectedStatus != StoreOrderStatusEnum.all)
          'status': selectedStatus.value,
      },
      fromJson: (json) {
        return List<OrderModel>.from(
          json['data'].map(
            (x) => OrderModel.fromJson(x),
          ),
        );
      },
    ).sendGetRequest();

    result.fold((l) {
      statusRequest = StatusRequest.error;
      AppSnackBars.error(message: l.errMsg);
      update();
    }, (r) {
      orders = r;
      if (orders.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
      update();
    });
  }
}
