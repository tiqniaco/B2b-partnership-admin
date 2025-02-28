import '/core/constants/app_constants.dart';

class PriceOfferModel {
  int? currentPage;
  List<ModelData>? data;
  int? lastPage;

  PriceOfferModel({this.currentPage, this.data, this.lastPage});

  PriceOfferModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ModelData>[];
      json['data'].forEach((v) {
        data!.add(ModelData.fromJson(v));
      });
    }
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['last_page'] = lastPage;
    return data;
  }
}

class ModelData {
  String? requestOfferId;
  String? providerId;
  String? requestServiceId;
  String? offerDescription;
  String? requestOfferStatus;
  String? requestOfferPrice;
  String? requestOfferCreatedAt;
  String? requestOfferUpdatedAt;
  String? providerUserId;
  String? providerName;
  String? providerEmail;
  String? providerCountryCode;
  String? providerPhone;
  String? providerImage;
  String? providerCommercialRegister;
  String? providerTaxCard;
  String? providerBio;
  String? providerRating;
  String? providerTypeNameAr;
  String? providerTypeNameEn;
  String? providerSpecializationId;
  String? providerSpecializationNameAr;
  String? providerSpecializationNameEn;
  String? providerSubSpecializationId;
  String? providerSubSpecializationNameAr;
  String? providerSubSpecializationNameEn;
  String? providerCountryId;
  String? providerCountryNameAr;
  String? providerCountryNameEn;
  String? providerGovernmentId;
  String? providerGovernmentNameAr;
  String? providerGovernmentNameEn;
  String? providerContactPhone;
  String? providerContactEmail;
  String? providerContactWhatsapp;
  String? providerContactTelegram;
  String? providerContactInstagram;
  String? providerContactFacebook;
  String? providerContactLinkedin;
  String? providerContactWebsite;
  String? providerCreatedAt;
  String? providerUpdatedAt;

  ModelData(
      {this.requestOfferId,
      this.providerId,
      this.requestServiceId,
      this.offerDescription,
      this.requestOfferStatus,
      this.requestOfferPrice,
      this.requestOfferCreatedAt,
      this.requestOfferUpdatedAt,
      this.providerUserId,
      this.providerName,
      this.providerEmail,
      this.providerCountryCode,
      this.providerPhone,
      this.providerImage,
      this.providerCommercialRegister,
      this.providerTaxCard,
      this.providerBio,
      this.providerRating,
      this.providerTypeNameAr,
      this.providerTypeNameEn,
      this.providerSpecializationId,
      this.providerSpecializationNameAr,
      this.providerSpecializationNameEn,
      this.providerSubSpecializationId,
      this.providerSubSpecializationNameAr,
      this.providerSubSpecializationNameEn,
      this.providerCountryId,
      this.providerCountryNameAr,
      this.providerCountryNameEn,
      this.providerGovernmentId,
      this.providerGovernmentNameAr,
      this.providerGovernmentNameEn,
      this.providerContactPhone,
      this.providerContactEmail,
      this.providerContactWhatsapp,
      this.providerContactTelegram,
      this.providerContactInstagram,
      this.providerContactFacebook,
      this.providerContactLinkedin,
      this.providerContactWebsite,
      this.providerCreatedAt,
      this.providerUpdatedAt});

