import 'package:b2b_partnership_admin/core/crud/custom_request.dart';
import 'package:b2b_partnership_admin/core/enums/status_request.dart';
import 'package:b2b_partnership_admin/core/network/api_constance.dart';
import 'package:b2b_partnership_admin/core/utils/app_snack_bars.dart';
import 'package:b2b_partnership_admin/models/complaints_user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ComplaintsUsersController extends GetxController {
  StatusRequest statusRequestClients = StatusRequest.loading;
  StatusRequest statusRequestProviders = StatusRequest.loading;
  List<ComplaintsUserModel> clients = [];
  List<ComplaintsUserModel> providers = [];
  TabController? tabController;

  @override
  void onInit() {
    getClientsComplaints();
    getProvidersComplaints();
    super.onInit();
  }

  Future<void> getClientsComplaints() async {
    statusRequestClients = StatusRequest.loading;
    update();
    final result = await CustomRequest<List<ComplaintsUserModel>>(
      path: ApiConstance.getUsersComplaints,
      fromJson: (json) {
        return List<ComplaintsUserModel>.from(
          json['clients'].map(
            (x) => ComplaintsUserModel.fromJson(x),
          ),
        );
      },
    ).sendGetRequest();

    result.fold(
      (error) {
        statusRequestClients = StatusRequest.error;
        AppSnackBars.error(message: error.errMsg);
      },
      (data) {
        clients = data;
        if (clients.isEmpty) {
          statusRequestClients = StatusRequest.noData;
        } else {
          statusRequestClients = StatusRequest.success;
        }
      },
    );
    update();
  }

  Future<void> getProvidersComplaints() async {
    statusRequestProviders = StatusRequest.loading;
    update();
    final result = await CustomRequest<List<ComplaintsUserModel>>(
      path: ApiConstance.getUsersComplaints,
      fromJson: (json) {
        return List<ComplaintsUserModel>.from(
          json['providers'].map(
            (x) => ComplaintsUserModel.fromJson(x),
          ),
        );
      },
    ).sendGetRequest();

    result.fold(
      (error) {
        AppSnackBars.error(message: error.errMsg);
        statusRequestProviders = StatusRequest.error;
      },
      (data) {
        providers = data;
        if (providers.isEmpty) {
          statusRequestProviders = StatusRequest.noData;
        } else {
          statusRequestProviders = StatusRequest.success;
        }
      },
    );
    update();
  }
}
