import 'package:b2b_partnership_admin/core/crud/custom_request.dart';
import 'package:b2b_partnership_admin/core/enums/status_request.dart';
import 'package:b2b_partnership_admin/core/network/api_constance.dart';
import 'package:b2b_partnership_admin/core/utils/app_snack_bars.dart';
import 'package:b2b_partnership_admin/models/job_details_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class JobsController extends GetxController {
  ScrollController scrollController = ScrollController();
  StatusRequest statusRequest = StatusRequest.loading;
  List<JobDetailsModel> jobs = [];
  int currentPage = 1;
  int totalPages = 1;

  @override
  void onInit() {
    scrollController.addListener(() {
      if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        if (currentPage < totalPages) {
          currentPage++;
          getJobs();
        }
      }
    });
    getJobs();
    super.onInit();
  }

  Future<void> getJobs({bool refresh = false}) async {
    if (refresh) {
      currentPage = 1;
      totalPages = 1;
      jobs.clear();
    }
    statusRequest = StatusRequest.loading;
    update();
    final result = await CustomRequest<List<JobDetailsModel>>(
      path: ApiConstance.jobs,
      fromJson: (json) {
        currentPage = json['current_page'];
        totalPages = json['last_page'];
        return List<JobDetailsModel>.from(
          json['data'].map(
            (e) => JobDetailsModel.fromJson(e),
          ),
        );
      },
    ).sendGetRequest();

    result.fold((l) {
      statusRequest = StatusRequest.error;
      update();
    }, (r) {
      jobs.addAll(r);
      if (jobs.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
      update();
    });
  }

  void deleteJobsDialog(id) {
    Get.defaultDialog(
        title: "Delete Job",
        titleStyle: TextStyle(fontSize: 15.sp),
        middleText: "Are you sure you want to\ndelete this job?",
        textConfirm: "Yes",
        textCancel: "No",
        onConfirm: () {
          _deleteJobs(id);
        });
  }

  void _deleteJobs(id) async {
    final result = await CustomRequest<String>(
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
        jobs.clear();
        getJobs();
        AppSnackBars.success(message: data);
      },
    );
  }
}
