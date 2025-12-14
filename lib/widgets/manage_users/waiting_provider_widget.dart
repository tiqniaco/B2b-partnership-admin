import 'package:b2b_partnership_admin/app_routes.dart';
import 'package:b2b_partnership_admin/controller/manage_users/waiting_providers_controller.dart';
import 'package:b2b_partnership_admin/core/enums/status_request.dart';
import 'package:b2b_partnership_admin/core/functions/translate_database.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_server_status_widget.dart';
import 'package:flutter/cupertino.dart';

import '/core/theme/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class WaitingProviderWidget extends StatelessWidget {
  WaitingProviderWidget({
    super.key,
  });
  //final List<ProviderModel> controller.providers;

  final controller = Get.put(WaitingProvidersController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WaitingProvidersController>(
        builder: (controller) => CustomServerStatusWidget(
              statusRequest: controller.statusRequest,
              child: GridView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  scrollDirection: Axis.vertical,
                  itemCount: controller.providers.length +
                      (controller.isLoading &&
                              controller.statusRequest != StatusRequest.loading
                          ? 1
                          : 0) +
                      (controller.isLastPage &&
                              controller.statusRequest != StatusRequest.noData
                          ? 1
                          : 0),
                  controller: controller.scrollController,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 120,
                  ),
                  itemBuilder: (context, index) {
                    // Show loading indicator at the bottom
                    if (controller.isLoading &&
                        controller.statusRequest != StatusRequest.loading &&
                        index == controller.providers.length) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    // Show "No more Providers" message at the bottom
                    if (controller.isLastPage &&
                        controller.statusRequest != StatusRequest.noData &&
                        index ==
                            controller.providers.length +
                                (controller.isLoading &&
                                        controller.statusRequest !=
                                            StatusRequest.loading
                                    ? 1
                                    : 0)) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            'No more Providers'.tr,
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                    // Show provider item
                    return InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.providerProfile, arguments: {
                          "id": controller.providers[index].userId, 
                          "page": "waiting"
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: pageColor.withAlpha(70),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: borderColor),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          controller.providers[index].image,
                                      height: 68.h,
                                      width: 65.h,
                                      fit: BoxFit.cover,
                                      errorWidget: (context, url, error) =>
                                          Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Icon(CupertinoIcons.person),
                                      ),
                                    ),
                                  ),
                                ),
                                Gap(10.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller.providers[index].name,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w400),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "${translateDatabase(arabic: controller.providers[index].governmentNameAr, english: controller.providers[index].governmentNameEn)}, ${translateDatabase(arabic: controller.providers[index].countryNameAr, english: controller.providers[index].countryNameEn)}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 12.sp,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.w400),
                                      ),
                                      Gap(5.h),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 80.w,
                                            height: 27.h,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                  primaryColor,
                                                ),
                                                padding: WidgetStatePropertyAll(
                                                  EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                                ),
                                                shape: WidgetStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      5,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                controller.deleteProviderDialog(
                                                    controller.providers[index]
                                                        .providerId);
                                              },
                                              child: Text(
                                                "Reject".tr,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11.sp),
                                              ),
                                            ),
                                          ),
                                          Gap(10),
                                          SizedBox(
                                            width: 80.w,
                                            height: 27.h,
                                            child: ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                  Colors.green,
                                                ),
                                                padding: WidgetStatePropertyAll(
                                                  EdgeInsets.symmetric(
                                                    horizontal: 10,
                                                  ),
                                                ),
                                                shape: WidgetStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      5,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {
                                                print(controller
                                                    .providers[index]
                                                    .providerId);
                                                // controller.acceptProvider(
                                                //     controller.providers[index]
                                                //         .providerId);
                                              },
                                              child: Text(
                                                "Accept".tr,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 11.sp),
                                              ),
                                            ),
                                          ),
                                          // InkWell(
                                          //     onTap: () {
                                          //       controller
                                          //           .deleteProviderDialog(
                                          //               controller
                                          //                   .providers[index]
                                          //                   .providerId!);
                                          //     },
                                          //     child: Icon(Icons.remove_circle,
                                          //         color: primaryColor,
                                          //         size: 25.sp)),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Gap(5)
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ));
  }
}
