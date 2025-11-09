class CountryModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? flag;
  String? code;
  String? phoneLength;
  String? createdAt;
  String? updatedAt;

  CountryModel(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.flag,
      this.code,
      this.phoneLength,
      this.createdAt,
      this.updatedAt});

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    flag = json['flag'];
    code = json['code'];
    phoneLength = json['phone_length'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['flag'] = flag;
    data['code'] = code;
    data['phone_length'] = phoneLength;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
