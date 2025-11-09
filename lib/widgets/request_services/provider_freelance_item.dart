import '/app_routes.dart';
import '/core/constants/app_constants.dart';
import '/core/theme/app_color.dart';
import '/models/service_request_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProviderFreelanceItem extends StatelessWidget {
  const ProviderFreelanceItem({super.key, required this.model});
  final ServiceRequestModel model;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.serviceRequestDetails,
            arguments: {"model": model});
      },
      child: Container(
        // height: model.image == null ? 150.h : 250.h,
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
              top: BorderSide(width: 0.5, color: Colors.grey.withAlpha(80))),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: CachedNetworkImage(
                    imageUrl: model.clientImage!,
                    height: 40.h,
                    width: 40.h,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => CircleAvatar(
                      child: Icon(CupertinoIcons.person),
                    ),
                  ),
                ),
                Gap(10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.name!,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        )),
                    Text(model.createdAt!,
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
                        model.description!,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gap(5),
                    ],
                  ),
                ),
              ],
            ),
            // Gap(10),
            if (model.image != null)
              ClipRRect(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topLeft: Radius.circular(10)),
                child: CachedNetworkImage(
                  imageUrl: "$kBaseImageUrl${model.image}",
                  height: 100.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) => Text("${model.image}"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
