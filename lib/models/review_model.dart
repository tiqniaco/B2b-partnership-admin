class ReviewModel {
  int? id;
  String? review;
  String? rating;
  String? name;
  String? email;
  String? image;
  String? userId;
  String? createdAt;

  ReviewModel(
      {this.id,
      this.review,
      this.rating,
      this.name,
      this.email,
      this.image,
      this.userId,
      this.createdAt});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    review = json['review'];
    rating = json['rating'].toString();
    name = json['name'];
    email = json['email'];
    image = json['image'];
    userId = json['user_id'].toString();
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['review'] = review;
    data['rating'] = rating;
    data['name'] = name;
    data['email'] = email;
    data['image'] = image;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    return data;
  }
}
