class IsoModel {
  int? id;
  String? title;
  String? description;
  int? price;
  String? createdAt;
  String? updatedAt;

  IsoModel(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.createdAt,
      this.updatedAt});

  IsoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['price'] = price;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
