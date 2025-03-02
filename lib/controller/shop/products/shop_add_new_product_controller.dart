import 'dart:io';

import 'package:b2b_partnership_admin/controller/shop/shop_controller.dart';
import 'package:b2b_partnership_admin/core/crud/custom_request.dart';
import 'package:b2b_partnership_admin/core/network/api_constance.dart';
import 'package:b2b_partnership_admin/core/utils/app_snack_bars.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
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
    if (image == null || file == null) {
      formKey.currentState?.validate();

      AppSnackBars.warning(message: "Please select an image and a file");
      return;
    }
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState!.save();
      final result = await CustomRequest<String>(
        path: ApiConstance.addProduct,
        data: {
          'category_id': categoryId,
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
