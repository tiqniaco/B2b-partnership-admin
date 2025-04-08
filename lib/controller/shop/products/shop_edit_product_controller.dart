import 'dart:io';

import 'package:b2b_partnership_admin/controller/shop/shop_controller.dart';
import 'package:b2b_partnership_admin/core/crud/custom_request.dart';
import 'package:b2b_partnership_admin/core/enums/status_request.dart';
import 'package:b2b_partnership_admin/core/network/api_constance.dart';
import 'package:b2b_partnership_admin/core/utils/app_snack_bars.dart';
import 'package:b2b_partnership_admin/models/product_description_content_model.dart';
import 'package:b2b_partnership_admin/models/product_description_model.dart';
import 'package:b2b_partnership_admin/models/shop_product_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ShopEditProductController extends GetxController {
  StatusRequest statusRequest = StatusRequest.success;
  ShopProductModel? productModel;
  List<ProductDescriptionModel> descriptions = [];
  final formKey = GlobalKey<FormState>();
  final sessionFormKeyEdit = GlobalKey<FormState>();
  final sessionFormKeyAdd = GlobalKey<FormState>();
  final descriptionFormKeyEdit = GlobalKey<FormState>();
  final descriptionFormKeyAdd = GlobalKey<FormState>();
  final stepFormKey = GlobalKey<FormState>();
  final titleArController = TextEditingController();
  final titleEnController = TextEditingController();
  final descriptionEnController = TextEditingController();
  final descriptionArController = TextEditingController();
  final termsAndConditionsEnController = TextEditingController();
  final termsAndConditionsArController = TextEditingController();
  final priceController = TextEditingController();
  final discountController = TextEditingController();
  final sessionDescriptionArController = TextEditingController();
  final sessionDescriptionEnController = TextEditingController();
  final sessionTitleArController = TextEditingController();
  final sessionTitleEnController = TextEditingController();
  File? image;
  File? file;

  @override
  void onInit() {
    productModel = Get.arguments['product'];
    titleArController.text = productModel?.titleAr ?? "";
    titleEnController.text = productModel?.titleEn ?? "";
    descriptionEnController.text = productModel?.descriptionEn ?? "";
    descriptionArController.text = productModel?.descriptionAr ?? "";
    priceController.text = productModel?.price ?? "";
    discountController.text = productModel?.discount ?? "";
    termsAndConditionsEnController.text =
        productModel?.termsAndConditionsEn ?? "";
    termsAndConditionsArController.text =
        productModel?.termsAndConditionsAr ?? "";
    getProductDetails();

    super.onInit();
  }

  void selectImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
    update();
  }

  Future<void> selectFile() async {
    final filePicker = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'doc',
        'docx',
        'xls',
        'xlsx',
        'csv',
        'txt',
        'zip',
        'rar',
        'ppt',
        'pptx',
        'jpg',
        'jpeg',
        'png',
        'gif',
        'svg',
      ],
    );

    if (filePicker != null && filePicker.files.isNotEmpty) {
      file = File(filePicker.files.single.path ?? '');
    }
    update();
  }

  Future<void> getProductDetails() async {
    statusRequest = StatusRequest.loading;
    update();
    final result = await CustomRequest<Map<String, dynamic>>(
      path: ApiConstance.shopProductDetails(productModel!.id.toString()),
      fromJson: (json) {
        return json;
      },
    ).sendGetRequest();

    result.fold(
      (l) {
        AppSnackBars.error(message: l.errMsg);
        statusRequest = StatusRequest.error;
        update();
      },
      (data) {
        print(data);
        // product = ShopProductModel.fromJson(data['data']);
        descriptions = List<ProductDescriptionModel>.from(
          data['descriptions'].map(
            (e) => ProductDescriptionModel.fromJson(e),
          ),
        );
        statusRequest = StatusRequest.success;
        update();
      },
    );
  }

  callBackFun(int index, bool isExpanded) {
    descriptions[index].isExpanded = isExpanded == false ? 0 : 1;
    update();
  }

  Future<void> editProduct() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState!.save();
      final result = await CustomRequest<String>(
        path: ApiConstance.updateProduct(productModel?.id.toString() ?? ''),
        data: {
          'title_ar': titleArController.text,
          'title_en': titleEnController.text,
          'description_ar': descriptionArController.text,
          'description_en': descriptionEnController.text,
          'price': double.parse(priceController.text),
          'discount': double.parse(discountController.text),
        },
        files: {
          if (image != null) "image": image?.path ?? '',
          if (file != null) "file": file?.path ?? '',
        },
        fromJson: (json) {
          return json['message'];
        },
      ).sendPostRequest();

      result.fold(
        (error) {
          AppSnackBars.error(message: error.errMsg);
        },
        (response) {
          Get.back();
          Get.back();
          AppSnackBars.success(message: "Product updated successfully");
          Get.put(ShopController()).getShopProducts(firstTime: true);
        },
      );
    }
  }

  ///============================================
  ///
  ///
  Future<void> addDescription(stepId) async {
    if (descriptionFormKeyAdd.currentState?.validate() ?? false) {
      descriptionFormKeyAdd.currentState!.save();
      final result = await CustomRequest<String>(
        path: ApiConstance.addDescription,
        data: {
          'title_id': stepId,
          'content_ar': sessionDescriptionArController.text,
          'content_en': sessionDescriptionArController.text,
        },
        fromJson: (json) {
          return json['message'];
        },
      ).sendPostRequest();
      result.fold(
        (error) {
          AppSnackBars.error(message: error.errMsg);
        },
        (response) {
          Get.back();
          Get.back();
          sessionDescriptionArController.clear();
          sessionDescriptionEnController.clear();
          AppSnackBars.success(message: "Description added successfully");
          getProductDetails();
        },
      );
    }
  }

  onCancelAddDescription() {
    Get.back();
    sessionDescriptionArController.clear();
    sessionDescriptionEnController.clear();
  }

  void deleteDescriptionDialog(id) {
    Get.defaultDialog(
      titlePadding: EdgeInsets.symmetric(vertical: 10),
      title: "Delete content".tr,
      contentPadding: EdgeInsets.only(bottom: 15.h),
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          "Are you sure to delete?".tr,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
      onConfirm: () {
        deleteDescription(id);
      },
      textConfirm: "Yes".tr,
      textCancel: "No".tr,
      onCancel: () {},
    );
  }

  Future<void> deleteDescription(id) async {
    final result = await CustomRequest<String>(
      path: ApiConstance.deleteDescription(id),
      fromJson: (json) {
        return json['message'];
      },
    ).sendDeleteRequest();

    result.fold(
      (error) {
        AppSnackBars.error(message: error.errMsg);
      },
      (response) {
        Get.back();
        Get.back();
        AppSnackBars.success(message: "content deleted successfully");
        getProductDetails();
      },
    );
  }

  onTapEditDescription(ProductDescriptionContentModel model) {
    sessionDescriptionArController.text = model.contentAr!;
    sessionDescriptionEnController.text = model.contentEn!;
  }

  Future<void> editDescription(id) async {
    if (descriptionFormKeyEdit.currentState?.validate() ?? false) {
      descriptionFormKeyEdit.currentState!.save();
      final result = await CustomRequest<String>(
        path: ApiConstance.editDescription(id),
        data: {
          'content_ar': sessionDescriptionArController.text,
          'content_en': sessionDescriptionArController.text,
        },
        fromJson: (json) {
          return json['message'];
        },
      ).sendPatchRequest();
      result.fold(
        (error) {
          AppSnackBars.error(message: error.errMsg);
        },
        (response) {
          Get.back();
          Get.back();
          sessionDescriptionArController.clear();
          sessionDescriptionEnController.clear();
          AppSnackBars.success(message: "Description added successfully");
          getProductDetails();
        },
      );
    }
  }

  ///==========================================
  ///
  ///

  onTapEditSession(ProductDescriptionModel session) {
    sessionTitleArController.text = session.titleAr!;
    sessionTitleEnController.text = session.titleEn!;
  }

  onCancelAddSession() {
    Get.back();
    sessionTitleArController.clear();
    sessionTitleEnController.clear();
  }

  Future<void> addSession() async {
    if (sessionFormKeyAdd.currentState?.validate() ?? false) {
      sessionFormKeyAdd.currentState!.save();
      final result = await CustomRequest<String>(
        path: ApiConstance.addSession,
        data: {
          'title_ar': sessionTitleArController.text,
          'title_en': sessionTitleEnController.text,
          'product_id': productModel!.id,
        },
        fromJson: (json) {
          return json['message'];
        },
      ).sendPostRequest();

      result.fold(
        (error) {
          AppSnackBars.error(message: error.errMsg);
        },
        (response) {
          Get.back();

          AppSnackBars.success(message: "Session added successfully");
          getProductDetails();
          Get.put(ShopController()).getShopProducts(firstTime: true);
        },
      );
    }
  }

  Future<void> editSession(id) async {
    if (sessionFormKeyEdit.currentState?.validate() ?? false) {
      sessionFormKeyEdit.currentState!.save();
      final result = await CustomRequest<String>(
        path: ApiConstance.editSession(id),
        data: {
          'title_ar': sessionTitleArController.text,
          'title_en': sessionTitleEnController.text,
        },
        fromJson: (json) {
          return json['message'];
        },
      ).sendPatchRequest();

      result.fold(
        (error) {
          AppSnackBars.error(message: error.errMsg);
        },
        (response) {
          Get.back();
          Get.back();
          AppSnackBars.success(message: "Session title updated successfully");
          getProductDetails();
          Get.put(ShopController()).getShopProducts(firstTime: true);
        },
      );
    }
  }

  void deleteSessionDialog(id) {
    Get.defaultDialog(
      titlePadding: EdgeInsets.symmetric(vertical: 10),
      title: "Delete Session".tr,
      contentPadding: EdgeInsets.only(bottom: 15.h),
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          "Are you sure to delete?".tr,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16.sp),
        ),
      ),
      onConfirm: () {
        deleteSession(id);
      },
      textConfirm: "Yes".tr,
      textCancel: "No".tr,
      onCancel: () {},
    );
  }

  Future<void> deleteSession(id) async {
    final result = await CustomRequest<String>(
      path: ApiConstance.deleteSession(id),
      fromJson: (json) {
        return json['message'];
      },
    ).sendDeleteRequest();

    result.fold(
      (error) {
        AppSnackBars.error(message: error.errMsg);
      },
      (response) {
        Get.back();
        Get.back();
        AppSnackBars.success(message: "Session deleted successfully");
        getProductDetails();
      },
    );
  }

  @override
  void onClose() {
    titleArController.dispose();
    titleEnController.dispose();
    descriptionEnController.dispose();
    descriptionArController.dispose();
    priceController.dispose();
    discountController.dispose();
    super.onClose();
  }

  void deleteFile() {
    file = null;
    update();
  }
}
