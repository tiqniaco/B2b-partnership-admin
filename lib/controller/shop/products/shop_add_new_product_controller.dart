import 'dart:io';

import 'package:b2b_partnership_admin/controller/shop/shop_controller.dart';
import 'package:b2b_partnership_admin/core/crud/custom_request.dart';
import 'package:b2b_partnership_admin/core/network/api_constance.dart';
import 'package:b2b_partnership_admin/core/utils/app_snack_bars.dart';
import 'package:b2b_partnership_admin/models/product_description_content_model.dart';
import 'package:b2b_partnership_admin/models/product_description_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ShopAddNewProductController extends GetxController {
  String categoryId = '';
  final formKey = GlobalKey<FormState>();
  final titleArController = TextEditingController();
  final titleEnController = TextEditingController();
  final descriptionEnController = TextEditingController();
  final descriptionArController = TextEditingController();
  final priceController = TextEditingController();
  final discountController = TextEditingController();
  final termsAndConditionsEnController = TextEditingController();
  final termsAndConditionsArController = TextEditingController();
  File? image;
  File? file;
  List<ProductDescriptionModel> descriptions = [];
  final sessionDescriptionArController = TextEditingController();
  final sessionDescriptionEnController = TextEditingController();
  final sessionTitleArController = TextEditingController();
  final sessionTitleEnController = TextEditingController();

  @override
  void onInit() {
    categoryId = Get.arguments["categoryId"] ?? "";
    super.onInit();
  }

  addSession() {
    descriptions.add(ProductDescriptionModel(
      //  id: stepId,
      titleEn: sessionTitleArController.text,
      titleAr: sessionTitleEnController.text,
      contents: [],
    ));
    Get.back();
    sessionTitleArController.clear();
    sessionTitleEnController.clear();
    update();
  }

  addDescription(index) {
    descriptions[index].contents!.add(ProductDescriptionContentModel(
          contentAr: sessionDescriptionArController.text,
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

  onCancelAddSession() {
    Get.back();
    sessionTitleArController.clear();
    sessionTitleEnController.clear();
  }

  onCancelAddDescription() {
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

  callBackFun(int index, bool isExpanded) {
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

  Future<void> addProduct() async {
    if (image == null) {
      formKey.currentState?.validate();
      AppSnackBars.warning(message: "Please select an image and a file");
      return;
    }

    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState!.save();

      // Step 1: build the base data map
      Map<String, dynamic> data = {
        'category_id': categoryId,
        'title_ar': titleArController.text,
        'title_en': titleEnController.text,
        'description_ar': descriptionArController.text,
        'description_en': descriptionEnController.text,
        'price': double.parse(priceController.text),
        'discount': double.parse(discountController.text),
      };

      // Step 2: add description list to the map
      for (int i = 0; i < descriptions.length; i++) {
        data['description_titles[$i][title_ar]'] = descriptions[i].titleAr;
        data['description_titles[$i][title_en]'] = descriptions[i].titleEn;

        for (int j = 0; j < descriptions[i].contents!.length; j++) {
          data['description_titles[$i][contents][$j][content_ar]'] =
              descriptions[i].contents![j].contentAr;
          data['description_titles[$i][contents][$j][content_en]'] =
              descriptions[i].contents![j].contentEn;
        }
      }

      final result = await CustomRequest<String>(
        path: ApiConstance.addProduct,
        data: data,
        files: {
          if (image != null) "image": image?.path ?? '',
          if (file != null) "file": file?.path ?? '',
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

  // Future<void> addProduct() async {
  //   if (image == null || file == null) {
  //     formKey.currentState?.validate();
  //     AppSnackBars.warning(message: "Please select an image and a file");
  //     return;
  //   }
  //   if (formKey.currentState?.validate() ?? false) {
  //     formKey.currentState!.save();
  //     final result = await CustomRequest<String>(
  //       path: ApiConstance.addProduct,
  //       data: {
  //         'category_id': categoryId,
  //         'title_ar': titleArController.text,
  //         'title_en': titleEnController.text,
  //         'description_ar': descriptionArController.text,
  //         'description_en': descriptionEnController.text,
  //         'price': double.parse(priceController.text),
  //         'discount': double.parse(discountController.text),
  //         for (int i = 0; i < descriptions.length; i++)
  //           {
  //             'description_titles[$i][title_ar]': descriptions[i].titleAr,
  //             'description_titles[$i][title_en]': descriptions[i].titleAr,
  //             for (int j = 0; j < descriptions[i].contents!.length; j++)
  //               'description_titles[$i][contents][$j][content_en]':
  //                   descriptions[i].contents![j].contentEn,
  //             'description_titles[$i][contents][$j][content_ar]':
  //                 descriptions[i].contents![j].contentAr,
  //           }
  //       },
  //       files: {
  //         if (image != null) "image": image?.path ?? '',
  //         if (file != null) "file": file?.path ?? '',
  //       },
  //       fromJson: (json) {
  //         return json['message'];
  //       },
  //     ).sendPostRequest();
  //     result.fold(
  //       (error) {
  //         AppSnackBars.error(message: error.errMsg);
  //       },
  //       (response) {
  //         Get.back();
  //         AppSnackBars.success(message: "Product added successfully");
  //         Get.put(ShopController()).getShopProducts(firstTime: true);
  //       },
  //     );
  //   }
  // }

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
