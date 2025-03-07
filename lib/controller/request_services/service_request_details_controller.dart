import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';
import '/core/utils/app_snack_bars.dart';
import '/models/city_model.dart';
import '/models/country_model.dart';
import '/models/price_offer_model.dart';
import '/models/service_request_model.dart';
import '/models/specialize_model.dart';
import '/models/sub_specialize_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ServiceRequestDetailsController extends GetxController {
  late ServiceRequestModel model;
  List<ModelData> priceOffers = [];
  List<ModelData> providerOffers = [];
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestOffers = StatusRequest.loading;
  //   StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestSearch = StatusRequest.loading;
  StatusRequest statusRequestCity = StatusRequest.loading;
  StatusRequest statusRequestSpecialization = StatusRequest.loading;
  StatusRequest statusRequestSupSpecialization = StatusRequest.loading; //
  int currentPage = 0;
  int totalPage = 1;
  bool isPageLoading = false;
  final scrollController = ScrollController(
    initialScrollOffset: 0,
    keepScrollOffset: true,
  );

  CountryModel? selectedCountry;
  CityModel? selectedCity;
  SpecializeModel? selectedSpecialization;
  SubSpecializeModel? selectedSubSpecialization;

  List<CountryModel> countries = [];
  List<CityModel> cities = [];
  List<SpecializeModel> specializations = [];
  List<SubSpecializeModel> subSpecializations = [];
  bool enable = false;

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

  void addPriceDialog() {
    Get.dialog(
      GetBuilder<ServiceRequestDetailsController>(
        init: ServiceRequestDetailsController(),
        builder: (ServiceRequestDetailsController controller) {
          return AlertDialog(
            title: const Text('Add Price Offer'),
            titleTextStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.green),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: priceController,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 13.sp),
                        hintText: 'offer price'),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: null,
                    decoration: InputDecoration(
                        hintStyle: TextStyle(fontSize: 13.sp),
                        hintText: 'offer description'),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(); // close dialog
                  _addOffer();
                },
                child: const Text('Submit'),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _addOffer() async {
    if (formKey.currentState!.validate()) {
      statusRequest = StatusRequest.loading;

      final result = await CustomRequest<Map<String, dynamic>>(
          path: ApiConstance.addPriceOffer,
          fromJson: (json) {
            return json;
          },
          data: {
            "provider_id": Get.find<AppPreferences>().getUserRoleId(),
            "request_service_id": model.id,
            "offer_description": descriptionController.text,
            "price": priceController.text
          }).sendPostRequest();
      result.fold((l) {
        statusRequest = StatusRequest.error;
        Logger().e(l.errMsg);
        AppSnackBars.error(message: l.errMsg);
        update();
      }, (r) {
        AppSnackBars.success(message: r['message']);
        getProviderOffers();
        update();
      });
    }
  }

  Future<void> deleteOffer(String id) async {
    statusRequest = StatusRequest.loading;

    final result = await CustomRequest<Map<String, dynamic>>(
        path: ApiConstance.deletePriceOffer(id),
        fromJson: (json) {
          return json;
        }).sendDeleteRequest();
    result.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
      AppSnackBars.error(message: l.errMsg);
      update();
    }, (r) {
      AppSnackBars.success(message: r['message']);

      getProviderOffers();
      update();
    });
  }

  Future<void> getPriceOffers() async {
    if (currentPage < totalPage) {
      isPageLoading = true;
      update();
      statusRequest = StatusRequest.loading;
      final response = await CustomRequest(
          path: ApiConstance.getServicePriceOffer,
          data: {"request_service_id": model.id!, "page": currentPage + 1},
          fromJson: (json) {
            return PriceOfferModel.fromJson(json);
          }).sendGetRequest();
      response.fold((l) {
        statusRequest = StatusRequest.error;
        Logger().e(l.errMsg);
      }, (r) {
        priceOffers.clear();

        priceOffers = r.data!;
        if (r.data!.isEmpty) {
          statusRequest = StatusRequest.noData;
        } else {
          statusRequest = StatusRequest.success;
        }
        totalPage = r.lastPage!;
        currentPage = r.currentPage!;
      });

      isPageLoading = false;
      update();
    }
  }

  Future<void> getProviderOffers() async {
    statusRequest = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getProviderOffersInPost,
        data: {"request_service_id": model.id!},
        fromJson: (json) {
          //  print(json);
          return json["data"]
              .map<ModelData>((offer) => ModelData.fromJson(offer))
              .toList();
          // return PriceOfferModel.fromJson(json['data']);
        }).sendPostRequest();
    response.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      providerOffers.clear();

      providerOffers = r;
      if (r.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
    });

    update();
  }

  Future<void> acceptPriceOffers(String id) async {
    statusRequestOffers = StatusRequest.loading;
    update();
    final response = await CustomRequest<Map<String, dynamic>>(
        path: ApiConstance.acceptPriceOffers(id),
        fromJson: (json) {
          return json;
        }).sendPatchRequest();
    response.fold((l) {
      statusRequestOffers = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      statusRequestOffers = StatusRequest.success;
      priceOffers.clear();
      currentPage = 0;
      totalPage = 0;
      getPriceOffers();
    });

    update();
  }
}
