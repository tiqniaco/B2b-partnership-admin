// To parse this JSON data, do
//
//     final providerModel = providerModelFromJson(jsonString);

import 'dart:convert';

import 'package:b2b_partnership_admin/core/constants/app_constants.dart';

ProviderModel providerModelFromJson(String str) =>
    ProviderModel.fromJson(json.decode(str));

String providerModelToJson(ProviderModel data) => json.encode(data.toJson());

class ProviderModel {
  int userId;
  String name;
  String email;
  String countryCode;
  String phone;
  String image;
  String status;
  int providerId;
  String commercialRegister;
  String taxCard;
  String bio;
  int rating;
  dynamic providerVerifiedCode;
  String commercialRegisterNumber;
  String taxCardNumber;
  String vat;
  int providerTypeId;
  String providerTypeNameAr;
  String providerTypeNameEn;
  int specializationId;
  String specializationNameAr;
  String specializationNameEn;
  int subSpecializationId;
  String subSpecializationNameAr;
  String subSpecializationNameEn;
  int countryId;
  String countryNameAr;
  String countryNameEn;
  int governmentId;
  String governmentNameAr;
  String governmentNameEn;
  dynamic contactPhone;
  dynamic contactEmail;
  dynamic contactWhatsapp;
  dynamic contactTelegram;
  dynamic contactInstagram;
  dynamic contactFacebook;
  dynamic contactLinkedin;
  dynamic contactWebsite;
  DateTime createdAt;
  DateTime updatedAt;

  ProviderModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.countryCode,
    required this.phone,
    required this.image,
    required this.status,
    required this.providerId,
    required this.commercialRegister,
    required this.taxCard,
    required this.bio,
    required this.rating,
    required this.providerVerifiedCode,
    required this.commercialRegisterNumber,
    required this.taxCardNumber,
    required this.vat,
    required this.providerTypeId,
    required this.providerTypeNameAr,
    required this.providerTypeNameEn,
    required this.specializationId,
    required this.specializationNameAr,
    required this.specializationNameEn,
    required this.subSpecializationId,
    required this.subSpecializationNameAr,
    required this.subSpecializationNameEn,
    required this.countryId,
    required this.countryNameAr,
    required this.countryNameEn,
    required this.governmentId,
    required this.governmentNameAr,
    required this.governmentNameEn,
    required this.contactPhone,
    required this.contactEmail,
    required this.contactWhatsapp,
    required this.contactTelegram,
    required this.contactInstagram,
    required this.contactFacebook,
    required this.contactLinkedin,
    required this.contactWebsite,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) => ProviderModel(
        userId: json["user_id"] ?? 0,
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        countryCode: json["country_code"] ?? '',
        phone: json["phone"] ?? '',
        image: json["image"] == null ? '' : kBaseImageUrl + json["image"],
        status: json["status"] ?? '',
        providerId: json["provider_id"] ?? 0,
        commercialRegister: json["commercial_register"] == null
            ? ''
            : kBaseImageUrl + json["commercial_register"],
        taxCard:
            json["tax_card"] == null ? '' : kBaseImageUrl + json["tax_card"],
        bio: json["bio"] ?? '',
        rating: json["rating"] ?? 0,
        providerVerifiedCode: json["provider_verified_code"] ?? '',
        commercialRegisterNumber: json["commercial_register_number"] ?? '',
        taxCardNumber: json["tax_card_number"] ?? '',
        vat: json["vat"] ?? '',
        providerTypeId: json["provider_type_id"] ?? 0,
        providerTypeNameAr: json["provider_type_name_ar"] ?? '',
        providerTypeNameEn: json["provider_type_name_en"] ?? '',
        specializationId: json["specialization_id"] ?? 0,
        specializationNameAr: json["specialization_name_ar"] ?? '',
        specializationNameEn: json["specialization_name_en"] ?? '',
        subSpecializationId: json["sub_specialization_id"] ?? 0,
        subSpecializationNameAr: json["sub_specialization_name_ar"] ?? '',
        subSpecializationNameEn: json["sub_specialization_name_en"] ?? '',
        countryId: json["country_id"] ?? 0,
        countryNameAr: json["country_name_ar"] ?? '',
        countryNameEn: json["country_name_en"] ?? '',
        governmentId: json["government_id"] ?? 0,
        governmentNameAr: json["government_name_ar"] ?? '',
        governmentNameEn: json["government_name_en"] ?? '',
        contactPhone: json["contact_phone"] ?? '',
        contactEmail: json["contact_email"] ?? '',
        contactWhatsapp: json["contact_whatsapp"] ?? '',
        contactTelegram: json["contact_telegram"] ?? '',
        contactInstagram: json["contact_instagram"] ?? '',
        contactFacebook: json["contact_facebook"] ?? '',
        contactLinkedin: json["contact_linkedin"] ?? '',
        contactWebsite: json["contact_website"] ?? '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "email": email,
        "country_code": countryCode,
        "phone": phone,
        "image": image,
        "status": status,
        "provider_id": providerId,
        "commercial_register": commercialRegister,
        "tax_card": taxCard,
        "bio": bio,
        "rating": rating,
        "provider_verified_code": providerVerifiedCode,
        "commercial_register_number": commercialRegisterNumber,
        "tax_card_number": taxCardNumber,
        "vat": vat,
        "provider_type_id": providerTypeId,
        "provider_type_name_ar": providerTypeNameAr,
        "provider_type_name_en": providerTypeNameEn,
        "specialization_id": specializationId,
        "specialization_name_ar": specializationNameAr,
        "specialization_name_en": specializationNameEn,
        "sub_specialization_id": subSpecializationId,
        "sub_specialization_name_ar": subSpecializationNameAr,
        "sub_specialization_name_en": subSpecializationNameEn,
        "country_id": countryId,
        "country_name_ar": countryNameAr,
        "country_name_en": countryNameEn,
        "government_id": governmentId,
        "government_name_ar": governmentNameAr,
        "government_name_en": governmentNameEn,
        "contact_phone": contactPhone,
        "contact_email": contactEmail,
        "contact_whatsapp": contactWhatsapp,
        "contact_telegram": contactTelegram,
        "contact_instagram": contactInstagram,
        "contact_facebook": contactFacebook,
        "contact_linkedin": contactLinkedin,
        "contact_website": contactWebsite,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
