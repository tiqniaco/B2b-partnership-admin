import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:b2b_partnership_admin/controller/shop/shop_controller.dart';
import 'package:b2b_partnership_admin/core/crud/custom_request.dart';
import 'package:b2b_partnership_admin/core/network/api_constance.dart';
import 'package:b2b_partnership_admin/core/utils/app_snack_bars.dart';
import 'package:b2b_partnership_admin/models/bag_content_model.dart';
import 'package:b2b_partnership_admin/models/product_description_content_model.dart';
import 'package:b2b_partnership_admin/models/product_description_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class ShopAddNewProductController extends GetxController {
  String categoryId = '';
  final formKey = GlobalKey<FormState>();
  final titleArController = TextEditingController();
  final titleEnController = TextEditingController();
  // final descriptionEnController = TextEditingController();
  // final descriptionArController = TextEditingController();
  final priceController = TextEditingController();
  final discountController = TextEditingController();
  final termsAndConditionsEnController = TextEditingController();
  final termsAndConditionsArController = TextEditingController();
  late final QuillController descriptionController;
  File? image;
  File? file;
  File? bagFile;
  List<ProductDescriptionModel> descriptions = [];
  List<BagContentModel> bagContent = [];
  List<BagContentModel> allContents = [];

  final sessionDescriptionArController = TextEditingController();
  final sessionDescriptionEnController = TextEditingController();
  final sessionTitleArController = TextEditingController();
  final sessionTitleEnController = TextEditingController();

  @override
  void onInit() {
    descriptionController = QuillController.basic();
    categoryId = Get.arguments["categoryId"] ?? "";
    // descriptionController.addListener(() {
    //   update();
    // });
    getBagContents();
    super.onInit();
  }

  Future<void> getBagContents() async {
    // addContentRequest = StatusRequest.loading;
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
        // addContentRequest = StatusRequest.error;
        update();
      },
      (data) {
        allContents = data;

        // if (data.isEmpty) {

        // } else {
        //   Get.back();

        // }
        update();
      },
    );
  }

  void addBagContent(int index) {
    bagContent.add(allContents[index]);
    update();
  }

  void deleteBagContent(BagContentModel content) {
    bagContent.removeWhere((element) => element == content);
    update();
  }

  void addSession() {
    descriptions.add(ProductDescriptionModel(
      titleEn: sessionTitleEnController.text,
      titleAr: sessionTitleEnController.text,
      contents: [],
    ));
    Get.back();
    sessionTitleArController.clear();
    sessionTitleEnController.clear();
    update();
  }

  void addDescription(index) {
    descriptions[index].contents!.add(ProductDescriptionContentModel(
          contentAr: sessionDescriptionEnController.text,
          contentEn: sessionDescriptionEnController.text,
        ));
    Get.back();
    Get.back();
    sessionDescriptionArController.clear();
    sessionDescriptionEnController.clear();
    update();
  }

  void deleteDescriptionDialog(session, content) {
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
        Get.back();
        Get.back();
        int index = descriptions.indexWhere((element) => element == session);

        descriptions[index]
            .contents!
            .removeWhere((element) => element == content);
        update();
      },
      textConfirm: "Yes".tr,
      textCancel: "No".tr,
      onCancel: () {},
    );
  }

  void deleteSessionDialog(session) {
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
        Get.back();
        Get.back();
        descriptions.removeWhere((element) => element == session);
        update();
      },
      textConfirm: "Yes".tr,
      textCancel: "No".tr,
      onCancel: () {},
    );
  }

  void onCancelAddSession() {
    Get.back();
    sessionTitleArController.clear();
    sessionTitleEnController.clear();
  }

  void onCancelAddDescription() {
    Get.back();
    sessionDescriptionArController.clear();
    sessionDescriptionEnController.clear();
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

  void callBackFun(int index, bool isExpanded) {
    descriptions[index].isExpanded = isExpanded == false ? 0 : 1;
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
      bagFile = File(filePicker.files.single.path ?? '');
    }
    update();
  }

  Future<void> addProduct() async {
    print('file path:                  ${bagFile?.path}');
    if (image == null) {
      formKey.currentState?.validate();
      AppSnackBars.warning(message: "Please select an image and a file");
      return;
    }

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
                style: TextStyle(fontSize: 18.r, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      );
      return;
    }

    if (file == null) {
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
            children: [
              Icon(Icons.error, color: Colors.red, size: 48.r),
              const SizedBox(height: 8),
              Text(
                'The Bag file is required'.tr,
                style: TextStyle(fontSize: 18.r, fontWeight: FontWeight.normal),
              ),
              const SizedBox(height: 4),
            ],
          ),
        ),
      );
      return;
    }
    if (bagFile == null) {
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
            children: [
              Icon(Icons.error, color: Colors.red, size: 48.r),
              const SizedBox(height: 8),
              Text(
                'The the bag demo file is required'.tr,
                style: TextStyle(fontSize: 18.r, fontWeight: FontWeight.normal),
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

    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState!.save();
      Map<String, dynamic> data = {
        'category_id': categoryId,
        'title_ar': titleEnController.text,
        'title_en': titleEnController.text,
        'description_ar': jsonString,
        'description_en': jsonString,
        'price': double.parse(priceController.text),
        'discount': double.parse(discountController.text),
        "terms_and_conditions_en": termsAndConditionsEnController.text,
        "terms_and_conditions_ar": termsAndConditionsEnController.text
      };

      for (int i = 0; i < descriptions.length; i++) {
        data['description_titles[$i][title_ar]'] = descriptions[i].titleEn;
        data['description_titles[$i][title_en]'] = descriptions[i].titleEn;

        for (int j = 0; j < descriptions[i].contents!.length; j++) {
          data['description_titles[$i][contents][$j][content_ar]'] =
              descriptions[i].contents![j].contentEn;
          data['description_titles[$i][contents][$j][content_en]'] =
              descriptions[i].contents![j].contentEn;
        }
      }

      for (int j = 0; j < bagContent.length; j++) {
        data['bag_contents_ids[$j]'] = bagContent[j].id;
      }
      log(data.toString());

      final result = await CustomRequest<String>(
        path: ApiConstance.addProduct,
        data: data,
        files: {
          if (image != null) "image": image?.path ?? '',
          if (file != null) "file": file?.path ?? '',
          if (bagFile != null) "demo_file": bagFile?.path ?? '',
        },
        fromJson: (json) => json['message'],
      ).sendPostRequest();

      result.fold(
        (error) {
          AppSnackBars.error(message: error.errMsg);
        },
        (response) {
          Get.back();
          AppSnackBars.success(message: "Product added successfully");
          Get.put(ShopController()).getShopProducts(firstTime: true);
        },
      );
    }
  }

  @override
  void onClose() {
    titleArController.dispose();
    titleEnController.dispose();
    //descriptionController.dispose();

    priceController.dispose();
    discountController.dispose();
    super.onClose();
  }

  void deleteFile() {
    file = null;
    update();
  }
}
