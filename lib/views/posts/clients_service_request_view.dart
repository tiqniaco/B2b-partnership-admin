import 'package:b2b_partnership_admin/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/widgets/provider/posts/select_city_post.dart';
import 'package:b2b_partnership_admin/widgets/provider/posts/select_country_post.dart';
import 'package:b2b_partnership_admin/widgets/provider/posts/select_specialization_post.dart';
import 'package:b2b_partnership_admin/widgets/provider/posts/select_sup_specialization_post.dart';
import 'package:b2b_partnership_admin/widgets/request_services/provider_freelance_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../controller/provider/posts/get_provider_posts_service_controller.dart';

class ClientsServiceRequestView extends StatelessWidget {
  ClientsServiceRequestView({super.key});
  final controller = Get.put(GetProviderPostsServiceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<GetProviderPostsServiceController>(
          builder: (controller) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 16.sp,
                        color: blackColor,
                      ),
                    ),
                    Text(
                      "FILTERS".tr,
                      style: TextStyle(
                        color: blackColor,
                        letterSpacing: 4,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                  ],
                ),
                Gap(3),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      filterWidget(() {
                        showCategorySheet(context);
                      }, "Category".tr, Icons.category_outlined),
                      Gap(10),
                      filterWidget(() {
                        showLocationSheet(context);
                      }, "Location".tr, Icons.location_on_outlined),
                      Gap(10),
                      filterWidget(() {
                        controller.resetFunction();
                      }, "Reset".tr, Icons.refresh_outlined),
                    ],
                  ),
                ),
                Gap(15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text("${controller.services.length}",
                          style: TextStyle(
                              color: blackColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp)),
                      Gap(10),
                      Text("Freelance Service".tr,
                          style: TextStyle(
                              color: blackColor,
                              // fontWeight: FontWeight.w500,
                              fontSize: 15.sp)),
                    ],
                  ),
                ),
                Gap(5),
                Expanded(
                    child: CustomServerStatusWidget(
                  statusRequest: controller.statusRequest,
                  child: ListView.separated(
                    controller: controller.scrollController,
                    separatorBuilder: (context, index) => Gap(25),
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    itemCount: controller.services.length,
                    itemBuilder: (context, index) => ProviderFreelanceItem(
                      model: controller.services[index],
                    ),
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget filterWidget(Function() onTap, String title, IconData icon) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Material(
          color: thirdColor.withAlpha(30),
          borderRadius: BorderRadius.circular(5),
          // elevation: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 16.sp, color: thirdColor),
                Gap(8),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buttonWidget(String title, Function() onTap, bool active) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
        decoration: BoxDecoration(
            color: active ? primaryColor : Colors.transparent,
            border: Border.all(color: greyColor),
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 13.sp,
              color: active ? whiteColor : blackColor),
        ),
      ),
    );
  }

  showLocationSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => GetBuilder<GetProviderPostsServiceController>(
            id: "location",
            builder: (locationController) {
              return Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: borderColor, width: 1),
                    color: borderColor.withAlpha(20),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 40,
                        child: Divider(
                          thickness: 4,
                          color: greyColor,
                        ),
                      ),
                    ),
                    Gap(6),
                    Text(
                      "Location Filter:",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w500),
                    ),
                    Gap(30),
                    SelectCountryPost(
                      enabled: false,
                    ),
                    Gap(30),
                    SelectCityPost(),
                    Gap(30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: buttonWidget("Clear Filter", () {
                              locationController.resetLocation();
                            }, false),
                          ),
                          Gap(20),
                          Expanded(
                            child: buttonWidget("Apply Filter", () {
                              locationController.getServices(refresh: true);
                            }, true),
                          )
                        ],
                      ),
                    ),
                    Gap(50)
                  ],
                ),
              );
            }));
  }

  showCategorySheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => GetBuilder<GetProviderPostsServiceController>(
            id: "category",
            builder: (categoryController) {
              return Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: borderColor, width: 1),
                    color: borderColor.withAlpha(20),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 40,
                        child: Divider(
                          thickness: 4,
                          color: greyColor,
                        ),
                      ),
                    ),
                    Gap(6),
                    Text(
                      "Category Filter:",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w500),
                    ),
                    Gap(30),
                    SelectSpecializationPost(),
                    Gap(30),
                    SelectSupSpecializationPost(),
                    Gap(30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: buttonWidget("Clear Filter", () {
                              categoryController.resetCategory();
                            }, false),
                          ),
                          Gap(20),
                          Expanded(
                            child: buttonWidget("Apply Filter", () {
                              categoryController.getServices(refresh: true);
                            }, true),
                          )
                        ],
                      ),
                    ),
                    Gap(50)
                  ],
                ),
              );
            }));
  }
}
