import 'package:b2b_partnership_admin/core/constants/app_constants.dart';

class BagContentModel {
  int? id;
  String? nameEn;
  String? nameAr;
  String? image;
  String? createdAt;
  String? updatedAt;

  BagContentModel(
      {this.id,
      this.nameEn,
      this.nameAr,
      this.image,
      this.createdAt,
      this.updatedAt});

  BagContentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    image = kBaseImageUrl + json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_en'] = nameEn;
    data['name_ar'] = nameAr;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
