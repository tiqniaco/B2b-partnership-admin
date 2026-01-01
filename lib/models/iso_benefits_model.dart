class IsoBenefitsModel {
  int? id;
  int? iosId;
  String? title;
  String? createdAt;
  String? updatedAt;

  IsoBenefitsModel(
      {this.id, this.iosId, this.title, this.createdAt, this.updatedAt});

  IsoBenefitsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    iosId = json['ios_id'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['ios_id'] = iosId;
    data['title'] = title;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
