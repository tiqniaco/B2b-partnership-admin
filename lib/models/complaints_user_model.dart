import 'package:b2b_partnership_admin/core/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

class ComplaintsUserModel extends Equatable {
  final String id;
  final String name;
  final String email;
  final String image;
  final String countryCode;
  final String phone;
  final String role;

  const ComplaintsUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.countryCode,
    required this.phone,
    required this.role,
  });

  factory ComplaintsUserModel.fromJson(Map<String, dynamic> json) =>
      ComplaintsUserModel(
        id: json["id"].toString(),
        name: json["name"].toString(),
        email: json["email"].toString(),
        image: kBaseImageUrl + json["image"].toString(),
        countryCode: json["country_code"].toString(),
        phone: json["phone"].toString(),
        role: json["role"].toString(),
      );

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        image,
        countryCode,
        phone,
        role,
      ];
}
