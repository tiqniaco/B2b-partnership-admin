import 'package:b2b_partnership_admin/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partnership_admin/widgets/request_services/price_offer_widget.dart';

import '/controller/request_services/service_request_details_controller.dart';
import '/core/constants/app_constants.dart';
import '/core/functions/translate_database.dart';

import '/core/theme/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ServiceRequestDetails extends StatelessWidget {
  const ServiceRequestDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ServiceRequestDetailsController());
    return Scaffold(
      body: GetBuilder<ServiceRequestDetailsController>(
        builder: (controller) => SingleChildScrollView(
          controller: controller.scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  if (controller.model.image != null) ...[
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40.r),
                          topRight: Radius.circular(40.r)),
                      child: CachedNetworkImage(
                        imageUrl: "$kBaseImageUrl${controller.model.image}",
                        height: 160.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                  SizedBox.shrink(),
                  Positioned(
                      top: 30.h,
                      left: 10.h,
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: CircleAvatar(
                            radius: 20.r,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.arrow_back_ios,
                              ),
                            )),
                      )),
                ],
              ),
              if (controller.model.image == null) Gap(50),
              Gap(15),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          if (controller.model.image == null)
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 20.sp,
                              ),
                            ),
                          Gap(10),
                          Text(
                            controller.model.titleEn!,
                            style: TextStyle(
                                fontSize: 17.sp, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Gap(10),
                      Text(
                        controller.model.description!,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                      Gap(15),
                      Row(
                        children: [
                          Text(
                              translateDatabase(
                                  arabic:
                                      controller.model.specializationNameAr!,
                                  english:
                                      controller.model.specializationNameEn!),
                              style:
                                  TextStyle(fontSize: 13.sp, color: greyColor)),
                          Gap(10),
                          Icon(
                            Icons.remove,
                            size: 15.sp,
                            color: greyColor,
                          ),
                          Gap(10),
                          Text(
                              translateDatabase(
                                  arabic:
                                      controller.model.subSpecializationNameAr!,
                                  english: controller
                                      .model.subSpecializationNameEn!),
                              style:
                                  TextStyle(fontSize: 13.sp, color: greyColor)),
                        ],
                      ),
                      Gap(10),
                      Center(
                        child: Card(
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: controller.model.countryFlag!,
                                  height: 20.h,
                                ),
                                Gap(10),
                                Text(
                                    translateDatabase(
                                        arabic: controller.model.countryNameAr!,
                                        english:
                                            controller.model.countryNameEn!),
                                    style: TextStyle(fontSize: 13.sp)),
                                Gap(15),
                                Icon(
                                  Icons.remove,
                                  size: 15.sp,
                                ),
                                Gap(15),
                                Text(
                                    translateDatabase(
                                        arabic:
                                            controller.model.governmentNameAr!,
                                        english:
                                            controller.model.governmentNameEn!),
                                    style: TextStyle(fontSize: 13.sp)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Gap(20),
                      // Get.find<AppPreferences>().getUserRole() == "client"
                      //     ?
                      Column(
                        children: [
                          Text(
                            "Price Offers",
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Divider(),
                          CustomServerStatusWidget(
                            statusRequest: controller.statusRequest,
                            child: ListView.separated(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    PriceOfferWidget(
                                      model: controller.priceOffers[index],
                                    ),
                                separatorBuilder: (context, index) => Gap(15),
                                itemCount: controller.priceOffers.length),
                          )
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
