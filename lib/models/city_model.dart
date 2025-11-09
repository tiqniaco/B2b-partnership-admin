class CityModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? countryId;
  String? createdAt;
  String? updatedAt;

  CityModel(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.countryId,
      this.createdAt,
      this.updatedAt});

  CityModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    countryId = json['country_id'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['country_id'] = countryId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
