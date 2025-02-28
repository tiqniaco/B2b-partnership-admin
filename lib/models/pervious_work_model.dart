import '/core/constants/app_constants.dart';

class ProviderPerviousWorkModel {
  int? id;
  String? providerId;
  String? titleAr;
  String? titleEn;
  String? description;
  String? image;
  String? createdAt;
  String? updatedAt;

  ProviderPerviousWorkModel(
      {this.id,
      this.providerId,
      this.titleAr,
      this.titleEn,
      this.description,
      this.image,
      this.createdAt,
      this.updatedAt});

  ProviderPerviousWorkModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerId = json['provider_id'];
    titleAr = json['title_ar'];
    titleEn = json['title_en'];
    description = json['description'];
    image = kBaseImageUrl + json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['provider_id'] = providerId;
    data['title_ar'] = titleAr;
    data['title_en'] = titleEn;
    data['description'] = description;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
