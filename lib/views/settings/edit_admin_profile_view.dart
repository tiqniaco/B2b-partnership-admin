import '../../controller/settings/edit_admin_profile_controller.dart';
import '/core/global/widgets/custom_loading_button.dart';
import '/core/global/widgets/custom_network_image.dart';
import '/core/theme/app_color.dart';
import '/widgets/auth/auth_text_form.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class EditAdminProfileView extends StatelessWidget {
  const EditAdminProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditAdminProfileController>(
      init: EditAdminProfileController(),
      builder: (EditAdminProfileController controller) {
        return Scaffold(
            appBar: AppBar(
              title: const Text("Edit Admin Profile"),
            ),
            body: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              controller.image == null
                                  ? Container(
                                      padding: EdgeInsets.all(35),
                                      decoration: BoxDecoration(
                                          border:
                                              Border.all(color: primaryColor),
                                          shape: BoxShape.circle),
                                      child: CustomNetworkImage(
                                        imageUrl: controller.model?.image ?? "",
                                        shape: BoxShape.circle,
                                        height: 100.sp,
                                        width: 100.sp,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 100.sp / 2,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(130),
                                        child: Image.file(
                                          height: 100.sp,
                                          width: 100.sp,
                                          fit: BoxFit.cover,
                                          controller.image!,
                                        ),
                                      ),
                                    ),
                              Positioned(
                                bottom: 10,
                                child: InkWell(
                                  onTap: () {
                                    controller.pickImage();
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: primaryColor),
                                        shape: BoxShape.circle),
                                    child: CircleAvatar(
                                      radius: 15.r,
                                      backgroundColor: const Color.fromARGB(
                                          255, 241, 241, 242),
                                      child: Icon(
                                        CupertinoIcons.camera,
                                        size: 15.r,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Gap(15),
                          Text(
                            "uploading image is optional".tr,
                            style: TextStyle(fontSize: 13.sp, color: green),
                          ),
                          Gap(20.h),
                          AuthTextForm(
                            lable: "Full Name".tr,
                            preicon: CupertinoIcons.person,
                            hintText: "Enter your full name".tr,
                            textFormController: controller.nameController,
                            validator: (val) {
                              return controller.validUserData(val);
                            },
                          ),
                          Gap(20.h),
                          AuthTextForm(
                            lable: "Email".tr,
                            preicon: CupertinoIcons.mail,
                            hintText: 'Enter your email'.tr,
                            textFormController: controller.emailController,
                            validator: (val) {
                              return controller.validUserData(val);
                            },
                          ),
                          Gap(20.h),
                          AuthTextForm(
                            lable: "Phone".tr,
                            preicon: CupertinoIcons.mail,
                            hintText: 'Enter your phone'.tr,
                            textFormController: controller.phoneController,
                            validator: (val) {
                              return controller.validUserData(val);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              height: 0.081.sh,
              child: CustomLoadingButton(
                onPressed: () {
                  return controller.updateProfile();
                },
                text: "Update".tr,
              ),
            ));
      },
    );
  }
}
