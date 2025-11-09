import 'dart:io';

import 'package:b2b_partnership_admin/controller/shop/shop_controller.dart';
import 'package:b2b_partnership_admin/core/crud/custom_request.dart';
import 'package:b2b_partnership_admin/core/network/api_constance.dart';
import 'package:b2b_partnership_admin/core/utils/app_snack_bars.dart';
import 'package:b2b_partnership_admin/models/shop_category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ShopEditCategoryController extends GetxController {
  final formKey = GlobalKey<FormState>();
  ShopCategoryModel? model;
  final nameArController = TextEditingController();
  final nameEnController = TextEditingController();

  File? image;

  @override
  void onInit() {
    model = Get.arguments['model'];
    nameArController.text = model?.nameAr ?? '';
    nameEnController.text = model?.nameEn ?? '';
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

  Future<void> editCategory() async {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState!.save();
      final result = await CustomRequest<String>(
        path: ApiConstance.updateShopCategory(model?.id.toString() ?? ''),
        data: {
          'name_ar': nameEnController.text,
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
