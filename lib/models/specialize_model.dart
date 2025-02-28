import '/core/constants/app_constants.dart';

class SpecializeModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? image;
  String? createdAt;
  String? updatedAt;

  SpecializeModel(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.image,
      this.createdAt,
      this.updatedAt});

  SpecializeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    image = kBaseImageUrl + json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
