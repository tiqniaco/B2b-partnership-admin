import '/models/order_model.dart';
import 'package:equatable/equatable.dart';

import 'shop_product_model.dart';

class OrderDetailsModel extends Equatable {
  final String status;
  final String message;
  final OrderModel data;
  final List<ShopProductModel> items;

  const OrderDetailsModel({
    required this.status,
    required this.message,
    required this.data,
    required this.items,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
        status: json["status"].toString(),
        message: json["message"].toString(),
        data: OrderModel.fromJson(json["data"]),
        items: json["items"] == null
            ? []
            : List<ShopProductModel>.from(
                json["items"].map(
                  (x) => ShopProductModel.fromJson(x),
                ),
              ),
      );

  @override
  List<Object?> get props => [status, message, data, items];
}
