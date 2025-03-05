import 'dart:math';

import 'package:b2b_partnership_admin/models/job_details_model.dart';

import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';
import '/core/theme/app_color.dart';
import '/core/utils/app_snack_bars.dart';
import '/models/pervious_work_model.dart';
import '/models/provider_model.dart';
import '/models/review_model.dart';
import '/models/services_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ClientProfileController extends GetxController {
  late PageController pageController;
  int selectedIndex = 0;
  ProviderModel? providerModel;
  late String provId;
  int rating = 0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController reviewController = TextEditingController();
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestReview = StatusRequest.loading;
  StatusRequest statusRequestServices = StatusRequest.loading;
  StatusRequest statusRequestPerviousWork = StatusRequest.loading;
  List<ServiceModelData> providerServices = [];
  List<ProviderPerviousWorkModel> previousWork = [];
  List<ReviewModel> reviews = [];
  List<JobDetailsModel> jobs = [];

  @override
  onInit() async {
    super.onInit();
    pageController = PageController(initialPage: selectedIndex);
    provId = Get.arguments['id'];
    await getProvider();
    getServices();
    getPreviousWork();
    getJobs();
    getReview();
  }

  void addReviewDialog() {
    Get.dialog(
      GetBuilder<ClientProfileController>(
        init: ClientProfileController(),
        builder: (ClientProfileController controller) {
          return AlertDialog(
            title: const Text('Add Review'),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: reviewController,
                    decoration:
                        const InputDecoration(hintText: 'Enter your review'),
                  ),
                  const SizedBox(height: 20),
                  PannableRatingBar(
                    maxRating: 5,
                    minRating: 0,
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    gestureType: GestureType.tapOnly,
                    rate: rating.toDouble(),
                    onChanged: (rating) {
                      this.rating = rating.ceil();

                      update();
                    },
                    items: List.generate(
                      5,
                      (index) {
                        return RatingWidget(
                          child: Icon(
                            FontAwesomeIcons.solidStar,
                            size: 25.w,
                          ),
                          selectedColor: starColor,
                          unSelectedColor: greyColor,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(); // close dialog
                  _addReview();
                },
                child: const Text('Submit'),
              ),
            ],
          );
        },
      ),
    );
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

  Future<void> getProvider() async {
    statusRequest = StatusRequest.loading;
    final result = await CustomRequest<ProviderModel>(
      path: ApiConstance.getProviderProfileDetails(provId),
      fromJson: (json) {
        return ProviderModel.fromJson(json['data']);
      },
    ).sendGetRequest();
    result.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
      update();
    }, (r) {
      providerModel = r;
      statusRequest = StatusRequest.success;
      update();
    });
  }

  Future<void> getReview() async {
    statusRequestReview = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getReviewServices,
        data: {"provider_id": provId},
        fromJson: (json) {
          return json['data']
              .map<ReviewModel>((type) => ReviewModel.fromJson(type))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestReview = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      reviews.clear();
      statusRequestReview = StatusRequest.success;
      reviews = r;
      if (r.isEmpty) {
        statusRequestReview = StatusRequest.noData;
      } else {
        statusRequestReview = StatusRequest.success;
      }
    });
    update();
  }

  Color getRandomColor() {
    final random = Random();
    return Color.fromRGBO(
      100 + random.nextInt(156),
      100 + random.nextInt(156),
      100 + random.nextInt(156),
      1,
    );
  }

  Future<void> _addReview() async {
    if (formKey.currentState!.validate()) {
      statusRequest = StatusRequest.loading;

      final result = await CustomRequest<Map<String, dynamic>>(
          path: ApiConstance.addReview,
          fromJson: (json) {
            return json;
          },
          data: {
            "rating": rating,
            "review": reviewController.text,
            "user_id": Get.find<AppPreferences>().getUserId(),
            "provider_id": provId
          }).sendPostRequest();
      result.fold((l) {
        statusRequest = StatusRequest.error;
        Logger().e(l.errMsg);
        AppSnackBars.error(message: l.errMsg);
        update();
      }, (r) {
        AppSnackBars.success(message: r['message']);
        rating = 0;
        reviewController.clear();
        getReview();
        update();
      });
    }
  }

  void deleteReviewDialog(id) {
    Get.defaultDialog(
        title: "Delete Review",
        titleStyle: TextStyle(fontSize: 15.sp),
        middleText: "Are you sure you want to\ndelete this review?",
        textConfirm: "Yes",
        textCancel: "No",
        onConfirm: () {
          _deleteReview(id);
        });
  }

  void _deleteReview(id) async {
    final result = await CustomRequest<String>(
      data: {"provider_id": providerModel!.providerId},
      path: ApiConstance.deleteReview(id),
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
        getReview();
        AppSnackBars.success(message: data);
      },
    );
  }

