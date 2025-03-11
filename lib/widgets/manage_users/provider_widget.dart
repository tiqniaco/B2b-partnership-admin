import 'package:b2b_partnership_admin/app_routes.dart';
import 'package:b2b_partnership_admin/controller/manage_users/manage_providers_controller.dart';
import 'package:b2b_partnership_admin/models/provider_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';

import '/core/theme/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProviderWidget extends StatelessWidget {
  ProviderWidget({super.key, required this.providers});
  final List<ProviderModel> providers;

  final controller = Get.put(ManageProviderController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageProviderController>(
        builder: (controller) => GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.vertical,
            itemCount: providers.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 15,
              crossAxisSpacing: 10,
              mainAxisExtent: 90,
            ),
            itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.providerProfile,
                        arguments: {"id": providers[index].providerId});
                  },
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: pageColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(12),
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
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CachedNetworkImage(
                                  imageUrl: providers[index].image!,
                                  height: 40.h,
                                  width: 40.h,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Icon(CupertinoIcons.person),
                                  ),
                                ),
                              ),
                            ),
                            Gap(10.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    providers[index].name!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w400),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  PannableRatingBar(
                                    rate:
                                        double.parse(providers[index].rating!),
                                    items: List.generate(
                                        5,
                                        (index) => RatingWidget(
                                              selectedColor: Colors.amber,
                                              unSelectedColor: Colors.grey,
                                              child: Icon(
                                                Icons.star,
                                                size: 15.sp,
                                              ),
                                            )),
                                    onHover: (value) {},
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                                onTap: () {
                                  Get.defaultDialog(
                                    titlePadding:
                                        EdgeInsets.symmetric(vertical: 10),
                                    title: "Delete Provider".tr,
                                    contentPadding:
                                        EdgeInsets.only(bottom: 15.h),
                                    content: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Text(
                                        "Are you sure to delete?".tr,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontSize: 16.sp),
                                      ),
                                    ),
                                    onConfirm: () => controller.deleteProvider(
                                        providers[index].providerId!),
                                    textConfirm: "Yes".tr,
                                    textCancel: "No".tr,
                                    onCancel: () {},
                                  );
                                },
                                child: Icon(Icons.remove_circle,
                                    color: primaryColor, size: 25.sp)),
                            Gap(5)
                          ],
                        ),
                      ],
                    ),
                  ),
                )));
  }
}
