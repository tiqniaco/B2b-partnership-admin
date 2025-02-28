class SignUpModel {
  final String status;
  final String message;
  final User user;
  final Customer customer;
  final String token;

  SignUpModel({
    required this.status,
    required this.message,
    required this.user,
    required this.customer,
    required this.token,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        status: json["status"],
        message: json["message"],
        user: User.fromJson(json["user"]),
        customer: Customer.fromJson(json["customer"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
        "customer": customer.toJson(),
        "token": token,
      };
}

class Customer {
  final int userId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  Customer({
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        userId: json["user_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}

class User {
  final String name;
  final String email;
  final String phoneNumber;
  final String role;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  User({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        phoneNumber: json["phone_number"],
        role: json["role"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone_number": phoneNumber,
        "role": role,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
