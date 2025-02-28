import '/core/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

class ShopCategoryModel extends Equatable {
  final int id;
  final String nameAr;
  final String nameEn;
  final String image;
  final String createdAt;
  final String updatedAt;

  const ShopCategoryModel({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ShopCategoryModel.fromJson(Map<String, dynamic> json) =>
      ShopCategoryModel(
        id: int.parse(json["id"].toString()),
        nameAr: json["name_ar"].toString(),
        nameEn: json["name_en"].toString(),
        image: kBaseImageUrl + json["image"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  @override
  List<Object?> get props => [
        id,
        nameAr,
        nameEn,
        image,
        createdAt,
        updatedAt,
      ];
}
