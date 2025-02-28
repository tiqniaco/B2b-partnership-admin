class ProviderTypeModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? createdAt;
  String? updatedAt;

  ProviderTypeModel(
      {this.id, this.nameAr, this.nameEn, this.createdAt, this.updatedAt});

  ProviderTypeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
