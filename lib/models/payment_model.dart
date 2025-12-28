class PaymentPackage {
  int? id;
  String? name;
  String? description;
  String? price;
  int? monthsPlanId;
  int? monthsPlanName;
  int? serviceCount;
  int? productCount;
  bool? isTrial;
  int? trialDays;
  bool? isActive;
  bool? isPopular;
  String? createdAt;
  String? updatedAt;

  PaymentPackage(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.monthsPlanId,
      this.monthsPlanName,
      this.serviceCount,
      this.productCount,
      this.isTrial,
      this.trialDays,
      this.isActive,
      this.isPopular,
      this.createdAt,
      this.updatedAt});

  PaymentPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    monthsPlanId = json['months_plan_id'];
    monthsPlanName = json['months_plan_name'];
    serviceCount = json['service_count'];
    productCount = json['product_count'];
    isTrial = json['is_trial'];
    trialDays = json['trial_days'];
    isActive = json['is_active'];
    isPopular = json['is_popular'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['months_plan_id'] = monthsPlanId;
    data['months_plan_name'] = monthsPlanName;
    data['service_count'] = serviceCount;
    data['product_count'] = productCount;
    data['is_trial'] = isTrial;
    data['trial_days'] = trialDays;
    data['is_active'] = isActive;
    data['is_popular'] = isPopular;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
