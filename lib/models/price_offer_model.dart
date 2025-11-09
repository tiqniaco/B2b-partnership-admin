import 'package:b2b_partnership_admin/core/constants/app_constants.dart';

class PriceOfferModel {
  String requestOfferId;
  String userId;
  String requestServiceId;
  String offerDescription;
  String requestOfferStatus;
  String requestOfferPrice;
  String requestOfferDuration;
  DateTime requestOfferCreatedAt;
  DateTime requestOfferUpdatedAt;
  String userName;
  String userEmail;
  String userCountryCode;
  String userPhone;
  String userImage;
  String userRole;
  String roleId;

  PriceOfferModel({
    required this.requestOfferId,
    required this.userId,
    required this.requestServiceId,
    required this.offerDescription,
    required this.requestOfferStatus,
    required this.requestOfferPrice,
    required this.requestOfferDuration,
    required this.requestOfferCreatedAt,
    required this.requestOfferUpdatedAt,
    required this.userName,
    required this.userEmail,
    required this.userCountryCode,
    required this.userPhone,
    required this.userImage,
    required this.userRole,
    required this.roleId,
  });

  factory PriceOfferModel.fromJson(Map<String, dynamic> json) =>
      PriceOfferModel(
        requestOfferId: json["request_offer_id"],
        userId: json["user_id"],
        requestServiceId: json["request_service_id"],
        offerDescription: json["offer_description"],
        requestOfferStatus: json["request_offer_status"],
        requestOfferPrice: json["request_offer_price"],
        requestOfferDuration: json["request_offer_duration"],
        requestOfferCreatedAt: DateTime.parse(json["request_offer_created_at"]),
        requestOfferUpdatedAt: DateTime.parse(json["request_offer_updated_at"]),
        userName: json["user_name"],
        userEmail: json["user_email"],
        userCountryCode: json["user_country_code"],
        userPhone: json["user_phone"],
        userImage: json["user_image"] == null
            ? ""
            : kBaseImageUrl + json["user_image"],
        userRole: json["user_role"],
        roleId: json["role_id"],
      );

  Map<String, dynamic> toJson() => {
        "request_offer_id": requestOfferId,
        "user_id": userId,
        "request_service_id": requestServiceId,
        "offer_description": offerDescription,
        "request_offer_status": requestOfferStatus,
        "request_offer_price": requestOfferPrice,
        "request_offer_duration": requestOfferDuration,
        "request_offer_created_at": requestOfferCreatedAt.toIso8601String(),
        "request_offer_updated_at": requestOfferUpdatedAt.toIso8601String(),
        "user_name": userName,
        "user_email": userEmail,
        "user_country_code": userCountryCode,
        "user_phone": userPhone,
        "user_image": userImage,
        "user_role": userRole,
        "role_id": roleId,
      };
}
