import 'package:equatable/equatable.dart';
import '/core/constants/app_constants.dart';

class ProductModel extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;
  final String image;
  final String description;
  final String categoryId;
  final String color;
  final String price;
  final String stock;
  final String status;
  final String createdAt;
  final String updatedAt;

  const ProductModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.image,
    required this.description,
    required this.categoryId,
    required this.color,
    required this.price,
    required this.stock,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"] ?? 0,
        nameAr: json["name_ar"].toString(),
        nameEn: json["name_en"].toString(),
        image: kBaseImageUrl + json["image"].toString(),
        description: json["description"].toString(),
        categoryId: json["category_id"].toString(),
        price: json["price"].toString(),
        color: json["color"].toString(),
        stock: json["stock"].toString(),
        status: json["status"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  @override
  List<Object> get props => [
        id,
        nameAr,
        nameEn,
        image,
        description,
        categoryId,
        color,
        price,
        stock,
        status,
        createdAt,
        updatedAt,
      ];
}
