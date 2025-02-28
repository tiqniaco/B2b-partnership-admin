import '/controller/shop/shop_cart_controller.dart';
import '/models/shop_product_model.dart';
import 'package:get/get.dart';

class ShopProductDetailsController extends GetxController {
  late ShopProductModel product;

  @override
  void onInit() {
    product = Get.arguments['product'] as ShopProductModel;
    super.onInit();
  }

  Future<void> addToCart() async {
    await Get.put(ShopCartController()).addToCart(productId: product.id);
  }
}
