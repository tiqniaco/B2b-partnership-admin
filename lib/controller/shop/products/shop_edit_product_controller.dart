import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:b2b_partnership_admin/controller/shop/shop_controller.dart';
import 'package:b2b_partnership_admin/core/crud/custom_request.dart';
import 'package:b2b_partnership_admin/core/enums/status_request.dart';
import 'package:b2b_partnership_admin/core/network/api_constance.dart';
import 'package:b2b_partnership_admin/core/utils/app_snack_bars.dart';
import 'package:b2b_partnership_admin/models/bag_content_model.dart';
import 'package:b2b_partnership_admin/models/product_description_content_model.dart';
import 'package:b2b_partnership_admin/models/product_description_model.dart';
import 'package:b2b_partnership_admin/models/shop_product_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class ShopEditProductController extends GetxController {
  StatusRequest statusRequest = StatusRequest.success;
  StatusRequest addContentRequest = StatusRequest.success;
  ShopProductModel? productModel;
  List<ProductDescriptionModel> descriptions = [];
  List<BagContentModel> contents = [];
  List<BagContentModel> allContents = [];
  final formKey = GlobalKey<FormState>();
  final sessionFormKeyEdit = GlobalKey<FormState>();
  final sessionFormKeyAdd = GlobalKey<FormState>();
  final descriptionFormKeyEdit = GlobalKey<FormState>();
  final descriptionFormKeyAdd = GlobalKey<FormState>();
  final stepFormKey = GlobalKey<FormState>();
  late final String bagFile;
  late final String mainBagFileString;
  late final String bagImage;
  final titleArController = TextEditingController();
  QuillController descriptionController = QuillController.basic();
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
  File? mainBagFile;

  @override
  void onInit() {
    productModel = Get.arguments['product'];

    final document = buildQuillDocument(productModel?.descriptionEn);

    descriptionController = QuillController(
      document: document,
      selection: const TextSelection.collapsed(offset: 0),
    );

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
    getBagContents();
    super.onInit();
  }

  Document buildQuillDocument(String? description) {
    if (description == null || description.isEmpty) {
      return Document();
    }

    try {
      // نجرب نفكه كـ Quill JSON
      final decoded = jsonDecode(description);

      if (decoded is List) {
        return Document.fromJson(decoded);
      }
    } catch (e) {
      // مش JSON → نكمل عادي
    }

    // هنا معناها نص عادي
    return Document()..insert(0, description);
  }

  Future<void> editProduct() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState!.save();
      if (descriptionController.document.isEmpty()) {
        Get.defaultDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.error, color: Colors.red, size: 48.r),
                const SizedBox(height: 8),
                Text(
                  'The description cannot be empty'.tr,
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(fontSize: 18.r, fontWeight: FontWeight.normal),
                ),
                const SizedBox(height: 4),
              ],
            ),
          ),
        );
        return;
      }

      final delta = descriptionController.document.toDelta();
      final jsonString = jsonEncode(delta.toJson());
      final result = await CustomRequest<String>(
        path: ApiConstance.updateProduct(productModel?.id.toString() ?? ''),
        data: {
          'title_ar': titleEnController.text,
          'title_en': titleEnController.text,
          'description_ar': jsonString,
          'description_en': jsonString,
          'price': double.parse(priceController.text),
          'discount': double.parse(discountController.text),
          "terms_and_conditions_en": termsAndConditionsEnController.text,
          "terms_and_conditions_ar": termsAndConditionsEnController.text
        },
        files: {
          if (image != null) "image": image!.path,
          if (file != null) "file": file!.path,
          if (mainBagFile != null) "bag": mainBagFile!.path
        },
        fromJson: (json) {
          return json['message'];
        },
      ).sendPostRequest();

      result.fold(
        (error) {
          AppSnackBars.error(message: error.errMsg);
          log(error.errMsg);
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

  Future<void> selectBagFile() async {
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
      mainBagFile = File(filePicker.files.single.path ?? '');
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
        descriptions = List<ProductDescriptionModel>.from(
          data['descriptions'].map(
            (e) => ProductDescriptionModel.fromJson(e),
          ),
        );

        contents = List<BagContentModel>.from(
          data['bagContents'].map(
            (e) => BagContentModel.fromJson(e),
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

  ///====================================================
  Future<void> deleteBagContent(id) async {
    final result = await CustomRequest<String>(
            path: ApiConstance.deleteContents(id),
            fromJson: (json) {
              return json['message'];
            },
            data: {"product_id": productModel!.id, "bag_content_id": id})
        .sendDeleteRequest();
    result.fold(
      (error) {
        AppSnackBars.error(message: error.errMsg);
      },
      (response) {
        AppSnackBars.success(message: "content deleted successfully");
        getProductDetails();
      },
    );
  }

  Future<void> getBagContents() async {
    addContentRequest = StatusRequest.loading;
    update();
    final result = await CustomRequest<List<BagContentModel>>(
        path: ApiConstance.getAllContents,
        fromJson: (json) {
          final List<BagContentModel> categories = List<BagContentModel>.from(
            json['data'].map((x) => BagContentModel.fromJson(x)),
          );

          return categories;
        }).sendGetRequest();

    result.fold(
      (error) {
        Logger().e(error.errMsg);
        addContentRequest = StatusRequest.error;
        update();
      },
      (data) {
        allContents = data;

        if (data.isEmpty) {
          addContentRequest = StatusRequest.noData;
        } else {
          addContentRequest = StatusRequest.success;
        }
        update();
      },
    );
  }

  Future<void> addContent(BagContentModel allContent) async {
    final result = await CustomRequest<String>(
      path: ApiConstance.addBagContents,
      data: {
        'bag_content_id': allContent.id,
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
        AppSnackBars.success(message: "Content added successfully");
        getProductDetails();
      },
    );
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
          'content_ar': sessionDescriptionEnController.text,
          'content_en': sessionDescriptionEnController.text,
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
    sessionDescriptionArController.text = model.contentEn!;
    sessionDescriptionEnController.text = model.contentEn!;
  }

  Future<void> editDescription(id) async {
    if (descriptionFormKeyEdit.currentState?.validate() ?? false) {
      descriptionFormKeyEdit.currentState!.save();
      final result = await CustomRequest<String>(
        path: ApiConstance.editDescription(id),
        data: {
          'content_ar': sessionDescriptionEnController.text,
          'content_en': sessionDescriptionEnController.text,
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
          'title_ar': sessionTitleEnController.text,
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
          'title_ar': sessionTitleEnController.text,
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
