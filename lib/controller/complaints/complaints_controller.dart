import 'dart:developer';
import 'dart:io';

import '/controller/settings/setting_controller.dart';
import '/core/constants/app_constants.dart';
import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/global/widgets/custom_loading_button.dart';
import '/core/network/api_constance.dart';
import '/core/theme/app_color.dart';
import '/core/utils/app_snack_bars.dart';
import '/models/complaint_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart' as audio_players;
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import 'audio_controller_model.dart';

class ComplaintsController extends GetxController {
  final complaintController = TextEditingController();
  StatusRequest statusRequest = StatusRequest.loading;

  dynamic recorder;
  late audio_players.AudioPlayer audioPlayer;
  Duration? sliderValue;
  audio_players.PlayerState playerState = audio_players.PlayerState.stopped;
  Duration? duration;
  Duration? playerLength = Duration.zero;
  bool isPlaying = false;
  String audioPath = '';
  bool isRecording = false;
  bool isPageLoading = false;
  File? pickedFile;
  String contentType = 'text';
  List<ComplaintModel> complaints = [];

  @override
  void onInit() async {
    if (Platform.isIOS) {
      recorder = AudioRecorder();
    } else {
      recorder = FlutterSoundRecorder();
    }
    await initRecorder();
    await initPlayer();
    await getComplaints();

    super.onInit();
  }

