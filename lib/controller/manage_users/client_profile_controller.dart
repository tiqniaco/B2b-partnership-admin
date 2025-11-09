import 'package:b2b_partnership_admin/models/client_model.dart';
import 'package:b2b_partnership_admin/models/job_details_model.dart';
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
  late String userId;
  int rating = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController reviewController = TextEditingController();
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestJobs = StatusRequest.loading;
  StatusRequest statusRequestServices = StatusRequest.loading;
  List<ServiceRequestModel> posts = [];
  List<JobDetailsModel> jobs = [];

  @override
  onInit() async {
    super.onInit();
    pageController = PageController(initialPage: selectedIndex);
    clientId = Get.arguments['id'];
    userId = Get.arguments['userId'];
    await getClient();
    getJobs();
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
        path: ApiConstance.getClientServiceRequest(userId),
        fromJson: (json) {
          return json["data"]
              .map<ServiceRequestModel>(
                  (service) => ServiceRequestModel.fromJson(service))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      Logger().e(l.errMsg);
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
        title: "Delete Post".tr,
        titleStyle: TextStyle(fontSize: 15.sp),
        middleText: "Are you sure you want to\ndelete this post?".tr,
        textConfirm: "Yes".tr,
        textCancel: "No".tr,
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

// jobs
  Future<void> getJobs() async {
    statusRequestJobs = StatusRequest.loading;
    final response = await CustomRequest(
        queryParameters: {"provider_id": userId},
        path: ApiConstance.getProviderJob,
        fromJson: (json) {
          return json["data"]
              .map<JobDetailsModel>(
                  (service) => JobDetailsModel.fromJson(service))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestJobs = StatusRequest.error;
    }, (r) {
      jobs.clear();
      jobs = r;
      statusRequestJobs =
          r.isEmpty ? StatusRequest.noData : StatusRequest.success;
    });
    update();
  }

  void deleteJobsDialog(id) {
    Get.defaultDialog(
        title: "Delete Job".tr,
        titleStyle: TextStyle(fontSize: 15.sp),
        middleText: "Are you sure you want to\ndelete this job?".tr,
        textConfirm: "Yes".tr,
        textCancel: "No".tr,
        onConfirm: () {
          _deleteJobs(id);
        });
  }

  void _deleteJobs(id) async {
    final result = await CustomRequest<String>(
      data: {"provider_id": userId},
      path: ApiConstance.deleteJob(id),
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
        getJobs();
        AppSnackBars.success(message: data);
      },
    );
  }
}
