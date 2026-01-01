// ignore_for_file: avoid_print

import 'package:b2b_partnership_admin/core/crud/custom_request.dart';
import 'package:b2b_partnership_admin/core/network/api_constance.dart';
import 'package:b2b_partnership_admin/models/iso_benefits_model.dart';
import 'package:b2b_partnership_admin/models/iso_included_model.dart';
import 'package:b2b_partnership_admin/models/iso_model.dart';
import 'package:b2b_partnership_admin/views/iso/benefit_dialog.dart';
import 'package:b2b_partnership_admin/views/iso/included_dialog.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../core/enums/status_request.dart';

class IsoDetailsController extends GetxController {
  List<IsoIncludedModel> isoIncludedList = [];
  List<IsoBenefitsModel> isoBenefitsList = [];
  late IsoModel iso;
  StatusRequest statusRequestIncluded = StatusRequest.loading;
  StatusRequest statusRequestBenefits = StatusRequest.loading;
  StatusRequest statusRequestAddIncluded = StatusRequest.loading;
  StatusRequest statusRequestAddBenefits = StatusRequest.loading;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Future<void> onInit() async {
    iso = Get.arguments['iso'];
    getIsoIncluded();
    getIsoBenefits();
    super.onInit();
  }

  Future<void> deleteInclude(int id) async {
    statusRequestIncluded = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.isoIncludedWithId(id),
        fromJson: (json) {
          return json['data'];
        }).sendDeleteRequest();
    response.fold((l) {
      statusRequestIncluded = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      getIsoIncluded();
    });
    update();
  }

  Future<void> deleteBenefit(int id) async {
    statusRequestIncluded = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.isoBenefitsWithId(id),
        fromJson: (json) {
          return json['data'];
        }).sendDeleteRequest();
    response.fold((l) {
      statusRequestIncluded = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      getIsoBenefits();
    });
    update();
  }

  void addIncludedItem(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => IncludedItemDialog(
        functionName: 'add',
        titleController: titleController,
        descriptionController: descriptionController,
        onAdd: () async {
          await addInclude();
        },
      ),
    );
  }

  void addBenefitItem(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BenefitDialog(
        functionName: 'add',
        benefitController: titleController,
        onAdd: () async {
          await addBenefits();
        },
      ),
    );
  }

  void editIncludedItem(
    BuildContext context,
    IsoIncludedModel isoIncludedModel,
  ) {
    titleController.text = isoIncludedModel.title!;
    descriptionController.text = isoIncludedModel.description!;
    showDialog(
      context: context,
      builder: (context) => IncludedItemDialog(
        functionName: "edit",
        titleController: titleController,
        descriptionController: descriptionController,
        onAdd: () async {
          await editInclude(isoIncludedModel.id!);
        },
      ),
    );
  }

  void editBenefitItem(
      BuildContext context, IsoBenefitsModel isoBenefitsModel) {
    titleController.text = isoBenefitsModel.title!;
    showDialog(
      context: context,
      builder: (context) => BenefitDialog(
        functionName: "edit",
        benefitController: titleController,
        onAdd: () async {
          await editBenefits(isoBenefitsModel.id!);
        },
      ),
    );
  }

  Future<void> addBenefits() async {
    statusRequestBenefits = StatusRequest.loading;
    final response = await CustomRequest(
        data: {
          "ios_id": iso.id,
          "title": titleController.text,
        },
        path: ApiConstance.isoBenefits,
        fromJson: (json) {
          return json['data'];
        }).sendPostRequest();
    response.fold((l) {
      statusRequestBenefits = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      titleController.clear();
      getIsoBenefits();
    });
    update();
  }

  Future<void> addInclude() async {
    print(titleController.text);
    print(descriptionController.text);
    statusRequestIncluded = StatusRequest.loading;
    final response = await CustomRequest(
        data: {
          "ios_id": iso.id,
          "title": titleController.text,
          "description": descriptionController.text,
        },
        path: ApiConstance.isoIncluded,
        fromJson: (json) {
          return json['data'];
        }).sendPostRequest();
    response.fold((l) {
      statusRequestIncluded = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      titleController.clear();
      descriptionController.clear();
      getIsoIncluded();
    });
    update();
  }

  Future<void> editBenefits(int id) async {
    statusRequestBenefits = StatusRequest.loading;
    final response = await CustomRequest(
        data: {
          "ios_id": iso.id,
          "title": titleController.text,
        },
        path: ApiConstance.isoBenefitsWithId(id),
        fromJson: (json) {
          return json['data'];
        }).sendPutRequest();
    response.fold((l) {
      statusRequestBenefits = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      titleController.clear();
      getIsoBenefits();
    });
    update();
  }

  Future<void> editInclude(int id) async {
    print(titleController.text);
    print(descriptionController.text);
    statusRequestIncluded = StatusRequest.loading;
    final response = await CustomRequest(
        data: {
          "ios_id": iso.id,
          "title": titleController.text,
          "description": descriptionController.text,
        },
        path: ApiConstance.isoIncludedWithId(id),
        fromJson: (json) {
          return json['data'];
        }).sendPutRequest();
    response.fold((l) {
      statusRequestIncluded = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      titleController.clear();
      descriptionController.clear();
      getIsoIncluded();
    });
    update();
  }

  Future<void> getIsoIncluded() async {
    statusRequestIncluded = StatusRequest.loading;
    update();
    final response = await CustomRequest<List<IsoIncludedModel>>(
        path: ApiConstance.isoIncluded,
        queryParameters: {"ios_id": iso.id},
        fromJson: (json) {
          return json["data"]
              .map<IsoIncludedModel>(
                  (service) => IsoIncludedModel.fromJson(service))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestIncluded = StatusRequest.error;
      update();
    }, (r) {
      isoIncludedList.clear();
      isoIncludedList = r;
      if (r.isEmpty) {
        statusRequestIncluded = StatusRequest.noData;
      } else {
        statusRequestIncluded = StatusRequest.success;
      }
      update();
    });
  }

  Future<void> getIsoBenefits() async {
    statusRequestIncluded = StatusRequest.loading;
    update();
    final response = await CustomRequest<List<IsoBenefitsModel>>(
        path: ApiConstance.isoBenefits,
        queryParameters: {"ios_id": iso.id},
        fromJson: (json) {
          return json["data"]
              .map<IsoBenefitsModel>(
                  (service) => IsoBenefitsModel.fromJson(service))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestIncluded = StatusRequest.error;
      update();
    }, (r) {
      isoBenefitsList.clear();
      isoBenefitsList = r;
      if (r.isEmpty) {
        statusRequestIncluded = StatusRequest.noData;
      } else {
        statusRequestIncluded = StatusRequest.success;
      }
      update();
    });
  }
}
