import 'package:b2b_partnership_admin/controller/manage_users/client_profile_controller.dart';

import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AboutClientWidget extends StatelessWidget {
  const AboutClientWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ClientProfileController());
    return GetBuilder<ClientProfileController>(builder: (controller) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              Gap(10),
              titleWidget(
                "Name",
                controller.clientModel!.name!,
              ),
              Gap(15),
              titleWidget(
                "Phone",
                '+${controller.clientModel!.countryCode!}${controller.clientModel!.phone!}',
              ),
              Gap(15),
              titleWidget(
                "Email",
                controller.clientModel!.email!,
              ),
              Gap(15),
              titleWidget(
                "From",
                "${translateDatabase(arabic: controller.clientModel!.countryNameAr!, english: controller.clientModel!.countryNameEn!)}",
              ),
              Gap(15),
              titleWidget(
                "City",
                "${translateDatabase(arabic: controller.clientModel!.governmentNameAr!, english: controller.clientModel!.governmentNameEn!)}",
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget titleWidget(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Row(
            children: [
              Gap(10),
              Text(
                "$title: ",
                style: TextStyle(
                    fontSize: 13.sp,
                    color: blackColor,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        //Gap(10.w),
        Expanded(
          flex: 4,
          child: Row(
            children: [
              Gap(30.w),
              Text(
                value,
                style: TextStyle(fontSize: 13.sp, color: Colors.black54),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        )
      ],
    );
  }
}
