import 'package:b2b_partnership_admin/app_routes.dart';
import 'package:b2b_partnership_admin/controller/shop/shop_controller.dart';
import 'package:b2b_partnership_admin/core/crud/custom_request.dart';
import 'package:b2b_partnership_admin/core/enums/status_request.dart';
import 'package:b2b_partnership_admin/core/network/api_constance.dart';
import 'package:b2b_partnership_admin/core/utils/app_snack_bars.dart';
import 'package:b2b_partnership_admin/models/product_description_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '/controller/shop/shop_cart_controller.dart';
import '/models/shop_product_model.dart';
import 'package:get/get.dart';

class ShopProductDetailsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.success;
  List<ProductDescriptionModel> descriptions = [];
  late ShopProductModel product;
  bool isLoading = false;

  @override
  void onInit() {
    product = Get.arguments['product'] as ShopProductModel;
    getProductDetails();
    super.onInit();
  }

  Future<void> getProductDetails() async {
    statusRequest = StatusRequest.loading;
    update();
    final result = await CustomRequest<Map<String, dynamic>>(
      path: ApiConstance.shopProductDetails(product.id.toString()),
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
        product = ShopProductModel.fromJson(data['data']);
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

  Future<void> addToCart() async {
    await Get.put(ShopCartController()).addToCart(productId: product.id);
  }

  Future<void> deleteProductDialog() async {
    await Get.defaultDialog(
      title: "Delete Product",
      titleStyle: TextStyle(fontSize: 15.sp),
      middleText: "Are you sure you want to\ndelete this product?",
      textConfirm: "Yes",
      textCancel: "No",
      onConfirm: _deleteProduct,
    );
  }

  Future<void> _deleteProduct() async {
    Get.back();
    isLoading = true;
    update();
    final result = await CustomRequest(
        path: ApiConstance.deleteProduct(product.id.toString()),
        fromJson: (json) {
          return json['message'];
        }).sendDeleteRequest();

    result.fold(
      (error) {
        isLoading = false;
        update();
        AppSnackBars.error(message: error.errMsg);
      },
      (data) {
        Get.back();
        isLoading = false;
        update();
        Get.put(ShopController()).getShopProducts(firstTime: true);
        AppSnackBars.success(message: "Product deleted successfully");
      },
    );
  }

  void editProduct() {
    Get.toNamed(
      AppRoutes.shopEditProduct,
      arguments: {'product': product, 'sessions': descriptions},
    );
  }

  callBackFun(int index, bool isExpanded) {
    descriptions[index].isExpanded = isExpanded == false ? 0 : 1;

    update();
  }
}
