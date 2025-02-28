import '/controller/complaints/audio_controller_model.dart';
import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class ComplaintModel extends Equatable {
  final int id;
  final String userId;
  final String content;
  final String contentType;
  final String createdAt;
  final String updatedAt;
  AudioControllerModel? audioPlayer;

  ComplaintModel({
    required this.id,
    required this.userId,
    required this.content,
    required this.contentType,
    required this.createdAt,
    required this.updatedAt,
    this.audioPlayer,
  });

  factory ComplaintModel.fromJson(Map<String, dynamic> json) => ComplaintModel(
        id: json["id"],
        userId: json["user_id"],
        content: json["content"],
        contentType: json["content_type"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  @override
  List<Object?> get props => [
        id,
        userId,
        content,
        contentType,
        createdAt,
        updatedAt,
        audioPlayer,
      ];
}
