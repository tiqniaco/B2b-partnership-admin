import 'package:b2b_partnership_admin/app_routes.dart';
import 'package:b2b_partnership_admin/core/constants/app_constants.dart';
import 'package:b2b_partnership_admin/core/functions/get_text_direction.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/models/service_request_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.service, required this.onPressed});

  final ServiceRequestModel service;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.serviceRequestDetails,
              arguments: {"model": service});
        },
        child: Container(
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
                      imageUrl: service.clientImage!,
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
                      Text(service.name!,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          )),
                      Text(service.createdAt!,
                          style: TextStyle(
                            color: Colors.green,
                            //fontWeight: FontWeight.bold,
                            fontSize: 10.sp,
                          )),
                    ],
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: onPressed,
                      icon: Icon(
                        Icons.remove_circle,
                        color: primaryColor,
                        size: 24.r,
                      ))
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
                          service.description!,
                          textDirection: containsArabic(service.description!)
                              ? TextDirection.rtl
                              : TextDirection.ltr,
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
              if (service.image != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: "$kBaseImageUrl${service.image}",
                    height: 100.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Text("error image"),
                  ),
                ),
            ],
          ),
        ));
  }
}
