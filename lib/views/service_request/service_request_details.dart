import 'package:b2b_partnership_admin/core/functions/get_text_direction.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/widgets/request_services/price_offer_widget.dart';

import '/controller/request_services/service_request_details_controller.dart';
import '/core/constants/app_constants.dart';
import '/core/functions/translate_database.dart';

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
        builder: (controller) => ListView(
          controller: controller.scrollController,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    if (controller.model.image != null) ...[
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.r),
                            topRight: Radius.circular(30.r)),
                        child: CachedNetworkImage(
                          imageUrl: "$kBaseImageUrl${controller.model.image}",
                          height: 160.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorWidget: (context, url, error) => Center(
                            child: Text(
                              "No Image",
                            ),
                          ),
                        ),
                      ),
                    ],
                    SizedBox.shrink(),
                    Positioned(
                        top: 12.h,
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: InkWell(
                                onTap: () {
                                  Get.back();
                                },
                                child: CircleAvatar(
                                    radius: 18.r,
                                    child: Center(
                                      child: Icon(
                                        Icons.arrow_back_ios_new_rounded,
                                        size: 20.r,
                                        color: whiteColor,
                                      ),
                                    )),
                              ),
                            ),
                          ],
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
                              textDirection:
                                  containsArabic(controller.model.titleEn!)
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                              style: TextStyle(
                                  fontSize: 17.r, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Gap(10),
                        Text(
                          controller.model.description!,
                          textDirection:
                              containsArabic(controller.model.description!)
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                          style: TextStyle(fontSize: 16.r),
                        ),
                        Gap(16),
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
                                  Text(controller.model.countryFlag!),
                                  Gap(10),
                                  Text(
                                      translateDatabase(
                                          arabic:
                                              controller.model.countryNameAr!,
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
                                          arabic: controller
                                              .model.governmentNameAr!,
                                          english: controller
                                              .model.governmentNameEn!),
                                      style: TextStyle(fontSize: 13.sp)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Gap(20),
                        Column(
                          children: [
                            Text(
                              "Price Offers".tr,
                              style: TextStyle(
                                fontSize: 15.r,
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
          ],
        ),
      ),
    );
  }
}
