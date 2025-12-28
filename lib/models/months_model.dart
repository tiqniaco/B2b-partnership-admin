class PaymentMonths {
  int? id;
  int? durationMonths;
  String? createdAt;
  String? updatedAt;

  PaymentMonths({this.id, this.durationMonths, this.createdAt, this.updatedAt});

  PaymentMonths.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    durationMonths = json['duration_months'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['duration_months'] = durationMonths;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
