import 'package:b2b_partnership_admin/core/constants/app_constants.dart';

class AdminModel {
  int userId;
  String name;
  String email;
  String countryCode;
  String phone;
  dynamic image;
  int adminId;
  dynamic countryId;
  dynamic countryNameAr;
  dynamic countryNameEn;
  int governmentId;
  String governmentNameAr;
  String governmentNameEn;
  DateTime createdAt;
  DateTime updatedAt;

  AdminModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.countryCode,
    required this.phone,
    required this.image,
    required this.adminId,
    required this.countryId,
    required this.countryNameAr,
    required this.countryNameEn,
    required this.governmentId,
    required this.governmentNameAr,
    required this.governmentNameEn,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdminModel.fromJson(Map<String, dynamic> json) => AdminModel(
        userId: json["user_id"] ?? 0,
        name: json["name"] ?? '',
        email: json["email"] ?? '',
        countryCode: json["country_code"] ?? '',
        phone: json["phone"] ?? '',
        image: json["image"] == null ? "" : kBaseImageUrl + json["image"],
        adminId: json["admin_id"] ?? 0,
        countryId: json["country_id"] ?? 0,
        countryNameAr: json["country_name_ar"] ?? '_',
        countryNameEn: json["country_name_en"] ?? '_',
        governmentId: json["government_id"] ?? 0,
        governmentNameAr: json["government_name_ar"] ?? '',
        governmentNameEn: json["government_name_en"] ?? '',
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
        "admin_id": adminId,
        "country_id": countryId,
        "country_name_ar": countryNameAr,
        "country_name_en": countryNameEn,
        "government_id": governmentId,
        "government_name_ar": governmentNameAr,
        "government_name_en": governmentNameEn,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
