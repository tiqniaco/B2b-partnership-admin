import 'package:b2b_partnership_admin/controller/manage_users/manage_admins_controller.dart';
import 'package:b2b_partnership_admin/models/admin_model.dart';
import 'package:flutter/cupertino.dart';

import '/core/theme/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AdminWidget extends StatelessWidget {
  AdminWidget({super.key, required this.admins});
  final List<AdminModel> admins;

  final controller = Get.put(ManageAdminsController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageAdminsController>(
        builder: (controller) => GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.vertical,
            itemCount: admins.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              mainAxisExtent: 110,
            ),
            itemBuilder: (context, index) => Container(
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
                                imageUrl: admins[index].image!,
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
                                  admins[index].name!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  admins[index].phone!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: primaryColor,
                                      fontWeight: FontWeight.w400),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  admins[index].email!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: greyColor,
                                      fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                Get.defaultDialog(
                                  titlePadding:
                                      EdgeInsets.symmetric(vertical: 10),
                                  title: "Delete Admin".tr,
                                  titleStyle: TextStyle(fontSize: 16.r),
                                  contentPadding: EdgeInsets.only(bottom: 15.h),
                                  content: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Text(
                                      "Are you sure to delete?".tr,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16.sp),
                                    ),
                                  ),
                                  onConfirm: () => controller
                                      .deleteAdmin(admins[index].adminId!),
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
                )));
  }
}
