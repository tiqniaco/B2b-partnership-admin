import 'package:b2b_partnership_admin/controller/manage_users/manage_admins_controller.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partnership_admin/core/global/widgets/text_form_widget.dart';
import 'package:b2b_partnership_admin/widgets/manage_users/admin_widget.dart';
import 'package:flutter/cupertino.dart';

import '/core/global/widgets/custom_server_status_widget.dart';
import '/core/theme/app_color.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ManageAdminsView extends StatefulWidget {
  const ManageAdminsView({super.key});

  @override
  State<ManageAdminsView> createState() => _ManageAdminsViewState();
}

class _ManageAdminsViewState extends State<ManageAdminsView>
    with TickerProviderStateMixin {
  final controller = Get.put(ManageAdminsController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageAdminsController>(
      builder: (ManageAdminsController controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: whiteColor,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Manage",
                  style: TextStyle(fontSize: 15.sp, color: greyColor),
                ),
                Gap(5.w),
                Text(
                  "Admins",
                  style: TextStyle(fontSize: 15.sp),
                ),
              ],
            ),
            actions: [
              InkWell(
                onTap: () {
                  onAddAdmin();
                },
                child: Row(
                  children: [
                    Text(
                      "add more +",
                      style: TextStyle(
                          color: blackColor,
                          fontSize: 14.sp,
                          decoration: TextDecoration.underline),
                    ),
                    Gap(15.w),
                  ],
                ),
              )
            ],
          ),
          body: ListView(
            children: [
              Gap(15),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(
                  thickness: 3,
                ),
              ),
              Gap(18),
              CustomServerStatusWidget(
                statusRequest: controller.statusRequestAdmins,
                child: AdminWidget(
                  admins: controller.admins,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  onAddAdmin() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return GetBuilder<ManageAdminsController>(
            builder: (con) => Form(
              key: controller.formKey,
              child: Container(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ADD NEW ADMIN",
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 17.sp,
                          ),
                        ),
                        Gap(5),
                        Center(
                          child: GestureDetector(
                            onTap: controller.galleryImage,
                            child: controller.imageFile != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(70),
                                    child: Image.file(
                                      controller.imageFile!,
                                      height: 90.h,
                                      width: 90.h,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Container(
                                    height: 90.h,
                                    width: 90.h,
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(70),
                                    ),
                                    child: Icon(
                                      CupertinoIcons.person,
                                      size: 40.sp,
                                      color: Colors.grey,
                                    )),
                          ),
                        ),
                        Gap(10.h),
                        TextFormWidget(
                          enabled: true,
                          contentPadding: EdgeInsets.all(15),
                          textFormController: controller.nameEnController,
                          validator: (val) {
                            return controller.validUserData(val);
                          },
                          hintText: 'Name',
                        ),
                        Gap(10.h),
                        TextFormWidget(
                          enabled: true,
                          contentPadding: EdgeInsets.all(15),
                          textFormController: controller.nameEnController,
                          validator: (val) {
                            return controller.validUserData(val);
                          },
                          hintText: 'Email',
                        ),
                        Gap(10.h),
                        TextFormWidget(
                          enabled: true,
                          contentPadding: EdgeInsets.all(15),
                          textFormController: controller.nameArController,
                          validator: (val) {
                            return controller.validUserData(val);
                          },
                          hintText: 'phone',
                        ),
                        Gap(10.h),
                        CustomLoadingButton(
                          onPressed: () {
                            return controller.addAdmin();
                          },
                          text: "Add".tr,
                          borderRadius: 10.r,
                          backgroundColor: primaryColor.withAlpha(100),
                        ),
                        Gap(10.h),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 35.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: greyColor,
                              borderRadius: BorderRadius.circular(10.r),
                              //  border: Border.all(color: greyColor),
                            ),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ]),
                ),
              ),
            ),
          );
        });
  }
}
