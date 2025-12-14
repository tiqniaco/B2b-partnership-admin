import 'package:b2b_partnership_admin/models/admin_model.dart';

class AdminMenuModel {
  String status;
  int jobsCount;
  int shoppingCount;
  int servicesCount;
  int complaintsCount;
  AdminModel data;

  AdminMenuModel({
    required this.status,
    required this.jobsCount,
    required this.shoppingCount,
    required this.servicesCount,
    required this.complaintsCount,
    required this.data,
  });

  factory AdminMenuModel.fromJson(Map<String, dynamic> json) => AdminMenuModel(
        status: json["status"],
        jobsCount: json["jobsCount"],
        shoppingCount: json["shoppingCount"],
        servicesCount: json["servicesCount"],
        complaintsCount: json["complaintsCount"],
        data: AdminModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "jobsCount": jobsCount,
        "shoppingCount": shoppingCount,
        "servicesCount": servicesCount,
        "complaintsCount": complaintsCount,
        "data": data.toJson(),
      };
}
