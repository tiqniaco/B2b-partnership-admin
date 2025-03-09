import '/core/constants/app_constants.dart';

class ServiceRequestModel {
  String? id;
  String? titleAr;
  String? titleEn;
  String? address;
  String? description;
  String? image;
  String? status;
  String? clientId;
  String? userId;
  String? name;
  String? email;
  String? userCountryCode;
  String? phone;
  String? clientImage;
  String? specializationId;
  String? specializationNameAr;
  String? specializationNameEn;
  String? subSpecializationId;
  String? subSpecializationNameAr;
  String? subSpecializationNameEn;
  String? countryId;
  String? countryFlag;
  String? countryCode;
  String? countryNameAr;
  String? countryNameEn;
  String? governmentId;
  String? governmentNameAr;
  String? governmentNameEn;
  String? createdAt;
  String? updatedAt;

  ServiceRequestModel(
      {this.id,
      this.titleAr,
      this.titleEn,
      this.address,
      this.description,
      this.image,
      this.status,
      this.clientId,
      this.userId,
      this.name,
      this.email,
      this.userCountryCode,
      this.phone,
      this.clientImage,
      this.specializationId,
      this.specializationNameAr,
      this.specializationNameEn,
      this.subSpecializationId,
      this.subSpecializationNameAr,
      this.subSpecializationNameEn,
      this.countryId,
      this.countryFlag,
      this.countryCode,
      this.countryNameAr,
      this.countryNameEn,
      this.governmentId,
      this.governmentNameAr,
      this.governmentNameEn,
      this.createdAt,
      this.updatedAt});

  ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleAr = json['title_ar'];
    titleEn = json['title_en'];
    address = json['address'];
    description = json['description'];
    image = json['image'];
    status = json['status'];
    clientId = json['client_id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    userCountryCode = json['user_country_code'];
    phone = json['phone'];
    clientImage = kBaseImageUrl + json['client_image'];
    specializationId = json['specialization_id'];
    specializationNameAr = json['specialization_name_ar'];
    specializationNameEn = json['specialization_name_en'];
    subSpecializationId = json['sub_specialization_id'];
    subSpecializationNameAr = json['sub_specialization_name_ar'];
    subSpecializationNameEn = json['sub_specialization_name_en'];
    countryId = json['country_id'];
    countryFlag = json['country_flag'];
    countryCode = json['country_code'];
    countryNameAr = json['country_name_ar'];
    countryNameEn = json['country_name_en'];
    governmentId = json['government_id'];
    governmentNameAr = json['government_name_ar'];
    governmentNameEn = json['government_name_en'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title_ar'] = titleAr;
    data['title_en'] = titleEn;
    data['address'] = address;
    data['description'] = description;
    data['image'] = image;
    data['status'] = status;
    data['client_id'] = clientId;
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['user_country_code'] = userCountryCode;
    data['phone'] = phone;
    data['client_image'] = clientImage;
    data['specialization_id'] = specializationId;
    data['specialization_name_ar'] = specializationNameAr;
    data['specialization_name_en'] = specializationNameEn;
    data['sub_specialization_id'] = subSpecializationId;
    data['sub_specialization_name_ar'] = subSpecializationNameAr;
    data['sub_specialization_name_en'] = subSpecializationNameEn;
    data['country_id'] = countryId;
    data['country_flag'] = countryFlag;
    data['country_code'] = countryCode;
    data['country_name_ar'] = countryNameAr;
    data['country_name_en'] = countryNameEn;
    data['government_id'] = governmentId;
    data['government_name_ar'] = governmentNameAr;
    data['government_name_en'] = governmentNameEn;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
