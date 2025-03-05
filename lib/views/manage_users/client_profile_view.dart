import 'package:b2b_partnership_admin/widgets/manage_users/provider_profile/job_list_widget.dart';

import '../../../controller/manage_users/provider_profile/provider_profile_controller.dart';
import '/core/theme/app_color.dart';
import '/widgets/in_category/service_widget_vertical.dart';
import '../../../widgets/manage_users/provider_profile/about_widget.dart';
import '../../../widgets/manage_users/provider_profile/previous_work_widget.dart';
import '../../../widgets/manage_users/provider_profile/review_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ClientProfileView extends StatelessWidget {
  const ClientProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProviderProfileController());
    return GetBuilder<ProviderProfileController>(
      builder: (controller) {
        return Scaffold(
            body: SafeArea(
                child: Center(
          child: controller.providerModel == null
              ? CircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20),
                    _buildHeader(controller),
                    Gap(15),
                    _buildTabs(controller),
                    Expanded(
                      child: PageView(
                        controller: controller.pageController,
                        onPageChanged: controller.onPageChanged,
                        children: [
                          ServiceWidgetVertical(
                              services: controller.providerServices),
                          AboutWidget(),
                          PreviousWork(),
                          JobListWidget(),
                          ReviewWidget(),
                        ],
                      ),
                    ),
                  ],
                ),
        )));
      },
    );
  }

  Widget _buildHeader(ProviderProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () => Get.back(),
              icon: Icon(Icons.arrow_back_ios, size: 23.sp, color: greyColor)),
          CircleAvatar(
            radius: 33.r,
            backgroundColor: Colors.grey[200],
            backgroundImage:
                CachedNetworkImageProvider(controller.providerModel!.image!),
          ),
          Gap(10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.providerModel!.name!,
                  style:
                      TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Text(controller.providerModel!.rating!,
                      style: TextStyle(
                          color: greyColor,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold)),
                  Gap(5),
                  Icon(Icons.circle, size: 4.sp, color: greyColor),
                  Gap(5),
                  RatingBar.builder(
                    ignoreGestures: true,
                    itemSize: 17.sp,
                    initialRating: 3,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    itemBuilder: (context, _) =>
                        Icon(Icons.star, color: Colors.amber),
                    onRatingUpdate: (rating) {},
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTabs(ProviderProfileController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildTab("Services", 0, controller),
          _buildTab("About", 1, controller),
          _buildTab("Previous work", 2, controller),
          _buildTab("Jobs", 3, controller),
          _buildTab("Reviews", 4, controller),
        ],
      ),
    );
  }

  Widget _buildTab(
      String title, int index, ProviderProfileController controller) {
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
