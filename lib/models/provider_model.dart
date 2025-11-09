import 'package:b2b_partnership_admin/core/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

class ProviderModel extends Equatable {
  final String userId;
  final String name;
  final String email;
  final String countryCode;
  final String phone;
  final String image;
  final String status;
  final String providerId;
  final String commercialRegister;
  final String taxCard;
  final String commercialRegisterNumber;
  final String taxCardNumber;
  final String vat;
  final String bio;
  final String rating;
  final String providerVerifiedCode;
  final String providerTypeId;
  final String providerTypeNameAr;
  final String providerTypeNameEn;
  final String specializationId;
  final String specializationNameAr;
  final String specializationNameEn;
  final String subSpecializationId;
  final String subSpecializationNameAr;
  final String subSpecializationNameEn;
  final String countryId;
  final String countryNameAr;
  final String countryNameEn;
  final String governmentId;
  final String governmentNameAr;
  final String governmentNameEn;
  final String contactPhone;
  final String contactEmail;
  final String contactWhatsapp;
  final String contactTelegram;
  final String contactInstagram;
  final String contactFacebook;
  final String contactLinkedin;
  final String contactWebsite;
  final String createdAt;
  final String updatedAt;
  final String isFavorite;

  const ProviderModel({
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
    required this.commercialRegisterNumber,
    required this.taxCardNumber,
    required this.vat,
    required this.bio,
    required this.rating,
    required this.providerVerifiedCode,
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
    required this.isFavorite,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) => ProviderModel(
        userId: json["user_id"].toString(),
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        countryCode: json["country_code"] ?? "",
        phone: json["phone"] ?? "",
        image: json["image"] == null ? "" : kBaseImageUrl + json["image"],
        status: json["status"] ?? "",
        providerId: json["provider_id"].toString(),
        commercialRegister: json["commercial_register"] == null
            ? ""
            : kBaseImageUrl + json["commercial_register"],
        taxCard:
            json["tax_card"] == null ? "" : kBaseImageUrl + json["tax_card"],
        commercialRegisterNumber: json["commercial_register_number"] ?? "",
        taxCardNumber: json["tax_card_number"] ?? "",
        vat: json["vat"] ?? "",
        bio: json["bio"] ?? "",
        rating: json["rating"].toString(),
        providerVerifiedCode: json["provider_verified_code"] ?? "",
        providerTypeId: json["provider_type_id"].toString(),
        providerTypeNameAr: json["provider_type_name_ar"] ?? "",
        providerTypeNameEn: json["provider_type_name_en"] ?? "",
        specializationId: json["specialization_id"].toString(),
        specializationNameAr: json["specialization_name_ar"] ?? "",
        specializationNameEn: json["specialization_name_en"] ?? "",
        subSpecializationId: json["sub_specialization_id"].toString(),
        subSpecializationNameAr: json["sub_specialization_name_ar"] ?? "",
        subSpecializationNameEn: json["sub_specialization_name_en"] ?? "",
        countryId: json["country_id"].toString(),
        countryNameAr: json["country_name_ar"] ?? "",
        countryNameEn: json["country_name_en"] ?? "",
        governmentId: json["government_id"].toString(),
        governmentNameAr: json["government_name_ar"] ?? "",
        governmentNameEn: json["government_name_en"] ?? "",
        contactPhone: json["contact_phone"] ?? "",
        contactEmail: json["contact_email"] ?? "",
        contactWhatsapp: json["contact_whatsapp"] ?? "",
        contactTelegram: json["contact_telegram"] ?? "",
        contactInstagram: json["contact_instagram"] ?? "",
        contactFacebook: json["contact_facebook"] ?? "",
        contactLinkedin: json["contact_linkedin"] ?? "",
        contactWebsite: json["contact_website"] ?? "",
        createdAt: json["created_at"] ?? "",
        updatedAt: json["updated_at"] ?? "",
        isFavorite: json["is_favorite"] ?? "",
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
        "commercial_register_number": commercialRegisterNumber,
        "tax_card_number": taxCardNumber,
        "vat": vat,
        "bio": bio,
        "rating": rating,
        "provider_verified_code": providerVerifiedCode,
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
        "created_at": createdAt,
        "updated_at": updatedAt,
        "is_favorite": isFavorite,
      };

  @override
  List<Object?> get props => [
        userId,
        name,
        email,
        countryCode,
        phone,
        image,
        status,
        providerId,
        commercialRegister,
        taxCard,
        commercialRegisterNumber,
        taxCardNumber,
        vat,
        bio,
        rating,
        providerVerifiedCode,
        providerTypeId,
        providerTypeNameAr,
        providerTypeNameEn,
        specializationId,
        specializationNameAr,
        specializationNameEn,
        subSpecializationId,
        subSpecializationNameAr,
        subSpecializationNameEn,
        countryId,
        countryNameAr,
        countryNameEn,
        governmentId,
        governmentNameAr,
        governmentNameEn,
        contactPhone,
        contactEmail,
        contactWhatsapp,
        contactTelegram,
        contactInstagram,
        contactFacebook,
        contactLinkedin,
        contactWebsite,
      ];
}
