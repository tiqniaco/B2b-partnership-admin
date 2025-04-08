import 'package:equatable/equatable.dart';

import 'product_description_content_model.dart';

// ignore: must_be_immutable
class ProductDescriptionModel extends Equatable {
  final int? id;
  final String? titleEn;
  final String? titleAr;
  final String? productId;
  final String? createdAt;
  final String? updatedAt;
  final List<ProductDescriptionContentModel>? contents;
  int? isExpanded;

   ProductDescriptionModel({
     this.id,
     this.titleEn,
     this.titleAr,
     this.productId,
     this.createdAt,
     this.updatedAt,
     this.contents,
    this.isExpanded = 0,
  });

  factory ProductDescriptionModel.fromJson(Map<String, dynamic> json) =>
      ProductDescriptionModel(
        id: json["id"] ?? 0,
        titleEn: json["title_en"].toString(),
        titleAr: json["title_ar"].toString(),
        productId: json["product_id"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
        contents: json["contents"] == null
            ? []
            : List<ProductDescriptionContentModel>.from(
                json["contents"].map(
                  (x) => ProductDescriptionContentModel.fromJson(x),
                ),
              ),
      );
  @override
  List<Object?> get props => [
        id,
        titleEn,
        titleAr,
        productId,
        createdAt,
        updatedAt,
        contents,
      ];
}
