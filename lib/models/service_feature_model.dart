class ServiceFeatureModel {
  int? id;
  String? providerServiceId;
  String? featureEn;
  String? featureAr;
  String? createdAt;
  String? updatedAt;

  ServiceFeatureModel(
      {this.id,
      this.providerServiceId,
      this.featureEn,
      this.featureAr,
      this.createdAt,
      this.updatedAt});

  ServiceFeatureModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    providerServiceId = json['provider_service_id'];
    featureEn = json['feature_en'];
    featureAr = json['feature_ar'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['provider_service_id'] = providerServiceId;
    data['feature_en'] = featureEn;
    data['feature_ar'] = featureAr;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
