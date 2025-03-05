import '/controller/complaints/complaints_controller.dart';
import '/core/global/widgets/custom_server_status_widget.dart';
import '/core/theme/app_color.dart';
import '/widgets/complaints/complaints_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ComplaintsView extends StatelessWidget {
  const ComplaintsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ComplaintsController>(
      init: ComplaintsController(),
      builder: (ComplaintsController controller) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 17.sp,
                  backgroundColor: redColor.withAlpha(30),
                  child: Icon(
                    Icons.headset_mic_outlined,
                    color: redColor,
                    size: 16.sp,
                  ),
                ),
                Gap(10.w),
                Text("Complaints".tr),
              ],
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 10.h,
            ),
            child: Column(
              children: [
                Expanded(
                  child: CustomServerStatusWidget(
                    statusRequest: controller.statusRequest,
                    child: CustomScrollView(
                      reverse: true,
                      slivers: [
                        SliverList.separated(
                          itemBuilder: (context, index) =>
                              ComplaintsMessageWidget(
                            model: controller.complaints[index],
                          ),
                          separatorBuilder: (context, index) => Gap(10.h),
                          itemCount: controller.complaints.length,
                        ),
                      ],
                    ),
                  ),
                ),
                Gap(24.h),

                // Padding(
                //   padding: EdgeInsets.symmetric(
                //     horizontal: 10.w,
                //     vertical: 10.h,
                //   ),
                //   child: Row(
                //     children: [
                //       AvatarGlow(
                //         animate: controller.isRecording,
                //         glowColor: primaryColor,
                //         child: Container(
                //           width: 40.w,
                //           height: 40.w,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(50.r),
                //             color: primaryColor,
                //           ),
                //           child: FloatingActionButton(
                //             onPressed: () {
                //               if (!controller.isRecording) {
                //                 controller.record();
                //               } else {
                //                 controller.stopRecord();
                //               }
                //             },
                //             child: Icon(
                //               controller.isRecording
                //                   ? FontAwesomeIcons.stop
                //                   : FontAwesomeIcons.microphone,
                //               color: whiteColor,
                //               size: 18.w,
                //             ),
                //           ),
                //         ),
                //       ),
                //       Gap(10.w),
                //       Expanded(
                //         child: TextFormField(
                //           controller: controller.complaintController,
                //           decoration: InputDecoration(
                //             hintText: "Enter your complaints...".tr,
                //             hintStyle: getLightStyle.copyWith(
                //               color: greyColor,
                //             ),
                //             filled: true,
                //             fillColor: Colors.white,
                //           ),
                //         ),
                //       ),
                //       // Gap(10.w),
                //       IconButton(
                //         onPressed: () {
                //           controller.sendComplaint();
                //         },
                //         icon: Icon(
                //           FontAwesomeIcons.paperPlane,
                //           color: primaryColor,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