// ---- services
  Future<void> getServices() async {
    statusRequestServices = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getProviderServices(provId),
        fromJson: (json) {
          return json["data"]
              .map<ServiceModelData>(
                  (service) => ServiceModelData.fromJson(service))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestServices = StatusRequest.error;
    }, (r) {
      providerServices.clear();
      providerServices = r;
      statusRequestServices =
          r.isEmpty ? StatusRequest.noData : StatusRequest.success;
    });
    update();
  }

  void deleteServiceDialog(id) {
    Get.defaultDialog(
        title: "Delete Service",
        titleStyle: TextStyle(fontSize: 15.sp),
        middleText: "Are you sure you want to\ndelete this service?",
        textConfirm: "Yes",
        textCancel: "No",
        onConfirm: () {
          _deleteService(id);
        });
  }

  void _deleteService(id) async {
    final result = await CustomRequest<String>(
      path: ApiConstance.deleteProviderService(id),
      fromJson: (json) {
        return json["message"];
      },
    ).sendDeleteRequest();
    result.fold(
      (error) {
        AppSnackBars.error(message: error.errMsg);
      },
      (data) {
        getServices();
        AppSnackBars.success(message: data);
      },
    );
  }

// ---- previous work
  Future<void> getPreviousWork() async {
    statusRequestPerviousWork = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getProviderPerviousWork,
        data: {"provider_id": providerModel!.providerId},
        fromJson: (json) {
          return json["data"]
              .map<ProviderPerviousWorkModel>(
                  (model) => ProviderPerviousWorkModel.fromJson(model))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestPerviousWork = StatusRequest.error;
    }, (r) {
      previousWork.clear();
      previousWork = r;
      statusRequestPerviousWork =
          r.isEmpty ? StatusRequest.noData : StatusRequest.success;
    });
    update();
  }

  void deletePreviousWorkDialog(id) {
    Get.defaultDialog(
        title: "Delete previous work",
        titleStyle: TextStyle(fontSize: 15.sp),
        middleText: "Are you sure you want to\ndelete this work?",
        textConfirm: "Yes",
        textCancel: "No",
        onConfirm: () {
          _deletePreviousWork(id);
        });
  }

  void _deletePreviousWork(id) async {
    final result = await CustomRequest<String>(
      data: {"provider_id": providerModel!.providerId},
      path: ApiConstance.deletePreviousWork(id),
      fromJson: (json) {
        return json["message"];
      },
    ).sendDeleteRequest();
    result.fold(
      (error) {
        AppSnackBars.error(message: error.errMsg);
      },
      (data) {
        getPreviousWork();
        AppSnackBars.success(message: data);
      },
    );
  }

// ------ jobs
  Future<void> getJobs() async {
    statusRequestServices = StatusRequest.loading;
    final response = await CustomRequest(
        data: {"provider_id": providerModel!.providerId},
        path: ApiConstance.getProviderJob,
        fromJson: (json) {
          return json["data"]
              .map<JobDetailsModel>(
                  (service) => JobDetailsModel.fromJson(service))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestServices = StatusRequest.error;
    }, (r) {
      jobs.clear();
      jobs = r;
      statusRequestServices =
          r.isEmpty ? StatusRequest.noData : StatusRequest.success;
    });
    update();
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
      data: {"provider_id": providerModel!.providerId},
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
