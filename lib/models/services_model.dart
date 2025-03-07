import '/core/constants/app_constants.dart';
import '/models/provider_model.dart';

class ServiceModel {
  String? status;
  String? message;
  ServiceRequestModel? data;
  ProviderModel? provider;

  ServiceModel({this.status, this.message, this.data, this.provider});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null
        ? ServiceRequestModel.fromJson(json['data'])
        : null;
    provider = json['provider'] != null
        ? ProviderModel.fromJson(json['provider'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (provider != null) {
      data['provider'] = provider!.toJson();
    }
    return data;
  }
}

class ServiceRequestModel {
  String? id;
  String? providerId;
  String? nameAr;
  String? nameEn;
  String? address;
  String? description;
  String? image;
  //String? price;
  String? rating;
  String? overview;
  String? video;
  String? countryId;
  String? countryNameAr;
  String? countryNameEn;
  String? governmentsId;
  String? governmentNameAr;
  String? governmentNameEn;
  String? specializationId;
  String? specializationNameAr;
  String? specializationNameEn;
  String? subSpecializationId;
  String? subSpecializationNameAr;
  String? subSpecializationNameEn;
  String? isFavorite;
  String? createdAt;
  String? updatedAt;

  ServiceRequestModel(
      {this.id,
      this.providerId,
      this.nameAr,
      this.nameEn,
      this.address,
      this.description,
      this.image,
      // this.price,
      this.rating,
      this.overview,
      this.video,
      this.countryId,
      this.countryNameAr,
      this.countryNameEn,
      this.governmentsId,
      this.governmentNameAr,
      this.governmentNameEn,
      this.specializationId,
      this.specializationNameAr,
      this.specializationNameEn,
      this.subSpecializationId,
      this.subSpecializationNameAr,
      this.subSpecializationNameEn,
      this.isFavorite,
      this.createdAt,
      this.updatedAt});

  ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    providerId = json['provider_id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    address = json['address'];
    description = json['description'];
    image = kBaseImageUrl + json['image'];
    // price = json['price'];
    rating = json['rating'];
    overview = json['overview'];
    video = json['video'];
    countryId = json['country_id'];
    countryNameAr = json['country_name_ar'];
    countryNameEn = json['country_name_en'];
    governmentsId = json['governments_id'];
    governmentNameAr = json['government_name_ar'];
    governmentNameEn = json['government_name_en'];
    specializationId = json['specialization_id'];
    specializationNameAr = json['specialization_name_ar'];
    specializationNameEn = json['specialization_name_en'];
    subSpecializationId = json['sub_specialization_id'];
    subSpecializationNameAr = json['sub_specialization_name_ar'];
    subSpecializationNameEn = json['sub_specialization_name_en'];
    isFavorite = json['is_favorite'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['provider_id'] = providerId;
    data['name_ar'] = nameAr;
    data['name_en'] = nameEn;
    data['address'] = address;
    data['description'] = description;
    data['image'] = image;
    // data['price'] = price;
    data['rating'] = rating;
    data['overview'] = overview;
    data['video'] = video;
    data['country_id'] = countryId;
    data['country_name_ar'] = countryNameAr;
    data['country_name_en'] = countryNameEn;
    data['governments_id'] = governmentsId;
    data['government_name_ar'] = governmentNameAr;
    data['government_name_en'] = governmentNameEn;
    data['specialization_id'] = specializationId;
    data['specialization_name_ar'] = specializationNameAr;
    data['specialization_name_en'] = specializationNameEn;
    data['sub_specialization_id'] = subSpecializationId;
    data['sub_specialization_name_ar'] = subSpecializationNameAr;
    data['sub_specialization_name_en'] = subSpecializationNameEn;
    data['is_favorite'] = isFavorite;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
