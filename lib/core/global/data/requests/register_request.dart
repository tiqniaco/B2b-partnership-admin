import 'package:equatable/equatable.dart';

class RegisterRequest extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String? password;
  final String birthDate;
  final String gender;
  final String address;
  final String? image;
  final String countryCode;

  const RegisterRequest(
      {required this.name,
      required this.email,
      required this.phone,
      required this.image,
      this.password,
      required this.birthDate,
      required this.gender,
      required this.address,
      required this.countryCode});

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
        if (password != null) "password": password,
        "birth_date": birthDate,
        "gender": gender,
        "address": address,
        "country_code": countryCode,
      };

  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        password,
        birthDate,
        gender,
        address,
        countryCode,
        image,
      ];
}
