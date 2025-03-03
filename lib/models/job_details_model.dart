import 'package:b2b_partnership_admin/core/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

class JobDetailsModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final String skills;
  final String experience;
  final String contractType;
  final String expiryDate;
  final String gender;
  final String salary;
  final String employerId;
  final String status;
  final String userId;
  final String name;
  final String email;
  final String countryCode;
  final String phone;
  final String image;
  final String providerId;
  final String commercialRegister;
  final String taxCard;
  final String bio;
  final String rating;
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
  final String? contactPhone;
  final String? contactEmail;
  final String? contactWhatsapp;
  final String? contactTelegram;
  final String? contactInstagram;
  final String? contactFacebook;
  final String? contactLinkedin;
  final String? contactWebsite;
  final String providerCreatedAt;
  final String providerUpdatedAt;
  final String jobCreatedAt;
  final String jobUpdatedAt;

  const JobDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.skills,
    required this.experience,
    required this.contractType,
    required this.expiryDate,
    required this.gender,
    required this.salary,
    required this.employerId,
    required this.status,
    required this.userId,
    required this.name,
    required this.email,
    required this.countryCode,
    required this.phone,
    required this.image,
    required this.providerId,
    required this.commercialRegister,
    required this.taxCard,
    required this.bio,
    required this.rating,
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
    required this.providerCreatedAt,
    required this.providerUpdatedAt,
    required this.jobCreatedAt,
    required this.jobUpdatedAt,
  });

  factory JobDetailsModel.fromJson(Map<String, dynamic> json) =>
      JobDetailsModel(
        id: json["id"].toString(),
        title: json["title"].toString(),
        description: json["description"].toString(),
        skills: json["skills"].toString(),
        experience: json["experience"].toString(),
        contractType: json["contract_type"].toString(),
        expiryDate: json["expiry_date"].toString(),
        gender: json["gender"].toString(),
        salary: json["salary"].toString(),
        employerId: json["employer_id"].toString(),
        status: json["status"].toString(),
        userId: json["user_id"].toString(),
        name: json["name"].toString(),
        email: json["email"].toString(),
        countryCode: json["country_code"].toString(),
        phone: json["phone"].toString(),
        image: kBaseImageUrl + json["image"].toString(),
        providerId: json["provider_id"].toString(),
        commercialRegister:
            kBaseImageUrl + json["commercial_register"].toString(),
        taxCard: kBaseImageUrl + json["tax_card"].toString(),
        bio: json["bio"].toString(),
        rating: json["rating"].toString(),
        providerTypeId: json["provider_type_id"].toString(),
        providerTypeNameAr: json["provider_type_name_ar"].toString(),
        providerTypeNameEn: json["provider_type_name_en"].toString(),
        specializationId: json["specialization_id"].toString(),
        specializationNameAr: json["specialization_name_ar"].toString(),
        specializationNameEn: json["specialization_name_en"].toString(),
        subSpecializationId: json["sub_specialization_id"].toString(),
        subSpecializationNameAr: json["sub_specialization_name_ar"].toString(),
        subSpecializationNameEn: json["sub_specialization_name_en"].toString(),
        countryId: json["country_id"].toString(),
        countryNameAr: json["country_name_ar"].toString(),
        countryNameEn: json["country_name_en"].toString(),
        governmentId: json["government_id"].toString(),
        governmentNameAr: json["government_name_ar"].toString(),
        governmentNameEn: json["government_name_en"].toString(),
        contactPhone: json["contact_phone"].toString(),
        contactEmail: json["contact_email"].toString(),
        contactWhatsapp: json["contact_whatsapp"].toString(),
        contactTelegram: json["contact_telegram"].toString(),
        contactInstagram: json["contact_instagram"].toString(),
        contactFacebook: json["contact_facebook"].toString(),
        contactLinkedin: json["contact_linkedin"].toString(),
        contactWebsite: json["contact_website"].toString(),
        providerCreatedAt: json["provider_created_at"].toString(),
        providerUpdatedAt: json["provider_updated_at"].toString(),
        jobCreatedAt: json["job_created_at"].toString(),
        jobUpdatedAt: json["job_updated_at"].toString(),
      );

  @override
  @override
  List<Object?> get props => [
        id,
        title,
        description,
        skills,
        experience,
        contractType,
        expiryDate,
        gender,
        salary,
        employerId,
        status,
        userId,
        name,
        email,
        countryCode,
        phone,
        image,
        providerId,
        commercialRegister,
        taxCard,
        bio,
        rating,
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
        providerCreatedAt,
        providerUpdatedAt,
        jobCreatedAt,
        jobUpdatedAt,
      ];
}
