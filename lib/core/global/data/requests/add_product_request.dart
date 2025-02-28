import 'package:equatable/equatable.dart';

class ProductRequest extends Equatable {
  final String? nameAr;
  final String? nameEn;
  final String? description;
  final int? categoryId;
  final double? price;
  final int? stock;
  final String? color;
  final String? image;

  const ProductRequest({
    this.nameAr,
    this.nameEn,
    this.description,
    this.categoryId,
    this.price,
    this.stock,
    this.color,
    this.image,
  });

  Map<String, dynamic> toJson() => {
        if (nameAr != null) "name_ar": nameAr,
        if (nameEn != null) "name_en": nameEn,
        if (description != null) "description": description,
        if (categoryId != null) "category_id": categoryId,
        if (price != null) "price": price,
        if (stock != null) "stock": stock,
        if (color != null) "color": color,
      };

  @override
  List<Object?> get props => [
        nameAr,
        nameEn,
        description,
        categoryId,
        price,
        stock,
        color,
        image,
      ];
}