  Future initRecorder() async {
    try {
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw 'Microphone Permission not granted';
      }

      if (recorder is FlutterSoundRecorder) {
        await recorder.openRecorder();
        recorder.setSubscriptionDuration(const Duration(seconds: 1000));
      }
    } catch (e) {
      Logger().e(e);
    }
  }

  initPlayer() async {
    playerLength = Duration.zero;
    sliderValue = Duration.zero;
    audioPlayer = audio_players.AudioPlayer();
    audioPlayer.onPositionChanged.listen((d) {
      sliderValue = d;
      log(sliderValue.toString(), name: "Value");
      update();
    });
    audioPlayer.onDurationChanged.listen((d) {
      playerLength = d;
      update();
    });
    audioPlayer.onPlayerComplete.listen((d) {
      audioPlayer.stop();
      isPlaying = false;
      update();
    });
  }

  Future<void> getComplaints({
    bool isRefresh = true,
  }) async {
    if (isRefresh) {
      statusRequest = StatusRequest.loading;
      update();
    }
    final result = await CustomRequest<List<ComplaintModel>>(
      path: ApiConstance.getComplaints,
      fromJson: (json) {
        return List<ComplaintModel>.from(
          json['data'].map(
            (x) => ComplaintModel.fromJson(x),
          ),
        );
      },
    ).sendGetRequest();

    result.fold((l) {
      statusRequest = StatusRequest.error;
      AppSnackBars.error(message: l.errMsg);
      update();
    }, (r) async {
      complaints = r;
      if (r.isEmpty) {
        statusRequest = StatusRequest.noData;
      } else {
        statusRequest = StatusRequest.success;
      }
      await initControllers();
      update();
    });
  }

  Future record() async {
    await initPlayer();
    final directory = await getApplicationDocumentsDirectory();
    audioPath = "${directory.path}/audio.wav";
    log(audioPath);
    debugPrint("**************************************************");
    debugPrint("hi start record");
    debugPrint("**************************************************");
    if (recorder is AudioRecorder) {
      // Check and request permission if needed
      if (await (recorder as AudioRecorder).hasPermission()) {
        // Start recording to file
        await (recorder as AudioRecorder).start(
          const RecordConfig(
            encoder: AudioEncoder.wav,
          ),
          path: audioPath,
        );
        isRecording = true;
        update();
      }
    } else {
      await (recorder as FlutterSoundRecorder).startRecorder(
        toFile: audioPath,
        codec: Codec.pcm16WAV,
      );
      isRecording = true;
      update();
    }

    // update();
  }

  Future<void> stopRecord() async {
    final filePath = recorder is FlutterSoundRecorder
        ? await recorder.stopRecorder()
        : await recorder.stop();
    pickedFile = File(filePath);
    log("record file path is: audioFile = ${File(filePath)}");
    // showRecord = true;
    isRecording = false;
    previewRecord();

    update();
  }

  removeRecord() {
    if (recorder is AudioRecorder) {
      (recorder as AudioRecorder).cancel();
      audioPath = "";
    } else {
      recorder.deleteRecord(fileName: audioPath);
      audioPath = "";
    }
    sliderValue = const Duration();
    playerLength = const Duration();
    audioPlayer.onPositionChanged.listen((d) {
      sliderValue = d;
      update();
    });
    audioPlayer.onDurationChanged.listen((d) {
      playerLength = d;
      update();
    });
    audioPlayer.onPlayerComplete.listen((d) {
      audioPlayer.stop();
      isPlaying = false;
      update();
    });

    isRecording = false;
    isPlaying = false;
    pickedFile = null;

    Get.back();

    update();
  }

  seekTo(int sec) {
    audioPlayer.seek(Duration(seconds: sec.toInt()));
    sliderValue = Duration(seconds: sec.toInt());
    update();
  }

  onPressedPlay() async {
    isPlaying = !isPlaying;
    update();
    if (isPlaying) {
      await audioPlayer.play(audio_players.DeviceFileSource(audioPath));
    } else {
      await audioPlayer.pause();
    }
    update();
  }

  Future<void> previewRecord() async {
    await initPlayer();
    showModalBottomSheet(
      context: Get.context!,
      builder: (context) => GetBuilder<ComplaintsController>(
          builder: (ComplaintsController controller) {
        return SizedBox(
          width: double.infinity,
          height: 0.25.sh,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(
                          255,
                          217,
                          207,
                          195,
                        ).withAlpha(80),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  removeRecord();
                                },
                                child: const Icon(
                                  Icons.close,
                                  size: 30,
                                  color: Colors.grey,
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 30,
                                  child: Slider(
                                    inactiveColor: Colors.grey[400],
                                    activeColor: primaryColor,
                                    value: sliderValue?.inSeconds.toDouble() ??
                                        0.0,
                                    min: 0.0,
                                    max: playerLength?.inSeconds.toDouble() ??
                                        0.0,
                                    onChanged: (value) {
                                      seekTo(value.toInt());
                                    },
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  onPressedPlay();
                                },
                                child: Icon(
                                  isPlaying ? Icons.pause : Icons.play_arrow,
                                  size: 40,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 50.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${twoDigits(sliderValue?.inMinutes.remainder(60) ?? 0)}:${twoDigits(sliderValue?.inSeconds.remainder(60) ?? 0)}",
                                  style: const TextStyle(fontSize: 10),
                                ),
                                Text(
                                  "${twoDigits(playerLength?.inMinutes.remainder(60) ?? 0)}:${twoDigits(playerLength?.inSeconds.remainder(60) ?? 0)}",
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomLoadingButton(
                    onPressed: () {
                      contentType = 'voice';
                      return sendComplaint();
                    },
                    text: "Send".tr,
                    width: 0.35.sw,
                    height: 0.06.sh,
                  ),
                ],
              )
            ],
          ),
        );
      }),
    );
  }

  String twoDigits(int n) => n.toString().padLeft(2, '0');

  Future<void> initControllers() async {
    for (var i = 0; i < complaints.length; i++) {
      switch (complaints[i].contentType) {
        case 'text':
          complaints[i].audioPlayer = null;
          break;
        case 'voice':
          complaints[i].audioPlayer = AudioControllerModel(
            url: kBaseImageUrl + complaints[i].content,
          );

          break;
      }
    }
  }

  Future<void> sendComplaint() async {
    final result = await CustomRequest<String>(
      path: ApiConstance.addComplaint,
      data: {
        if (contentType == 'text') "content": complaintController.text,
        "content_type": contentType,
      },
      files: {
        if (contentType == 'voice') "content": audioPath,
      },
      fromJson: (json) {
        return json['message'];
      },
    ).sendPostRequest();
    result.fold((l) {
      AppSnackBars.error(message: l.errMsg);
    }, (r) async {
      await getComplaints(isRefresh: false);
      Get.put(SettingController()).getMenuModel();
      complaintController.clear();
      if (contentType == 'voice') {
        removeRecord();
      }
    });
  }
}
