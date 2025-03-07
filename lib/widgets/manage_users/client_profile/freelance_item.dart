import 'package:b2b_partnership_admin/controller/manage_users/client_profile_controller.dart';
import 'package:b2b_partnership_admin/models/service_request_model.dart';

import '/app_routes.dart';
import '/core/constants/app_constants.dart';
import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FreelanceItem extends StatelessWidget {
  const FreelanceItem({super.key, required this.services});
  final List<ServiceRequestModel> services;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientProfileController>(
        init: ClientProfileController(),
        builder: (controller) {
          return ListView.separated(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.only(bottom: 20, left: 20, right: 20, top: 5),
            itemCount: services.length,
            separatorBuilder: (context, index) => Gap(20),
            itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.serviceRequestDetails,
                      arguments: {"model": services[index]});
                },
                child: Container(
                  // height: services[index].image == null ? 150.h : 250.h,
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withAlpha(40),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                        top: BorderSide(
                            width: 0.5, color: Colors.grey.withAlpha(80))),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.r),
                            child: CachedNetworkImage(
                              imageUrl: services[index].clientImage!,
                              height: 40.h,
                              width: 40.h,
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) =>
                                  CircleAvatar(
                                child: Icon(CupertinoIcons.person),
                              ),
                            ),
                          ),
                          Gap(10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(services[index].name!,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15.sp,
                                  )),
                              Text(services[index].createdAt!,
                                  style: TextStyle(
                                    color: Colors.green,
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 10.sp,
                                  )),
                            ],
                          )
                        ],
                      ),
                      Divider(
                          // color: Colors.black,
                          ),
                      Gap(5),
                      Row(
                        children: [
                          Gap(10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  services[index].description!,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Gap(5),
                                Row(
                                  children: [
                                    Text(
                                      translateDatabase(
                                          arabic: services[index]
                                              .specializationNameAr!,
                                          english: services[index]
                                              .specializationNameEn!),
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: greyColor,
                                          fontWeight: FontWeight.w500),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                    Spacer(),
                                    SizedBox(
                                      width: 100,
                                      height: 25.h,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  WidgetStatePropertyAll(
                                                      Colors.green),
                                              padding: WidgetStatePropertyAll(
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10)),
                                              shape: WidgetStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10)),
                                              ))),
                                          onPressed: () {
                                            controller.deleteServiceDialog(
                                                services[index].id!);
                                          },
                                          child: Text(
                                            "Remove",
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    ),
                                    Gap(5),
                                    SizedBox(
                                      width: 120,
                                      height: 25.h,
                                      child: ElevatedButton(
                                          style: ButtonStyle(
                                              padding: WidgetStatePropertyAll(
                                                  EdgeInsets.symmetric(
                                                      horizontal: 10)),
                                              shape: WidgetStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                    topRight:
                                                        Radius.circular(10),
                                                    topLeft:
                                                        Radius.circular(10)),
                                              ))),
                                          onPressed: () {
                                            Get.toNamed(
                                                AppRoutes.serviceRequestDetails,
                                                arguments: {
                                                  "model": services[index]
                                                });
                                          },
                                          child: Text(
                                            "Show Service",
                                            style: TextStyle(
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Gap(10),
                      if (services[index].image != null)
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10)),
                          child: CachedNetworkImage(
                            imageUrl: "$kBaseImageUrl${services[index].image}",
                            height: 100.h,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorWidget: (context, url, error) =>
                                Text("${services[index].image}"),
                          ),
                        ),
                    ],
                  ),
                )),
          );
        });
  }
}
