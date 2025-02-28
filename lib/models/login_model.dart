class LoginModel {
  final String status;
  final String message;
  final User user;
  final String token;
  final bool? hasLocation;

  LoginModel({
    required this.status,
    required this.message,
    required this.user,
    required this.token,
    required this.hasLocation,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        message: json["message"],
        user: User.fromJson(json["user"]),
        token: json["token"],
        hasLocation: json["hasLocation"] ?? true,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
        "token": token,
        "hasLocation": hasLocation,
      };
}

class User {
  final int id;
  final String name;
  final String email;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String phoneNumber;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.phoneNumber,
    required this.role,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        createdAt: DateTime.parse(json["created_at"] ?? DateTime.now()),
        updatedAt: DateTime.parse(json["updated_at"] ?? DateTime.now()),
        phoneNumber: json["phone_number"] ?? "",
        role: json["role"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "phone_number": phoneNumber,
        "role": role,
      };
}
