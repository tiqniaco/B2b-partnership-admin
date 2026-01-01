class IsoIncludedModel {
  int? id;
  int? iosId;
  String? title;
  String? description;
  String? createdAt;
  String? updatedAt;

  IsoIncludedModel(
      {this.id,
      this.iosId,
      this.title,
      this.description,
      this.createdAt,
      this.updatedAt});

  IsoIncludedModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iosId = json['ios_id'];
    title = json['title'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ios_id'] = iosId;
    data['title'] = title;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
