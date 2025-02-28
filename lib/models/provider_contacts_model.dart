import '/core/services/app_prefs.dart';
import 'package:equatable/equatable.dart';
import 'package:get/get.dart';

class ProviderContactsModel extends Equatable {
  final String? phone;
  final String? email;
  final String? whatsapp;
  final String? telegram;
  final String? instagram;
  final String? facebook;
  final String? linkedin;
  final String? website;

  const ProviderContactsModel({
    this.phone,
    this.email,
    this.whatsapp,
    this.telegram,
    this.instagram,
    this.facebook,
    this.linkedin,
    this.website,
  });

  ProviderContactsModel copyWith({
    String? phone,
    String? email,
    String? whatsapp,
    String? telegram,
    String? instagram,
    String? facebook,
    String? linkedin,
    String? website,
  }) {
    return ProviderContactsModel(
      phone: phone ?? this.phone,
      email: email ?? this.email,
      whatsapp: whatsapp ?? this.whatsapp,
      telegram: telegram ?? this.telegram,
      instagram: instagram ?? this.instagram,
      facebook: facebook ?? this.facebook,
      linkedin: linkedin ?? this.linkedin,
      website: website ?? this.website,
    );
  }

  factory ProviderContactsModel.fromJson(Map<String, dynamic> json) {
    return ProviderContactsModel(
      phone: json['phone'],
      email: json['email'],
      whatsapp: json['whatsapp'],
      telegram: json['telegram'],
      instagram: json['instagram'],
      facebook: json['facebook'],
      linkedin: json['linkedin'],
      website: json['website'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'provider_id': Get.find<AppPreferences>().getUserRoleId(),
      'phone': phone,
      'email': email,
      'whatsapp': whatsapp,
      'telegram': telegram,
      'instagram': instagram,
      'facebook': facebook,
      'linkedin': linkedin,
      'website': website,
    };
  }

  @override
  List<Object?> get props => [
        phone,
        email,
        whatsapp,
        telegram,
        instagram,
        facebook,
        linkedin,
        website,
      ];
}
