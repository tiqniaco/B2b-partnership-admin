import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/models/price_offer_model.dart';
import '/models/service_request_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ServiceRequestDetailsController extends GetxController {
  late ServiceRequestModel model;
  List<PriceOfferModel> priceOffers = [];
  StatusRequest statusRequest = StatusRequest.loading;
  int currentPage = 0;
  int totalPage = 1;
  bool isPageLoading = false;
  final scrollController = ScrollController(
    initialScrollOffset: 0,
    keepScrollOffset: true,
  );
  @override
  void onInit() {
    model = Get.arguments['model'];
    scrollController.addListener(scrollFunction);
    getPriceOffers();
    super.onInit();
  }

  scrollFunction() async {
    if (isPageLoading) {
      return;
    }
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      getPriceOffers();
    }
  }

  Future<void> getPriceOffers() async {
    update();
    statusRequest = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getServicePriceOffer,
        data: {"request_service_id": model.id!, "page": currentPage + 1},
        fromJson: (json) {
          return json["data"]
              .map<PriceOfferModel>((offer) => PriceOfferModel.fromJson(offer))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      priceOffers.clear();

      priceOffers = r!;
      if (r.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
      // totalPage = r.lastPage!;
      // currentPage = r.currentPage!;
    });

    update();
  }

  // Future<void> nextPage() async {
  //   if (currentPage < totalPage) {
  //     isPageLoading = true;
  //     update();
  //     final result = await allPatientsRepo.getAllPatient(
  //       page: currentPage + 1,
  //       search: searchController.text == '' ? null : searchController.text,
  //     );
  //     result.fold((failure) {
  //       AppSnackBars.error(message: failure.errMsg);
  //       isPageLoading = false;
  //       update();
  //     }, (data) {
  //       totalPage = data.lastPage!;
  //       currentPage = data.currentPage!;
  //       list.addAll(data.data!);
  //       isPageLoading = false;
  //       update();
  //     });
  //   }
  // }
}
