import 'package:b2b_partnership_admin/core/constants/app_constants.dart';

class ClientModel {
  String? userId;
  String? name;
  String? email;
  String? countryCode;
  String? phone;
  String? image;
  String? clientId;
  String? countryId;
  String? countryNameAr;
  String? countryNameEn;
  String? governmentId;
  String? governmentNameAr;
  String? governmentNameEn;
  String? createdAt;
  String? updatedAt;
  String? providerId;

  ClientModel(
      {this.userId,
      this.name,
      this.email,
      this.countryCode,
      this.phone,
      this.image,
      this.clientId,
      this.countryId,
      this.countryNameAr,
      this.countryNameEn,
      this.governmentId,
      this.governmentNameAr,
      this.governmentNameEn,
      this.createdAt,
      this.updatedAt,
      this.providerId});

  ClientModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    countryCode = json['country_code'];
    phone = json['phone'];
    image = kBaseImageUrl + (json['image'] ?? "");
    clientId = json['client_id'];
    countryId = json['country_id'];
    countryNameAr = json['country_name_ar'];
    countryNameEn = json['country_name_en'];
    governmentId = json['government_id'];
    governmentNameAr = json['government_name_ar'];
    governmentNameEn = json['government_name_en'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    providerId = json['provider_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['country_code'] = countryCode;
    data['phone'] = phone;
    data['image'] = image;
    data['client_id'] = clientId;
    data['country_id'] = countryId;
    data['country_name_ar'] = countryNameAr;
    data['country_name_en'] = countryNameEn;
    data['government_id'] = governmentId;
    data['government_name_ar'] = governmentNameAr;
    data['government_name_en'] = governmentNameEn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['provider_id'] = providerId;
    return data;
  }
}
