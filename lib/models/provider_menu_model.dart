import '/models/provider_model.dart';

class ProviderMenuModel {
  String? status;
  String? message;
  int? jobsCount;
  int? shoppingCount;
  int? ordersCount;
  int? complaintsCount;
  ProviderModel? data;

  ProviderMenuModel(
      {this.status,
      this.message,
      this.jobsCount,
      this.shoppingCount,
      this.ordersCount,
      this.complaintsCount,
      this.data});

  ProviderMenuModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    jobsCount = json['jobsCount'];
    shoppingCount = json['shoppingCount'];
    ordersCount = json['ordersCount'];
    complaintsCount = json['complaintsCount'];
    data = json['data'] != null ? ProviderModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['jobsCount'] = jobsCount;
    data['shoppingCount'] = shoppingCount;
    data['ordersCount'] = ordersCount;
    data['complaintsCount'] = complaintsCount;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
