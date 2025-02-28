import '/app_routes.dart';
import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/core/utils/app_snack_bars.dart';
import '/models/shop_cart_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class ShopCartController extends GetxController {
  List<ShopCartModel> carts = [];
  StatusRequest statusRequest = StatusRequest.loading;
  String error = '';

  @override
  void onInit() {
    getCart();
    super.onInit();
  }

  Future<void> getCart() async {
    statusRequest = StatusRequest.loading;
    update();
    final result = await CustomRequest<List<ShopCartModel>>(
      path: ApiConstance.shopCart,
      fromJson: (json) {
        return List<ShopCartModel>.from(
          json['data'].map(
            (x) => ShopCartModel.fromJson(x),
          ),
        );
      },
    ).sendGetRequest();
    result.fold(
      (error) {
        statusRequest = StatusRequest.error;
        update();
        Logger().e(error.errMsg);
      },
      (data) {
        carts = data;
        if (carts.isEmpty) {
          statusRequest = StatusRequest.noData;
        } else {
          statusRequest = StatusRequest.success;
        }
        update();
      },
    );
  }

  Future<void> removeFromCart({
    required int id,
  }) async {
    final result = await CustomRequest<String>(
      path: ApiConstance.deleteCartItem(id),
      fromJson: (json) {
        return json['message'];
      },
    ).sendDeleteRequest();
    result.fold(
      (error) {
        statusRequest = StatusRequest.error;
        update();
        Logger().e(error.errMsg);
        AppSnackBars.error(message: error.errMsg);
      },
      (data) {
        AppSnackBars.success(message: data);
        getCart();
        update();
      },
    );
  }

  Future<void> clearCart() async {
    if (carts.isEmpty) return;
    final result = await CustomRequest<String>(
      path: ApiConstance.clearCart,
      fromJson: (json) {
        return json['message'];
      },
    ).sendPostRequest();
    result.fold(
      (error) {
        statusRequest = StatusRequest.error;
        update();
        Logger().e(error.errMsg);
        AppSnackBars.error(message: error.errMsg);
      },
      (data) {
        AppSnackBars.success(message: data);
        getCart();
        update();
      },
    );
  }

  Future<void> addToCart({
    required int productId,
  }) async {
    final result = await CustomRequest<String>(
      path: ApiConstance.addToCart,
      data: {
        'product_id': productId,
      },
      fromJson: (json) {
        return json['message'];
      },
    ).sendPostRequest();

    result.fold(
      (error) {
        statusRequest = StatusRequest.error;
        update();
        Logger().e(error.errMsg);
        AppSnackBars.warning(message: error.errMsg);
      },
      (data) {
        AppSnackBars.success(message: data);
        getCart();
        update();
      },
    );
  }

  double calculateTotalPrice() {
    double total = 0;
    for (var element in carts) {
      total += double.parse(element.product.price) -
          (double.parse(element.product.price) *
              double.parse(element.product.discount) /
              100);
    }
    return total;
  }

  void onItemTab({
    required int index,
  }) {
    Get.toNamed(
      AppRoutes.shopProductDetails,
      arguments: {
        "product": carts[index].product,
      },
    );
  }

  Future<void> checkout() async {
    if (carts.isEmpty) return;
    final result = await CustomRequest<String>(
      path: ApiConstance.checkout,
      fromJson: (json) {
        return json['message'];
      },
    ).sendPostRequest();

    result.fold(
      (error) {
        Logger().e(error.errMsg);
        AppSnackBars.warning(message: error.errMsg);
      },
      (data) {
        AppSnackBars.success(message: data);
        getCart();
        update();
      },
    );
  }
}