  ModelData.fromJson(Map<String, dynamic> json) {
    requestOfferId = json['request_offer_id'];
    providerId = json['provider_id'];
    requestServiceId = json['request_service_id'];
    offerDescription = json['offer_description'];
    requestOfferStatus = json['request_offer_status'];
    requestOfferPrice = json['request_offer_price'];
    requestOfferCreatedAt = json['request_offer_created_at'];
    requestOfferUpdatedAt = json['request_offer_updated_at'];
    providerUserId = json['provider_user_id'];
    providerName = json['provider_name'];
    providerEmail = json['provider_email'];
    providerCountryCode = json['provider_country_code'];
    providerPhone = json['provider_phone'];
    providerImage = kBaseImageUrl + json['provider_image'];
    providerCommercialRegister = json['provider_commercial_register'];
    providerTaxCard = json['provider_tax_card'];
    providerBio = json['provider_bio'];
    providerRating = json['provider_rating'];
    providerTypeNameAr = json['provider_type_name_ar'];
    providerTypeNameEn = json['provider_type_name_en'];
    providerSpecializationId = json['provider_specialization_id'];
    providerSpecializationNameAr = json['provider_specialization_name_ar'];
    providerSpecializationNameEn = json['provider_specialization_name_en'];
    providerSubSpecializationId = json['provider_sub_specialization_id'];
    providerSubSpecializationNameAr =
        json['provider_sub_specialization_name_ar'];
    providerSubSpecializationNameEn =
        json['provider_sub_specialization_name_en'];
    providerCountryId = json['provider_country_id'];
    providerCountryNameAr = json['provider_country_name_ar'];
    providerCountryNameEn = json['provider_country_name_en'];
    providerGovernmentId = json['provider_government_id'];
    providerGovernmentNameAr = json['provider_government_name_ar'];
    providerGovernmentNameEn = json['provider_government_name_en'];
    providerContactPhone = json['provider_contact_phone'];
    providerContactEmail = json['provider_contact_email'];
    providerContactWhatsapp = json['provider_contact_whatsapp'];
    providerContactTelegram = json['provider_contact_telegram'];
    providerContactInstagram = json['provider_contact_instagram'];
    providerContactFacebook = json['provider_contact_facebook'];
    providerContactLinkedin = json['provider_contact_linkedin'];
    providerContactWebsite = json['provider_contact_website'];
    providerCreatedAt = json['provider_created_at'];
    providerUpdatedAt = json['provider_updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['request_offer_id'] = requestOfferId;
    data['provider_id'] = providerId;
    data['request_service_id'] = requestServiceId;
    data['offer_description'] = offerDescription;
    data['request_offer_status'] = requestOfferStatus;
    data['request_offer_price'] = requestOfferPrice;
    data['request_offer_created_at'] = requestOfferCreatedAt;
    data['request_offer_updated_at'] = requestOfferUpdatedAt;
    data['provider_user_id'] = providerUserId;
    data['provider_name'] = providerName;
    data['provider_email'] = providerEmail;
    data['provider_country_code'] = providerCountryCode;
    data['provider_phone'] = providerPhone;
    data['provider_image'] = providerImage;
    data['provider_commercial_register'] = providerCommercialRegister;
    data['provider_tax_card'] = providerTaxCard;
    data['provider_bio'] = providerBio;
    data['provider_rating'] = providerRating;
    data['provider_type_name_ar'] = providerTypeNameAr;
    data['provider_type_name_en'] = providerTypeNameEn;
    data['provider_specialization_id'] = providerSpecializationId;
    data['provider_specialization_name_ar'] = providerSpecializationNameAr;
    data['provider_specialization_name_en'] = providerSpecializationNameEn;
    data['provider_sub_specialization_id'] = providerSubSpecializationId;
    data['provider_sub_specialization_name_ar'] =
        providerSubSpecializationNameAr;
    data['provider_sub_specialization_name_en'] =
        providerSubSpecializationNameEn;
    data['provider_country_id'] = providerCountryId;
    data['provider_country_name_ar'] = providerCountryNameAr;
    data['provider_country_name_en'] = providerCountryNameEn;
    data['provider_government_id'] = providerGovernmentId;
    data['provider_government_name_ar'] = providerGovernmentNameAr;
    data['provider_government_name_en'] = providerGovernmentNameEn;
    data['provider_contact_phone'] = providerContactPhone;
    data['provider_contact_email'] = providerContactEmail;
    data['provider_contact_whatsapp'] = providerContactWhatsapp;
    data['provider_contact_telegram'] = providerContactTelegram;
    data['provider_contact_instagram'] = providerContactInstagram;
    data['provider_contact_facebook'] = providerContactFacebook;
    data['provider_contact_linkedin'] = providerContactLinkedin;
    data['provider_contact_website'] = providerContactWebsite;
    data['provider_created_at'] = providerCreatedAt;
    data['provider_updated_at'] = providerUpdatedAt;
    return data;
  }
}
