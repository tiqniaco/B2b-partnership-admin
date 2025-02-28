import 'dart:io';

import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';
import '/core/utils/app_snack_bars.dart';
import '/models/city_model.dart';
import '/models/country_model.dart';
import '/models/specialize_model.dart';
import '/models/sub_specialize_model.dart';
import '/widgets/request_services/build_text_form.dart';
import '/widgets/request_services/request_service1.dart';
import '/widgets/request_services/request_service2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import 'get_my_service_controller.dart';

class AddProviderServiceController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController clientIdController = TextEditingController();
  final TextEditingController governmentIdController = TextEditingController();
  final TextEditingController subSpecializationIdController =
      TextEditingController();
  final TextEditingController titleArController = TextEditingController();
  final TextEditingController titleEnController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController overviewController = TextEditingController();
  final TextEditingController videoController = TextEditingController();

  late CountryModel selectedCountry;
  CityModel? selectedCity;
  late SpecializeModel selectedSpecialization;
  late SubSpecializeModel selectedSubSpecialization;

  List<CountryModel> countries = [];
  List<CityModel> cities = [];
  List<SpecializeModel> specializations = [];
  List<SubSpecializeModel> subSpecializations = [];
  int currentStep = 0;

  List<Widget> get steps => [
        const RequestService1(),
        const RequestService2(),
      ];

  StatusRequest statusRequest = StatusRequest.loading;
  StatusRequest statusRequestCity = StatusRequest.loading;
  StatusRequest statusRequestCountry = StatusRequest.loading;
  StatusRequest statusRequestSpecialization = StatusRequest.loading;
  StatusRequest statusRequestSupSpecialization = StatusRequest.loading;
  File? imageFile;

  bool get isLoading =>
      statusRequestCity == StatusRequest.loading ||
      statusRequestCountry == StatusRequest.loading ||
      statusRequestSpecialization == StatusRequest.loading ||
      statusRequestSupSpecialization == StatusRequest.loading;

  List<ServiceFeatureModel> features = [];

  List<Map<String, TextEditingController>> featuresControllers = [];

  void increaseFeatures() {
    featuresControllers.add({
      "arabic": TextEditingController(),
      "english": TextEditingController(),
    });
    features.add(ServiceFeatureModel(
      index: features.length,
      widget: featureWidget(
        arController: featuresControllers.last["arabic"]!,
        enController: featuresControllers.last["english"]!,
        index: features.length,
      ),
    ));
    update();
  }

  void removeFeatures(int index) {
    debugPrint(features.toString());
    if (features.length > 1) {
      features.removeAt(index);
      featuresControllers[index]['arabic']?.dispose();
      featuresControllers[index]['english']?.dispose();
      featuresControllers.removeAt(index);
      update();
    }
  }

  @override
  Future<void> onInit() async {
    await getCountries();
    getCities();
    await getSpecialization();
    getSupSpecialization();
    increaseFeatures();
    super.onInit();
  }

  void nextStep() {
    if (currentStep < steps.length - 1) {
      currentStep++;
      update();
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      currentStep--;
      update();
    }
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

  Future<void> addServices() async {
    try {
      if (imageFile == null) {
        AppSnackBars.warning(message: "please select image");
        return;
      }
      if (formKey.currentState?.validate() ?? false) {
        formKey.currentState!.save();
        statusRequest = StatusRequest.loading;
        Map<String, String> features = {};
        for (int index = 0; index < featuresControllers.length; index++) {
          features.addAll({
            "features_ar[$index]":
                featuresControllers[index]["arabic"]?.text ?? "",
            "features_en[$index]":
                featuresControllers[index]["english"]?.text ?? "",
          });
        }

        final result = await CustomRequest<Map<String, dynamic>>(
            path: ApiConstance.addProviderService,
            fromJson: (json) {
              return json;
            },
            files: {
              "image": imageFile!.path,
            },
            data: {
              "provider_id": Get.find<AppPreferences>().getUserRoleId(),
              "governments_id": selectedCity?.id,
              "sub_specialization_id": selectedSubSpecialization.id,
              "name_ar": titleEnController.text,
              "name_en": titleEnController.text,
              "address": addressController.text,
              "description": descriptionController.text,
              "overview": overviewController.text,
              if (videoController.text.isNotEmpty)
                "video": videoController.text,
              ...features,
            }).sendPostRequest();

        result.fold((l) {
          statusRequest = StatusRequest.error;
          Logger().e(l.errMsg);
          AppSnackBars.error(message: l.errMsg);
          update();
        }, (r) {
          Get.back();
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
      Logger().e(l.errMsg);
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
        data: {"country_id": selectedCountry.id},
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
      Logger().e(l.errMsg);
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
        data: {"specialization_id": selectedSpecialization.id},
        fromJson: (json) {
          return json['data']
              .map<SubSpecializeModel>(
                  (type) => SubSpecializeModel.fromJson(type))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestSupSpecialization = StatusRequest.error;
      Logger().e(l.errMsg);
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

  StepState getStepStats(bool selected) {
    return selected ? StepState.editing : StepState.indexed;
  }

  void onStepContinue() {
    if (currentStep < 2) {
      currentStep++;
      update();
    }
  }

  void onStepCancel() {
    if (currentStep > 0) {
      currentStep--;
      update();
    }
  }

  void onStepTaped(int value) {
    currentStep = value;
    update();
  }

  @override
  void dispose() {
    titleArController.dispose();
    titleEnController.dispose();
    descriptionController.dispose();
    addressController.dispose();
    super.dispose();
  }
}

Widget featureWidget({
  required TextEditingController arController,
  required TextEditingController enController,
  required int index,
}) {
  final controller = Get.put(AddProviderServiceController());
  return Column(
    children: [
      Gap(20.h),
      buildTextField(
        arController,
        "Feature Arabic Title",
        Icons.featured_play_list,
        "enter feature arabic title",
        (val) {
          return controller.validUserData(val);
        },
      ),
      Gap(20.h),
      buildTextField(
        enController,
        "Feature English Title",
        Icons.featured_play_list,
        "enter feature english title",
        (val) {
          return controller.validUserData(val);
        },
      ),
    ],
  );
}

class ServiceFeatureModel extends Equatable {
  final int index;
  final Widget widget;

  const ServiceFeatureModel({
    required this.index,
    required this.widget,
  });

  @override
  List<Object?> get props => [index, widget];
}
