import 'dart:io';

import '/controller/provider/my_services/get_my_service_controller.dart';
import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/global/widgets/custom_loading_button.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';
import '/core/utils/app_snack_bars.dart';
import '/models/city_model.dart';
import '/models/country_model.dart';
import '/models/service_feature_model.dart';
import '/models/services_model.dart';
import '/models/specialize_model.dart';
import '/models/sub_specialize_model.dart';
import '/views/provider_app/my_services/widgets/edit_provider_service_details_widget.dart';
import '/views/provider_app/my_services/widgets/edit_provider_service_features_widget.dart';
import '/widgets/request_services/build_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditProviderServiceController extends GetxController {
  ServiceModelData? service;
  final formKey = GlobalKey<FormState>();
  final TextEditingController governmentIdController = TextEditingController();
  final TextEditingController subSpecializationIdController =
      TextEditingController();
  final TextEditingController titleArController = TextEditingController();
  final TextEditingController titleEnController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController overviewController = TextEditingController();
  final TextEditingController videoController = TextEditingController();

  final arFeatureController = TextEditingController();
  final enFeatureController = TextEditingController();

  CountryModel? selectedCountry;
  CityModel? selectedCity;
  SpecializeModel? selectedSpecialization;
  SubSpecializeModel? selectedSubSpecialization;
  File? imageFile;
  String image = "";

  List<CountryModel> countries = [];
  List<CityModel> cities = [];
  List<SpecializeModel> specializations = [];
  List<SubSpecializeModel> subSpecializations = [];
  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestCity = StatusRequest.loading;
  StatusRequest statusRequestCountry = StatusRequest.loading;
  StatusRequest statusRequestSpecialization = StatusRequest.loading;
  StatusRequest statusRequestSupSpecialization = StatusRequest.loading;
  StatusRequest statusRequestFeature = StatusRequest.loading;

  List<ServiceFeatureModel> serviceFeatures = [];

  final tabs = [
    Tab(
      text: 'Service Details',
    ),
    Tab(
      text: 'Features',
    ),
  ];

  tabBarViews(EditProviderServiceController controller) => [
        EditProviderServiceDetailsWidget(controller: controller),
        EditProviderServiceFeaturesWidget(controller: controller),
      ];

  @override
  Future<void> onInit() async {
    service = Get.arguments["service"];
    titleArController.text = service?.nameAr ?? "";
    titleEnController.text = service?.nameEn ?? "";
    addressController.text = service?.address ?? "";
    descriptionController.text = service?.description ?? "";
    overviewController.text = service?.overview ?? "";
    videoController.text = service?.video ?? "";
    image = service?.image ?? "";

    await getServiceFeature();
    await getCountries();
    selectedCountry = countries.firstWhere(
      (element) => element.id!.toString() == service!.countryId!,
    );
    await getCities();
    selectedCity = cities.firstWhere(
      (element) => element.id!.toString() == service!.governmentsId!,
    );
    await getSpecialization();
    selectedSpecialization = specializations.firstWhere(
      (element) => element.id!.toString() == service!.specializationId!,
    );
    await getSupSpecialization();
    selectedSubSpecialization = subSpecializations.firstWhere(
      (element) => element.id!.toString() == service!.subSpecializationId!,
    );
    super.onInit();
  }

  Future<void> getServiceFeature() async {
    statusRequestFeature = StatusRequest.loading;
    update();
    final response = await CustomRequest<List<ServiceFeatureModel>>(
        path: ApiConstance.getFeatureServices,
        data: {
          "provider_service_id": service!.id,
        },
        fromJson: (json) {
          return json['data']
              .map<ServiceFeatureModel>(
                  (type) => ServiceFeatureModel.fromJson(type))
              .toList();
        }).sendGetRequest();

    response.fold((l) {
      statusRequestFeature = StatusRequest.error;
    }, (r) {
      serviceFeatures.clear();
      statusRequestFeature = StatusRequest.success;
      serviceFeatures = r;

      if (r.isEmpty) {
        statusRequestFeature = StatusRequest.noData;
      } else {
        statusRequestFeature = StatusRequest.success;
      }
    });
    update();
  }

  onCountryChanged(value) {
    selectedCountry = value;
    debugPrint('Selected Country: $value');
    getCities();
    update();
  }

  onCityChanged(value) {
    selectedCity = value;
    debugPrint('Selected city: $value');
    update();
  }

  onSpecializeChanged(value) {
    selectedSpecialization = value;
    debugPrint('Selected specialize: $value');
    getSupSpecialization();
    update();
  }

  onSubSpecializeChanged(value) {
    selectedSubSpecialization = value;
    debugPrint('Selected sub specialize: $value');
    update();
  }

  validUserData(val) {
    if (val?.isEmpty ?? true) {
      return "can't be empty".tr;
    }
  }

  galleryImage() async {
    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = File(xfile!.path);
    Get.defaultDialog(
        content: SizedBox(
          width: 300,
          height: 300,
          child: Image.file(
            imageFile!,
            fit: BoxFit.cover,
          ),
        ),
        onCancel: () {
          imageFile = null;
          update();
        },
        onConfirm: () {
          // add();
          Get.back();
        });
    update();
  }

  Future<void> updateServices() async {
    try {
      if (formKey.currentState?.validate() ?? false) {
        final result = await CustomRequest<Map<String, dynamic>>(
            path: ApiConstance.updateProviderService(service?.id ?? ""),
            fromJson: (json) {
              return json;
            },
            files: {
              if (imageFile != null) "image": imageFile!.path,
            },
            data: {
              "provider_id": Get.find<AppPreferences>().getUserRoleId(),
              "governments_id": selectedCity?.id,
              "sub_specialization_id": selectedSubSpecialization?.id,
              "name_ar": titleEnController.text,
              "name_en": titleEnController.text,
              "address": addressController.text,
              "description": descriptionController.text,
              "overview": overviewController.text,
              if (videoController.text.isNotEmpty)
                "video": videoController.text,
            }).sendPostRequest();

        result.fold((l) {
          statusRequest = StatusRequest.error;
          AppSnackBars.error(message: l.errMsg);
          update();
        }, (r) {
          // Get.back();
          Get.put(GetMyServiceController()).getServices();
          AppSnackBars.success(message: r['message']);
          statusRequest = StatusRequest.success;

          update();
        });
      } else {
        AppSnackBars.warning(message: "please fill all fields");
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getCountries() async {
    statusRequestCountry = StatusRequest.loading;
    final result = await CustomRequest<List<CountryModel>>(
      path: ApiConstance.countries,
      fromJson: (json) {
        return json['data']
            .map<CountryModel>((element) => CountryModel.fromJson(element))
            .toList(); //. json['data'];
      },
    ).sendGetRequest();

    result.fold((l) {
      statusRequestCountry = StatusRequest.error;
      update();
    }, (r) {
      countries = r;
      selectedCountry = r[0];
      if (r.isEmpty) {
        statusRequestCountry = StatusRequest.noData;
      } else {
        statusRequestCountry = StatusRequest.success;
      }
      update();
    });
  }

  Future<void> getCities() async {
    statusRequestCity = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.cities,
        data: {"country_id": selectedCountry?.id},
        fromJson: (json) {
          return json['data']
              .map<CityModel>((city) => CityModel.fromJson(city))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestCity = StatusRequest.error;
    }, (r) {
      cities.clear();
      cities = r;
      if (r.isEmpty) {
        statusRequestCity = StatusRequest.noData;
      } else {
        selectedCity = r[0];
        statusRequestCity = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> getSpecialization() async {
    statusRequestSpecialization = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getSpecialization,
        fromJson: (json) {
          return json['data']
              .map<SpecializeModel>((e) => SpecializeModel.fromJson(e))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestSpecialization = StatusRequest.error;
    }, (r) {
      specializations.clear();
      statusRequestSpecialization = StatusRequest.success;
      specializations = r;
      if (r.isEmpty) {
        statusRequestSpecialization = StatusRequest.noData;
      } else {
        selectedSpecialization = r[0];
        statusRequestSpecialization = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> getSupSpecialization() async {
    statusRequestSupSpecialization = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getSupSpecialization,
        data: {"specialization_id": selectedSpecialization?.id},
        fromJson: (json) {
          return json['data']
              .map<SubSpecializeModel>(
                  (type) => SubSpecializeModel.fromJson(type))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestSupSpecialization = StatusRequest.error;
    }, (r) {
      subSpecializations.clear();
      statusRequestSupSpecialization = StatusRequest.success;
      subSpecializations = r;
      if (r.isEmpty) {
        statusRequestSupSpecialization = StatusRequest.noData;
      } else {
        selectedSubSpecialization = r[0];
        statusRequestSupSpecialization = StatusRequest.success;
      }
    });
    update();
  }

  void removeServiceFeatureDialog({
    required int? id,
  }) {
    Get.defaultDialog(
      title: 'Remove Service Feature',
      middleText: 'Are you sure you want to remove this service feature?',
      textConfirm: 'Yes',
      textCancel: 'No',
      onConfirm: () {
        _removeServiceFeature(id: id);
      },
    );
  }

  Future<void> _removeServiceFeature({
    required int? id,
  }) async {
    if (id == null) {
      AppSnackBars.error(message: "Invalid service feature ID");
      return;
    }

    statusRequest = StatusRequest.loading;
    final response = await CustomRequest<String>(
      path: ApiConstance.deleteProviderServiceFeature(id.toString()),
      fromJson: (json) {
        return json['message'];
      },
    ).sendDeleteRequest();

    response.fold((l) {
      statusRequest = StatusRequest.error;
      AppSnackBars.error(message: l.errMsg);
    }, (r) {
      Get.back();
      AppSnackBars.success(message: "Service feature removed successfully");
      statusRequest = StatusRequest.success;
      Get.put(GetMyServiceController()).getServices(); // Refresh the data
      getServiceFeature();
    });

    update();
  }

  Future<void> addNewServiceFeatureDialog() async {
    await Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
        ),
        height: 0.35.sh,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTextField(
              arFeatureController,
              'Feature Name (Arabic)',
              Icons.abc,
              "Enter arabic name",
              (val) {
                return validUserData(val);
              },
              labelWidth: 200.w,
            ),
            SizedBox(height: 16.h),
            buildTextField(
              enFeatureController,
              'Feature Name (English)',
              Icons.abc,
              "Enter english name",
              (val) {
                return validUserData(val);
              },
              labelWidth: 200.w,
            ),
            SizedBox(height: 20),
            CustomLoadingButton(
              onPressed: () {
                return _addNewServiceFeature();
              },
              text: "Add",
            )
          ],
        ),
      ),
    );
  }

  Future<void> _addNewServiceFeature() async {
    final response = await CustomRequest<ServiceFeatureModel>(
      path: ApiConstance.addProviderServiceFeatures,
      data: {
        "provider_service_id": service?.id?.toString(),
        "feature_ar": arFeatureController.text,
        "feature_en": enFeatureController.text,
      },
      fromJson: (json) {
        return ServiceFeatureModel.fromJson(json['data']);
      },
    ).sendPostRequest();

    response.fold((l) {
      statusRequest = StatusRequest.error;
      AppSnackBars.error(message: l.errMsg);
    }, (r) {
      Get.back();
      AppSnackBars.success(message: "Service feature removed successfully");
      statusRequest = StatusRequest.success;
      Get.put(GetMyServiceController()).getServices(); // Refresh the data
      getServiceFeature();
    });

    update();
  }
}
