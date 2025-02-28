import '/app_routes.dart';
import '/core/constants/app_constants.dart';
import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
import '/models/service_request_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ServiceItem extends StatelessWidget {
  const ServiceItem({super.key, required this.model});
  final ServiceRequestModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.serviceRequestDetails,
            arguments: {"model": model});
      },
      child: Container(
        height: 110.h,
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withAlpha(80))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                if (model.image != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(
                      imageUrl: "$kBaseImageUrl${model.image}",
                      height: 70.h,
                      width: 75.h,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) =>
                          Text("${model.image}"),
                    ),
                  ),
                Gap(10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        model.description!,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap(10),
                      Row(
                        children: [
                          Text(
                            translateDatabase(
                                arabic: model.specializationNameAr!,
                                english: model.specializationNameEn!),
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: greyColor,
                                fontWeight: FontWeight.w500),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Spacer(),
                          SizedBox(
                            width: 120,
                            height: 25.h,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    padding: WidgetStatePropertyAll(
                                        EdgeInsets.symmetric(horizontal: 10)),
                                    shape: WidgetStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)))),
                                onPressed: () {
                                  Get.toNamed(AppRoutes.serviceRequestDetails,
                                      arguments: {"model": model});
                                },
                                child: Text(
                                  "Show Service",
                                  style: TextStyle(fontSize: 11.sp),
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
          ],
        ),
      ),
    );
  }
}
