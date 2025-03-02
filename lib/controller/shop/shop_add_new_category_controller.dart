import 'dart:io';

import 'package:b2b_partnership_admin/controller/shop/shop_controller.dart';
import 'package:b2b_partnership_admin/core/crud/custom_request.dart';
import 'package:b2b_partnership_admin/core/network/api_constance.dart';
import 'package:b2b_partnership_admin/core/utils/app_snack_bars.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ShopAddNewCategoryController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameArController = TextEditingController();
  final nameEnController = TextEditingController();

  File? image;

  void selectImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
    update();
  }

  Future<void> addNewCategory() async {
    if (image == null) {
      formKey.currentState?.validate();

      AppSnackBars.warning(message: "Please select an image and a file");
      return;
    }
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState!.save();
      final result = await CustomRequest<String>(
        path: ApiConstance.addShopCategory,
        data: {
          'name_ar': nameArController.text,
          'name_en': nameEnController.text,
        },
        files: {
          if (image != null) "image": image?.path ?? '',
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
          AppSnackBars.success(message: "Category added successfully");
          Get.put(ShopController()).getShopCategories();
        },
      );
    }
  }

  @override
  void onClose() {
    nameArController.dispose();
    nameEnController.dispose();
    super.onClose();
  }
}
