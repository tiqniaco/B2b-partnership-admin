import 'package:b2b_partnership_admin/controller/manage_users/provider_profile/provider_profile_controller.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partnership_admin/models/service_request_model.dart';
import 'package:b2b_partnership_admin/widgets/manage_users/post_item.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FreelanceProviderItem extends StatelessWidget {
  const FreelanceProviderItem({super.key, required this.services});
  final List<ServiceRequestModel> services;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProviderProfileController>(
        init: ProviderProfileController(),
        builder: (controller) {
          return CustomServerStatusWidget(
            statusRequest: controller.statusRequestPosts,
            child: ListView.separated(
                scrollDirection: Axis.vertical,
                padding:
                    EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 5),
                itemCount: services.length,
                separatorBuilder: (context, index) => Gap(20),
                itemBuilder: (context, index) => PostItem(
                      service: services[index],
                      onPressed: () {
                        controller.deleteServiceDialog(services[index].id!);
                      },
                    )),
          );
        });
  }
}
