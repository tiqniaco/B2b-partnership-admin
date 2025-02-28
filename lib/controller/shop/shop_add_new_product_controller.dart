import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ShopAddNewProductController extends GetxController {
  String categoryId = '';
  final titleArController = TextEditingController();
  final titleEnController = TextEditingController();
  final descriptionEnController = TextEditingController();
  final descriptionArController = TextEditingController();
  final priceController = TextEditingController();
  final discountController = TextEditingController();
  File? image;
  File? file;

  @override
  void onInit() {
    categoryId = Get.arguments["categoryId"] ?? "";
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
}
