import 'dart:io';

import '/controller/provider/setting/provider_setting_controller.dart';
import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/core/services/app_prefs.dart';
import '/core/utils/app_snack_bars.dart';
import '/models/city_model.dart';
import '/models/country_model.dart';
import '/models/provider_model.dart';
import '/models/provider_type_model.dart';
import '/models/specialize_model.dart';
import '/models/sub_specialize_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class ProviderSettingEditProfileController extends GetxController {
  ProviderModel? model;
  StatusRequest statusRequest = StatusRequest.loading;
  bool removeAccountLoading = false;
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final bioController = TextEditingController();
  final commercialController = TextEditingController();
  final taxCartController = TextEditingController();
  File? image;
  String governmentId = '';
  File? commercePdfFile;
  File? taxPdfFile;

  List<CountryModel> countries = [];
  List<CityModel> cities = [];

  List<ProviderTypeModel> providerTypes = [];

  List<SpecializeModel> specializations = [];
  List<SubSpecializeModel> subSpecializations = [];

  late CountryModel selectedCountry;
  late CityModel selectedCity;
  late ProviderTypeModel selectedProviderType;
  late SpecializeModel selectedSpecialization;
  late SubSpecializeModel selectedSubSpecialization;

  StatusRequest statusRequestCountry = StatusRequest.loading;
  StatusRequest statusRequestCity = StatusRequest.loading;
  StatusRequest statusRequestProviderType = StatusRequest.loading;
  StatusRequest statusRequestSpecialization = StatusRequest.loading;
  StatusRequest statusRequestSupSpecialization = StatusRequest.loading;

  @override
  Future<void> onInit() async {
    model = Get.arguments['model'] as ProviderModel;
    await getCountries();
    selectedCountry = countries.firstWhere(
      (element) => element.id.toString() == model?.countryId,
    );
    await getCities();
    selectedCity = cities.firstWhere(
      (element) => element.id.toString() == model?.governmentId,
    );
    await getProviderTypes();
    selectedProviderType = providerTypes.firstWhere(
      (element) => element.id.toString() == model?.providerTypeId,
    );
    await getSpecialization();
    selectedSpecialization = specializations.firstWhere(
      (element) => element.id.toString() == model?.specializationId,
    );
    await getSupSpecialization();
    selectedSubSpecialization = subSpecializations.firstWhere(
      (element) => element.id.toString() == model?.subSpecializationId,
    );
    nameController.text = model?.name ?? '';
    emailController.text = model?.email ?? '';
    phoneController.text = model?.phone ?? '';
    bioController.text = model?.bio ?? "";
    taxCartController.text = model!.taxCard?.split('/').last ?? "";
    commercialController.text =
        model?.commercialRegister?.split('/').last ?? "";

    super.onInit();
  }

  validUserData(val) {
    if (val.isEmpty) {
      return "can't be empty".tr;
    }
  }

  Future<void> getCountries() async {
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
      if (r.isEmpty) {
        statusRequestCountry = StatusRequest.noData;
      } else {
        selectedCountry = countries.first;
        statusRequestCountry = StatusRequest.success;
      }
      update();
    });
  }

  Future<void> getCities() async {
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
        selectedCity = cities.first;
        statusRequestCity = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> getProviderTypes() async {
    // statusRequestProviderType = StatusRequest.loading;
    final response = await CustomRequest(
        path: ApiConstance.getProviderTypes,
        fromJson: (json) {
          return json['data']
              .map<ProviderTypeModel>(
                  (type) => ProviderTypeModel.fromJson(type))
              .toList();
        }).sendGetRequest();
    response.fold((l) {
      statusRequestProviderType = StatusRequest.error;
      Logger().e(l.errMsg);
    }, (r) {
      providerTypes.clear();
      statusRequestProviderType = StatusRequest.success;
      providerTypes = r;
      if (r.isEmpty) {
        statusRequestProviderType = StatusRequest.noData;
      } else {
        selectedProviderType = providerTypes.first;
        statusRequestProviderType = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> getSpecialization() async {
    // statusRequestSpecialization = StatusRequest.loading;
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
        selectedSpecialization = specializations.first;
        statusRequestSpecialization = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> getSupSpecialization() async {
    // statusRequestSupSpecialization = StatusRequest.loading;
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
        selectedSubSpecialization = subSpecializations.first;
        statusRequestSupSpecialization = StatusRequest.success;
      }
    });
    update();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      update();
    }
  }

  onCountryChanged(value) {
    selectedCountry = value;
    debugPrint('Selected Country: $value');
    phoneController.clear();
    getCities();
    update();
  }

  onCityChanged(value) {
    selectedCity = value;
    debugPrint('Selected city: $value');
    update();
  }

  onProviderTypeChanged(value) {
    selectedProviderType = value;
    debugPrint('Selected type: $value');
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

  Future<void> updateProfile() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      update();
      final id = Get.find<AppPreferences>().getUserRoleId();

      final result = await CustomRequest<String>(
        path: ApiConstance.updateProviderProfile(id),
        fromJson: (json) {
          return json['message'];
        },
        data: {
          "name": nameController.text,
          "email": emailController.text,
          "country_code": selectedCountry.code,
          "phone": phoneController.text,
          "bio": bioController.text,
          "government_id": selectedCity.id,
          "sub_specialization_id": selectedSubSpecialization.id,
          "provider_types_id": selectedProviderType.id,
        },
        files: {
          if (image != null) "image": image?.path ?? '',
          if (taxPdfFile != null) "tax_card": taxPdfFile?.path ?? '',
          if (commercePdfFile != null) "tax_card": commercePdfFile?.path ?? '',
        },
      ).sendPostRequest();
      result.fold((l) {
        Logger().e(l.errMsg);
        AppSnackBars.error(message: l.errMsg);
        update();
      }, (r) {
        Get.back();
        AppSnackBars.success(message: r);
        Get.put(ProviderSettingController()).getMenuModel();
        update();
      });
    }
  }

  removeFile(String file) {
    if (file == "c") {
      commercePdfFile = null;
      commercialController.clear();
    } else {
      taxPdfFile = null;
      taxCartController.clear();
    }
    update();
  }

  Future<void> pickPDF(String fileName) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      if (fileName == "c") {
        commercePdfFile = File(result.files.single.path!);
        commercialController.text = result.files.single.name;
        debugPrint("File selected: ${commercePdfFile!.path}");
      } else {
        taxPdfFile = File(result.files.single.path!);
        taxCartController.text = result.files.single.name;
        debugPrint("File selected: ${taxPdfFile!.path}");
      }
    } else {
      debugPrint("No file selected");
    }
    printFiles();
    update();
  }

  printFiles() {
    debugPrint("=============================");
    debugPrint(commercePdfFile?.path ?? "");
    debugPrint(taxPdfFile?.path ?? "");
    debugPrint("=============================");
  }
}
