import 'package:equatable/equatable.dart';

class NotificationModel extends Equatable {
  final String id;
  final String title;
  final String topic;
  final String message;
  final String payload;
  final String createdAt;
  final String updatedAt;

  const NotificationModel({
    required this.id,
    required this.title,
    required this.topic,
    required this.message,
    required this.payload,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json["id"] ?? 0,
        title: json["title"].toString(),
        topic: json["topic"].toString(),
        message: json["message"].toString(),
        payload: json["payload"].toString(),
        createdAt: json["created_at"].toString(),
        updatedAt: json["updated_at"].toString(),
      );

  @override
  List<Object?> get props => [
        id,
        title,
        topic,
        message,
        payload,
        createdAt,
        updatedAt,
      ];
}
