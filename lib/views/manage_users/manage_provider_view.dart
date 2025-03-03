import 'package:b2b_partnership_admin/controller/manage_users/manage_providers_controller.dart';
import 'package:b2b_partnership_admin/widgets/manage_users/provider_widget.dart';

import '/core/global/widgets/custom_server_status_widget.dart';
import '/core/theme/app_color.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ManageProviderView extends StatefulWidget {
  const ManageProviderView({super.key});

  @override
  State<ManageProviderView> createState() => _ManageProviderViewState();
}

class _ManageProviderViewState extends State<ManageProviderView>
    with TickerProviderStateMixin {
  final controller = Get.put(ManageProviderController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageProviderController>(
      builder: (ManageProviderController controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: whiteColor,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Manage",
                  style: TextStyle(fontSize: 15.sp, color: greyColor),
                ),
                Gap(5.w),
                Text(
                  "Provider",
                  style: TextStyle(fontSize: 15.sp),
                ),
              ],
            ),
          ),
          body: ListView(
            children: [
              Gap(15),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(
                  thickness: 3,
                ),
              ),
              Gap(18),
              CustomServerStatusWidget(
                statusRequest: controller.statusRequest,
                child: ProviderWidget(
                  providers: controller.providers,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
