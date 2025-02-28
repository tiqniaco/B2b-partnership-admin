class SubSpecializeModel {
  int? id;
  String? nameAr;
  String? nameEn;
  String? parentId;
  String? createdAt;
  String? updatedAt;

  SubSpecializeModel(
      {this.id,
      this.nameAr,
      this.nameEn,
      this.parentId,
      this.createdAt,
      this.updatedAt});

  SubSpecializeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['parent_id'] = parentId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
