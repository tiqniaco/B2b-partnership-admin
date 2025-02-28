import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final int id;
  final String userId;
  final String status;
  final String totalPrice;
  final String expirationDate;
  final String createdAt;
  final String updatedAt;

  const OrderModel({
    required this.id,
    required this.userId,
    required this.status,
    required this.totalPrice,
    required this.expirationDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        userId: json["user_id"].toString(),
        status: json["status"].toString(),
        totalPrice: json["total_price"],
        expirationDate: json["expiration_date"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  @override
  List<Object?> get props => [
        id,
        userId,
        status,
        totalPrice,
        expirationDate,
        createdAt,
        updatedAt,
      ];
}
