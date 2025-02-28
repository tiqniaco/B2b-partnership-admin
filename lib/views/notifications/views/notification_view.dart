import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/core/global/widgets/custom_server_status_widget.dart';

import '../controllers/notify_controller.dart';
import '../notification_widget.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(NotifyController());
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text("Notifications".tr),
      ),
      body: GetBuilder<NotifyController>(
        builder: (controller) => SafeArea(
          bottom: false,
          child: RefreshIndicator(
            onRefresh: () {
              return controller.getNotifications();
            },
            child: CustomServerStatusWidget(
              statusRequest: controller.statusRequest,
              child:
                  // controller.items.isEmpty?
                  // const CustomEmptyWidget()
                  //:
                  ListView.separated(
                padding: EdgeInsets.symmetric(
                  horizontal: context.isTablet ? 8.w : 16.w,
                ),
                separatorBuilder: (context, index) => Gap(10.h),
                itemCount: controller.notifications.length,
                itemBuilder: (context, index) => NotificationWidget(
                  model: controller.notifications[index],
                  onTap: () {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
