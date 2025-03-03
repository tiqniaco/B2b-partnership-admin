import 'package:b2b_partnership_admin/controller/manage_users/manage_clients_controller.dart';

import 'package:b2b_partnership_admin/widgets/manage_users/client_widget.dart';

import '/core/global/widgets/custom_server_status_widget.dart';
import '/core/theme/app_color.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ManageClientsView extends StatefulWidget {
  const ManageClientsView({super.key});

  @override
  State<ManageClientsView> createState() => _ManageClientsViewState();
}

class _ManageClientsViewState extends State<ManageClientsView>
    with TickerProviderStateMixin {
  final controller = Get.put(ManageClientsController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageClientsController>(
      builder: (ManageClientsController controller) {
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
                  "Clients",
                  style: TextStyle(fontSize: 15.sp),
                ),
              ],
            ),
          ),
          body: ListView(
            children: [
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(
                  thickness: 3,
                ),
              ),
              Gap(18),
              CustomServerStatusWidget(
                statusRequest: controller.statusRequest,
                child: ClientWidget(
                  clients: controller.clients,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
