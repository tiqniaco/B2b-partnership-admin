import 'package:equatable/equatable.dart';

import 'shop_product_model.dart';

class ShopCartModel extends Equatable {
  final int id;
  final String userId;
  final String productId;
  final String orderId;
  final String createdAt;
  final String updatedAt;
  final ShopProductModel product;

  const ShopCartModel({
    required this.id,
    required this.userId,
    required this.productId,
    required this.orderId,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });

  factory ShopCartModel.fromJson(Map<String, dynamic> json) => ShopCartModel(
        id: json["id"],
        userId: json["user_id"].toString(),
        productId: json["product_id"].toString(),
        orderId: json["order_id"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        product: ShopProductModel.fromJson(json["product"]),
      );

  @override
  List<Object?> get props => [
        id,
        userId,
        productId,
        orderId,
        createdAt,
        updatedAt,
        product,
      ];
}
