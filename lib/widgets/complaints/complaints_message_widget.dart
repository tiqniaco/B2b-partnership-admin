import '/controller/complaints/complaints_controller.dart';
import '/core/services/date_time_convertor.dart';
import '/models/complaint_model.dart';
import 'package:get/get.dart';

import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ComplaintsMessageWidget extends StatelessWidget {
  const ComplaintsMessageWidget({
    super.key,
    required this.model,
  });

  final ComplaintModel model;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Material(
            color: Colors.transparent,
            clipBehavior: Clip.antiAlias,
            shape: const BeveledRectangleBorder(
              borderRadius: BorderRadiusDirectional.only(
                bottomEnd: Radius.circular(300.0),
              ),
            ),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  // top: Radius.circular(50.0),
                  bottom: Radius.circular(5.0),
                ),
                color: primaryColor,
              ),
              margin: EdgeInsetsDirectional.only(
                start: 15.0.w,
              ),
              height: 40.0.h,
              width: 30.0.w,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: primaryColor,
            ),
            margin: const EdgeInsets.only(
              bottom: 20.0,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 12.0.w,
              vertical: 18.0.h,
            ),
            child: Column(
              children: [
                switch (model.contentType) {
                  'voice' => buildAudioPlayer(),
                  'text' => Text(
                      model.content,
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  String() => Container(),
                },
                Gap(5.h),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    DateTimeConvertor.timeAgo(
                      model.createdAt,
                    ),
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 10.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAudioPlayer() {
    return GetBuilder<ComplaintsController>(
        id: 'voice',
        builder: (ComplaintsController ctrl) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: whiteColor,
            ),
            height: 0.1.sh,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    Expanded(
                      child: Slider(
                        activeColor: primaryColor,
                        inactiveColor: Colors.grey,
                        onChanged: (value) {
                          final duration = model.audioPlayer?.duration;
                          if (duration == null) {
                            return;
                          }
                          final position = value * duration.inMilliseconds;
                          model.audioPlayer?.audioPlayer
                              .seek(Duration(milliseconds: position.round()));
                        },
                        value: (model.audioPlayer?.position != null &&
                                model.audioPlayer?.duration != null &&
                                model.audioPlayer!.position!.inMilliseconds >
                                    0 &&
                                model.audioPlayer!.position!.inMilliseconds <
                                    model.audioPlayer!.duration!.inMilliseconds)
                            ? model.audioPlayer!.position!.inMilliseconds /
                                model.audioPlayer!.duration!.inMilliseconds
                            : 0.0,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        model.audioPlayer!.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        model.audioPlayer?.play();
                      },
                    ),
                  ],
                ),
                Text(
                  model.audioPlayer?.position != null
                      ? '${model.audioPlayer?.positionText ?? '00:00:00'} / ${model.audioPlayer?.durationText ?? '00:00:00'}'
                      : model.audioPlayer?.duration != null
                          ? model.audioPlayer!.durationText
                          : '00:00:00 / 00:00:00',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: blackColor,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
