import 'package:equatable/equatable.dart';

class EditProfileRequest extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? countryCode;
  final String? birthDate;
  final String? gender;
  final String? address;
  final String? image;

  const EditProfileRequest({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.countryCode,
    this.image,
    this.birthDate,
    this.gender,
    this.address,
  });

  Map<String, dynamic> toJson() => {
        if (id != null) "id": id,
        if (name != null) "name": name,
        if (email != null) "email": email,
        if (phone != null) "phone": phone,
        if (countryCode != null) "country_code": countryCode,
        if (birthDate != null) "birth_date": birthDate,
        if (gender != null) "gender": gender,
        if (address != null) "address": address,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        countryCode,
        birthDate,
        gender,
        address,
        image,
      ];
}
