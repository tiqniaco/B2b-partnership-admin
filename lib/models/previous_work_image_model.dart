import '/core/constants/app_constants.dart';

class PreviousImagesModel {
  int? id;
  String? providerPreviousWorkId;
  String? image;
  String? createdAt;
  String? updatedAt;

  PreviousImagesModel(
      {this.id,
      this.providerPreviousWorkId,
      this.image,
      this.createdAt,
      this.updatedAt});

  PreviousImagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerPreviousWorkId = json['provider_previous_work_id'];
    image = kBaseImageUrl + json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['provider_previous_work_id'] = providerPreviousWorkId;
    data['image'] = image;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
