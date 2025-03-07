import 'package:b2b_partnership_admin/models/client_model.dart';
import 'package:b2b_partnership_admin/models/service_request_model.dart';

import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/core/utils/app_snack_bars.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ClientProfileController extends GetxController {
  late PageController pageController;
  int selectedIndex = 0;
  ClientModel? clientModel;
  late String clientId;
  int rating = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController reviewController = TextEditingController();
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestReview = StatusRequest.loading;
  StatusRequest statusRequestServices = StatusRequest.loading;
  StatusRequest statusRequestPerviousWork = StatusRequest.loading;
  List<ServiceRequestModel> posts = [];

  @override
  onInit() async {
    super.onInit();
    pageController = PageController(initialPage: selectedIndex);
    clientId = Get.arguments['id'];
    await getClient();
    getServices();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void onPageChanged(int index) {
    selectedIndex = index;
    update();
  }

  void onTabTapped(int index) {
    selectedIndex = index;
    pageController.jumpToPage(index);
    update();
  }

  Future<void> getClient() async {
    statusRequest = StatusRequest.loading;
    final result = await CustomRequest<ClientModel>(
      path: ApiConstance.getOneClient(clientId),
      fromJson: (json) {
        return ClientModel.fromJson(json['data']);
      },
    ).sendGetRequest();
    result.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
      update();
    }, (r) {
      clientModel = r;
      statusRequest = StatusRequest.success;
      update();
    });
  }

// ---- services
  Future<void> getServices() async {
    statusRequestServices = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getClientServiceRequest(clientId),
        fromJson: (json) {
          return json["data"]
              .map<ServiceRequestModel>(
                  (service) => ServiceRequestModel.fromJson(service))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestServices = StatusRequest.error;
    }, (r) {
      posts.clear();
      posts = r;
      statusRequestServices =
          r.isEmpty ? StatusRequest.noData : StatusRequest.success;
    });
    update();
  }

  void deleteServiceDialog(id) {
    Get.defaultDialog(
        title: "Delete Post",
        titleStyle: TextStyle(fontSize: 15.sp),
        middleText: "Are you sure you want to\ndelete this post?",
        textConfirm: "Yes",
        textCancel: "No",
        onConfirm: () {
          _deleteService(id);
        });
  }

  void _deleteService(id) async {
    final result = await CustomRequest<String>(
      path: ApiConstance.deletePost(id),
      fromJson: (json) {
        return json["message"];
      },
    ).sendDeleteRequest();
    result.fold(
      (error) {
        AppSnackBars.error(message: error.errMsg);
      },
      (data) {
        Get.back();
        getServices();
        AppSnackBars.success(message: data);
      },
    );
  }
}
