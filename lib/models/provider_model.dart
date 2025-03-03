import '/core/constants/app_constants.dart';

class ProviderModel {
  String? userId;
  String? name;
  String? email;
  String? countryCode;
  String? phone;
  String? image;
  String? providerId;
  String? commercialRegister;
  String? taxCard;
  String? bio;
  String? rating;
  String? providerTypeId;
  String? providerTypeNameAr;
  String? providerTypeNameEn;
  String? specializationId;
  String? specializationNameAr;
  String? specializationNameEn;
  String? subSpecializationId;
  String? subSpecializationNameAr;
  String? subSpecializationNameEn;
  String? countryId;
  String? countryNameAr;
  String? countryNameEn;
  String? governmentId;
  String? governmentNameAr;
  String? governmentNameEn;
  String? contactPhone;
  String? contactEmail;
  String? contactWhatsapp;
  String? contactTelegram;
  String? contactInstagram;
  String? contactFacebook;
  String? contactLinkedin;
  String? contactWebsite;
  String? createdAt;
  String? updatedAt;
  String? isFavorite;

  ProviderModel(
      {this.userId,
      this.name,
      this.email,
      this.countryCode,
      this.phone,
      this.image,
      this.providerId,
      this.commercialRegister,
      this.taxCard,
      this.bio,
      this.rating,
      this.providerTypeId,
      this.providerTypeNameAr,
      this.providerTypeNameEn,
      this.specializationId,
      this.specializationNameAr,
      this.specializationNameEn,
      this.subSpecializationId,
      this.subSpecializationNameAr,
      this.subSpecializationNameEn,
      this.countryId,
      this.countryNameAr,
      this.countryNameEn,
      this.governmentId,
      this.governmentNameAr,
      this.governmentNameEn,
      this.contactPhone,
      this.contactEmail,
      this.contactWhatsapp,
      this.contactTelegram,
      this.contactInstagram,
      this.contactFacebook,
      this.contactLinkedin,
      this.contactWebsite,
      this.createdAt,
      this.updatedAt,
      this.isFavorite});

  ProviderModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    countryCode = json['country_code'];
    phone = json['phone'];
    image = kBaseImageUrl + (json['image']??"");
    providerId = json['provider_id'];
    commercialRegister = kBaseImageUrl + json['commercial_register'];
    taxCard = kBaseImageUrl + json['tax_card'];
    bio = json['bio'];
    rating = json['rating'];
    providerTypeId = json['provider_type_id'];
    providerTypeNameAr = json['provider_type_name_ar'];
    providerTypeNameEn = json['provider_type_name_en'];
    specializationId = json['specialization_id'];
    specializationNameAr = json['specialization_name_ar'];
    specializationNameEn = json['specialization_name_en'];
    subSpecializationId = json['sub_specialization_id'];
    subSpecializationNameAr = json['sub_specialization_name_ar'];
    subSpecializationNameEn = json['sub_specialization_name_en'];
    countryId = json['country_id'];
    countryNameAr = json['country_name_ar'];
    countryNameEn = json['country_name_en'];
    governmentId = json['government_id'];
    governmentNameAr = json['government_name_ar'];
    governmentNameEn = json['government_name_en'];
    contactPhone = json['contact_phone'];
    contactEmail = json['contact_email'];
    contactWhatsapp = json['contact_whatsapp'];
    contactTelegram = json['contact_telegram'];
    contactInstagram = json['contact_instagram'];
    contactFacebook = json['contact_facebook'];
    contactLinkedin = json['contact_linkedin'];
    contactWebsite = json['contact_website'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isFavorite = json['is_favorite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['country_code'] = countryCode;
    data['phone'] = phone;
    data['image'] = image;
    data['provider_id'] = providerId;
    data['commercial_register'] = commercialRegister;
    data['tax_card'] = taxCard;
    data['bio'] = bio;
    data['rating'] = rating;
    data['provider_type_name_ar'] = providerTypeNameAr;
    data['provider_type_name_en'] = providerTypeNameEn;
    data['specialization_id'] = specializationId;
    data['specialization_name_ar'] = specializationNameAr;
    data['specialization_name_en'] = specializationNameEn;
    data['sub_specialization_id'] = subSpecializationId;
    data['sub_specialization_name_ar'] = subSpecializationNameAr;
    data['sub_specialization_name_en'] = subSpecializationNameEn;
    data['country_id'] = countryId;
    data['country_name_ar'] = countryNameAr;
    data['country_name_en'] = countryNameEn;
    data['government_id'] = governmentId;
    data['government_name_ar'] = governmentNameAr;
    data['government_name_en'] = governmentNameEn;
    data['contact_phone'] = contactPhone;
    data['contact_email'] = contactEmail;
    data['contact_whatsapp'] = contactWhatsapp;
    data['contact_telegram'] = contactTelegram;
    data['contact_instagram'] = contactInstagram;
    data['contact_facebook'] = contactFacebook;
    data['contact_linkedin'] = contactLinkedin;
    data['contact_website'] = contactWebsite;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['is_favorite'] = isFavorite;
    return data;
  }
}
