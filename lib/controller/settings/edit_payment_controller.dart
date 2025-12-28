// ignore_for_file: avoid_print

import 'package:b2b_partnership_admin/controller/settings/payment_controller.dart';
import 'package:b2b_partnership_admin/models/months_model.dart';
import 'package:b2b_partnership_admin/models/payment_model.dart';
import 'package:flutter/cupertino.dart';

import '/core/crud/custom_request.dart';
import '/core/network/api_constance.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../core/enums/status_request.dart';

class EditPaymentController extends GetxController {
  PaymentMonths? selectedMonth;
  late PaymentPackage method;
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestMonths = StatusRequest.loading;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> addMonthFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editMonthFormKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController priceController;
  late TextEditingController discountController;
  late TextEditingController trailsDaysController;

  // New controllers for count fields
  late TextEditingController servicesCountController;
  late TextEditingController productsCountController;
  late TextEditingController monthsDurationController;

  // New boolean variables for switches
  late bool isTrial;
  late bool isActive;

  List<PaymentMonths> monthsList = [];

  @override
  Future<void> onInit() async {
    method = Get.arguments['method'];
    nameController = TextEditingController(text: method.name);
    priceController = TextEditingController(text: method.price);
    servicesCountController =
        TextEditingController(text: method.serviceCount.toString());
    productsCountController =
        TextEditingController(text: method.productCount.toString());
    trailsDaysController =
        TextEditingController(text: method.trialDays.toString());
    isActive = method.isActive!;
    isTrial = method.isTrial!;
    getMonths();

    super.onInit();
  }

  // New methods for increment/decrement services count
  void incrementServicesCount() {
    int currentValue = int.tryParse(servicesCountController.text) ?? 0;
    servicesCountController.text = (currentValue + 1).toString();
    update();
  }

  void decrementServicesCount() {
    int currentValue = int.tryParse(servicesCountController.text) ?? 0;
    if (currentValue > 0) {
      servicesCountController.text = (currentValue - 1).toString();
      update();
    }
  }

  // New methods for increment/decrement products count
  void incrementProductsCount() {
    int currentValue = int.tryParse(productsCountController.text) ?? 0;
    productsCountController.text = (currentValue + 1).toString();
    update();
  }

  void decrementProductsCount() {
    int currentValue = int.tryParse(productsCountController.text) ?? 0;
    if (currentValue > 0) {
      productsCountController.text = (currentValue - 1).toString();
      update();
    }
  }

  // New methods for toggle switches
  void toggleTrial(bool value) {
    isTrial = value;
    update();
  }

  void toggleActive(bool value) {
    isActive = value;
    update();
  }

  void onTapMonth(PaymentMonths month) {
    selectedMonth = month;
    print(selectedMonth!.durationMonths);
    update();
  }

  String validUserData(val) {
    if (val?.isEmpty ?? true) {
      return "can't be empty".tr;
    }
    return "";
  }

  Future<void> editPackage() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      statusRequest = StatusRequest.loading;

      final response = await CustomRequest(
          data: {
            "name": nameController.text,
            "price": priceController.text,
            "months_plan_id": selectedMonth!.id,
            "service_count": servicesCountController.text,
            "product_count": productsCountController.text,
            "is_trial": isTrial ? 1 : 0,
            "trial_days": trailsDaysController.text,
            "is_active": isActive ? 1 : 0,
          },
          path: ApiConstance.editPaymentPackage(method.id),
          fromJson: (json) {
            return json['data'];
          }).sendPutRequest();
      response.fold((l) {
        statusRequest = StatusRequest.error;
        Logger().e(l.errMsg);
      }, (r) {
        Get.back();
        Get.put(PaymentController()).getPackages();
      });
      update();
    } else {
      print("not valid");
    }
  }

  Future<void> deleteMonth(int id) async {
    statusRequestMonths = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.deletePaymentMonth(id.toString()),
        fromJson: (json) {
          return json['message'];
        }).sendDeleteRequest();
    response.fold((l) {
      statusRequestMonths = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      getMonths();
    });
    update();
  }

  Future<void> addMonths() async {
    print(monthsDurationController.text);
    if (addMonthFormKey.currentState!.validate()) {
      addMonthFormKey.currentState!.save();
      statusRequestMonths = StatusRequest.loading;
      final response = await CustomRequest(
          data: {
            "duration_months": monthsDurationController.text,
          },
          path: ApiConstance.addPaymentMonths,
          fromJson: (json) {
            return json['data'];
          }).sendPostRequest();
      response.fold((l) {
        statusRequestMonths = StatusRequest.error;
        Logger().e(l.errMsg);
      }, (r) {
        Get.back();
        getMonths();
        monthsDurationController.clear();
        // nameEnController.clear();
      });
      update();
    } else {
      print("not valid");
    }
  }

  Future<void> getMonths() async {
    statusRequestMonths = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getPaymentMonths,
        // queryParameters: {"specialization_id": selectedMonth.id},
        fromJson: (json) {
          return json['data']
              .map<PaymentMonths>((type) => PaymentMonths.fromJson(type))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestMonths = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      monthsList.clear();
      monthsList = r;
      selectedMonth =
          monthsList.firstWhere((month) => month.id == method.monthsPlanId);
      if (r.isEmpty) {
        statusRequestMonths = StatusRequest.noData;
      } else {
        statusRequestMonths = StatusRequest.success;
      }
    });
    update();
  }

  @override
  void onClose() {
    nameController.dispose();
    priceController.dispose();
    trailsDaysController.dispose();
    servicesCountController.dispose();
    productsCountController.dispose();
    super.onClose();
  }
}
