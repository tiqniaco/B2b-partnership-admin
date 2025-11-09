import 'package:b2b_partnership_admin/controller/manage_users/client_profile_controller.dart';
import 'package:b2b_partnership_admin/widgets/manage_users/client_profile/about_client_widget.dart';
import 'package:b2b_partnership_admin/widgets/manage_users/client_profile/freelance_item.dart';
import 'package:b2b_partnership_admin/widgets/manage_users/client_profile/job_list_client_widget.dart';

import '/core/theme/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ClientProfileView extends StatelessWidget {
  const ClientProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ClientProfileController());
    return GetBuilder<ClientProfileController>(
      builder: (controller) {
        return Scaffold(
            body: SafeArea(
                child: Center(
          child: controller.clientModel == null
              ? CircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20),
                    _buildHeader(controller),
                    Gap(25),
                    _buildTabs(controller),
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        onPageChanged: controller.onPageChanged,
                        children: [
                          AboutClientWidget(),
                          JobListClientWidget(),
                          FreelanceItem(services: controller.posts),
                        ],
                      ),
                    ),
                  ],
                ),
        )));
      },
    );
  }

  Widget _buildHeader(ClientProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios, size: 23.sp, color: greyColor)),
          CircleAvatar(
            radius: 25.r,
            backgroundColor: Colors.grey[200],
            backgroundImage:
                CachedNetworkImageProvider(controller.clientModel!.image!),
          ),
          Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.clientModel!.name!,
                  style:
                      TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(ClientProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTab("About".tr, 0, controller),
          _buildTab("Jobs".tr, 1, controller),
          _buildTab("Posts".tr, 2, controller),
        ],
      ),
    );
  }

  Widget _buildTab(
      String title, int index, ClientProfileController controller) {
    return GestureDetector(
      onTap: () => controller.onTabTapped(index),
      child: Container(
        padding: EdgeInsets.only(left: 5, bottom: 10, right: 5),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 2,
                    color: controller.selectedIndex == index
                        ? primaryColor
                        : whiteColor))),
        child: Text(
          title.tr,
          style: TextStyle(
            fontSize: 14.sp,
            color:
                controller.selectedIndex == index ? primaryColor : blackColor,
          ),
        ),
      ),
    );
  }
}
