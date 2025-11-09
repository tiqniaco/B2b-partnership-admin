import 'package:b2b_partnership_admin/core/functions/get_text_direction.dart';

import '/app_routes.dart';
import '../../../controller/manage_users/provider_profile/provider_profile_controller.dart';
import '/core/global/widgets/custom_server_status_widget.dart';
import '/core/theme/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PreviousWork extends StatelessWidget {
  const PreviousWork({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProviderProfileController());
    return GetBuilder<ProviderProfileController>(
        builder: (controller) => CustomServerStatusWidget(
              statusRequest: controller.statusRequestPerviousWork,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: ListView.separated(
                  itemCount: controller.previousWork.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      Gap(14.h),
                  itemBuilder: (BuildContext context, int index) => InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.providerPreviousWork,
                          arguments: {"model": controller.previousWork[index]});
                    },
                    child: Container(
                      height: 120.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                controller.previousWork[index].image!,
                              ))),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: blackColor.withAlpha(95)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CircleAvatar(
                              backgroundColor: whiteColor.withAlpha(120),
                              child: InkWell(
                                onTap: () {
                                  controller.deletePreviousWorkDialog(
                                      controller.previousWork[index].id!);
                                },
                                child: Icon(
                                  Icons.remove_circle,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              controller.previousWork[index].titleEn!,
                              textDirection: containsArabic(
                                      controller.previousWork[index].titleEn!)
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17.r,
                                  color: whiteColor),
                            ),
                            Text(
                              controller.previousWork[index].description!,
                              textDirection: containsArabic(
                                controller.previousWork[index].description!,
                              )
                                  ? TextDirection.rtl
                                  : TextDirection.ltr,
                              style:
                                  TextStyle(fontSize: 14.r, color: whiteColor),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
  }
}
