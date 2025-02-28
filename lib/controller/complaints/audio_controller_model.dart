import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import '/controller/complaints/complaints_controller.dart';
import 'package:get/get.dart';

class AudioControllerModel {
  final String url;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration? position;
  Duration? duration;
  PlayerState playerState = PlayerState.stopped;

  StreamSubscription? durationSubscription;
  StreamSubscription? positionSubscription;
  StreamSubscription? playerCompleteSubscription;
  StreamSubscription? playerStateChangeSubscription;

  AudioControllerModel({
    required this.url,
  }) {
    _init();
  }

  void _init() {
    durationSubscription = audioPlayer.onDurationChanged.listen((duration) {
      this.duration = duration;
      Get.put(ComplaintsController()).update(['voice']);
    });

    positionSubscription = audioPlayer.onPositionChanged.listen(
      (p) {
        position = p;
        Get.put(ComplaintsController()).update(['voice']);
      },
    );

    playerCompleteSubscription = audioPlayer.onPlayerComplete.listen((event) {
      playerState = PlayerState.stopped;
      position = Duration.zero;
      Get.put(ComplaintsController()).update(['voice']);
    });

    playerStateChangeSubscription =
        audioPlayer.onPlayerStateChanged.listen((state) {
      playerState = state;
      Get.put(ComplaintsController()).update(['voice']);
    });
  }

  void dispose() {
    audioPlayer.dispose();
    durationSubscription?.cancel();
    positionSubscription?.cancel();
    playerCompleteSubscription?.cancel();
    playerStateChangeSubscription?.cancel();
  }

  void play() {
    final controller = Get.find<ComplaintsController>();
    for (final message in controller.complaints) {
      if (message.contentType == 'audio' && message.content != url) {
        message.audioPlayer?.audioPlayer.pause();
      }
    }

    if (!isPlaying) {
      audioPlayer.play(UrlSource(url));
      audioPlayer.resume();
    } else {
      audioPlayer.pause();
    }
    Get.put(ComplaintsController()).update(['voice']);
  }

  String get durationText => duration?.toString().split('.').first ?? '';

  String get positionText => position?.toString().split('.').first ?? '';
  bool get isPlaying => playerState == PlayerState.playing;

  bool get isPaused => playerState == PlayerState.paused;
}
