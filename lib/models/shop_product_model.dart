import '/core/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

class ShopProductModel extends Equatable {
  final int id;
  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final String descriptionEn;
  final String file;
  final String price;
  final String discount;
  final String image;
  final String categoryId;
  final String createdAt;
  final String updatedAt;

  const ShopProductModel({
    required this.id,
    required this.titleAr,
    required this.titleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.file,
    required this.price,
    required this.discount,
    required this.image,
    required this.categoryId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ShopProductModel.fromJson(Map<String, dynamic> json) =>
      ShopProductModel(
        id: int.parse(json["id"].toString()),
        titleAr: json["title_ar"].toString(),
        titleEn: json["title_en"].toString(),
        descriptionAr: json["description_ar"].toString(),
        descriptionEn: json["description_en"].toString(),
        price: json["price"].toString(),
        discount: json["discount"].toString(),
        file: kBaseImageUrl + json["file"].toString(),
        image: kBaseImageUrl + json["image"].toString(),
        categoryId: json["category_id"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  @override
  List<Object?> get props => [
        id,
        titleAr,
        titleEn,
        descriptionAr,
        descriptionEn,
        file,
        price,
        discount,
        image,
        categoryId,
        createdAt,
        updatedAt,
      ];
}
