import 'package:flutter/material.dart';

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
  ScrollController scrollController = ScrollController();
  int currentPage = 1;
  int totalPages = 1;

  String selectedPayment = 'All';
  List<String> paymentStatus = [
    'All',
    'Pending',
    'Complete',
  ];

  @override
  void onInit() async {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          currentPage++;
          getOrders(hasLoading: false);
        }
      }
    });
    await getOrders();
    super.onInit();
  }

  onStatusChanged(StoreOrderStatusEnum newValue) {
    selectedStatus = newValue;
    currentPage = 1;
    orders.clear();
    getOrders();
    update();
  }

  onPaymentChanged(String newValue) {
    selectedPayment = newValue;
    update();
  }

  Future<void> getOrders({
    bool hasLoading = true,
    bool isRefresh = false,
  }) async {
    if (hasLoading) {
      statusRequest = StatusRequest.loading;
    }
    if (isRefresh) {
      orders.clear();
      currentPage = 1;
    }
    update();
    final result = await CustomRequest<List<OrderModel>>(
      path: ApiConstance.getAdminOrders,
      data: {
        'page': currentPage,
        if (selectedStatus != StoreOrderStatusEnum.all)
          'status': selectedStatus.value,
      },
      fromJson: (json) {
        debugPrint(json['data'].toString());
        currentPage = json['current_page'];
        totalPages = json['last_page'];
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
      orders.addAll(r);
      if (orders.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
      update();
    });
  }
}
