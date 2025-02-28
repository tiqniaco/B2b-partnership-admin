import '/core/constants/app_constants.dart';

class BannersModel {
  int? id;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;

  BannersModel(
      {this.id, this.image, this.status, this.createdAt, this.updatedAt});

  BannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = kBaseImageUrl + json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
