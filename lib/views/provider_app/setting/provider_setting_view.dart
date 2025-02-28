import '/app_routes.dart';
import '/controller/provider/setting/provider_setting_controller.dart';
import '/core/functions/logout.dart';
import '/core/functions/remove_account.dart';
import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
import '/widgets/language_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProviderSettingView extends StatelessWidget {
  const ProviderSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProviderSettingController());
    return Scaffold(
      body: GetBuilder<ProviderSettingController>(
        builder: (controller) => SafeArea(
            child: controller.menuModel == null
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 60.h,
                              width: 60.h,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.grey[300]!)),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  controller.menuModel!.data!.image!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Gap(10),
                            Text(
                              controller.menuModel!.data!.name!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15.sp),
                            ),
                            Text(
                              "+${controller.menuModel!.data!.countryCode}${controller.menuModel!.data!.phone}",
                              style:
                                  TextStyle(color: greyColor, fontSize: 15.sp),
                            ),
                            Gap(10),
                            GridView(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 15,
                                      childAspectRatio: 9 / 4.1),
                              children: [
                                boxWidget(
                                    Icons.work_outline,
                                    Colors.amber,
                                    controller.menuModel!.jobsCount.toString(),
                                    "Jobs", () {
                                  Get.toNamed(AppRoutes.getRequestServices);
                                }),
                                boxWidget(
                                    Icons.shopping_cart_outlined,
                                    Colors.blue,
                                    controller.menuModel!.shoppingCount
                                        .toString(),
                                    "Shopping", () {
                                  Get.toNamed(AppRoutes.shop);
                                }),
                                boxWidget(
                                    CupertinoIcons.news,
                                    Colors.green,
                                    controller.menuModel!.ordersCount
                                        .toString(),
                                    "Orders", () {
                                  Get.toNamed(AppRoutes.shopOrders);
                                }),
                                boxWidget(
                                    Icons.headset_mic_outlined,
                                    Colors.red,
                                    controller.menuModel!.complaintsCount
                                        .toString(),
                                    "Complaints", () {
                                  Get.toNamed(AppRoutes.complaints);
                                })
                              ],
                            ),
                            Gap(20.h),
                            FractionallySizedBox(
                              widthFactor: 10,
                              child: Divider(
                                thickness: 5,
                                color: borderColor.withAlpha(40),
                              ),
                            ),
                            Gap(10.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Personal information",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17.sp),
                                ),
                                Gap(20),
                                rowWidget("Email",
                                    controller.menuModel!.data!.email!),
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    color: borderColor,
                                  ),
                                ),
                                rowWidget(
                                    "City",
                                    translateDatabase(
                                        arabic: controller
                                            .menuModel!.data!.governmentNameAr!,
                                        english: controller.menuModel!.data!
                                            .governmentNameEn!)),
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    color: borderColor,
                                  ),
                                ),
                                rowWidget(
                                    "Country",
                                    translateDatabase(
                                        arabic: controller
                                            .menuModel!.data!.countryNameAr!,
                                        english: controller
                                            .menuModel!.data!.countryNameEn!)),
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    color: borderColor.withAlpha(40),
                                  ),
                                ),
                                rowWidget(
                                    "Category",
                                    translateDatabase(
                                        arabic: controller.menuModel!.data!
                                            .specializationNameAr!,
                                        english: controller.menuModel!.data!
                                            .specializationNameEn!)),
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    color: borderColor.withAlpha(40),
                                  ),
                                ),
                                rowWidget(
                                    "Sub Category",
                                    translateDatabase(
                                        arabic: controller.menuModel!.data!
                                            .subSpecializationNameAr!,
                                        english: controller.menuModel!.data!
                                            .subSpecializationNameEn!)),
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    color: borderColor.withAlpha(40),
                                  ),
                                ),
                                rowWidget(
                                    "Company Type",
                                    translateDatabase(
                                        arabic: controller.menuModel!.data!
                                            .providerTypeNameAr!,
                                        english: controller.menuModel!.data!
                                            .providerTypeNameEn!)),
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    color: borderColor.withAlpha(40),
                                  ),
                                ),
                                Gap(10),
                                Text(
                                  "Commercial Papers",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w300),
                                ),
                                Gap(20),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: PDF().cachedFromUrl(
                                      controller
                                          .menuModel!.data!.commercialRegister!,
                                      placeholder: (progress) =>
                                          Center(child: Text('loading...')),
                                      errorWidget: (error) =>
                                          Center(child: Text(error.toString())),
                                    ),
                                  ),
                                ),
                                Gap(15),
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    color: borderColor.withAlpha(40),
                                  ),
                                ),
                                Gap(10),
                                Text(
                                  "Tax Papers",
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w300),
                                ),
                                Gap(20),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    // border: Border.all(color: primaryColor, width: 2)
                                  ),
                                  height: 200,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: PDF().cachedFromUrl(
                                      controller.menuModel!.data!.taxCard!,
                                      placeholder: (progress) =>
                                          Center(child: Text('loading...')),
                                      errorWidget: (error) =>
                                          Center(child: Text(error.toString())),
                                    ),
                                  ),
                                ),
                                Gap(30),
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    thickness: 5,
                                    color: borderColor.withAlpha(40),
                                  ),
                                ),
                                Gap(20),
                                Text(
                                  "Other Services",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17.sp),
                                ),
                                Gap(20),
                                rowWithArrow(
                                  CupertinoIcons.person,
                                  "Edit Profile",
                                  () {
                                    Get.toNamed(
                                      AppRoutes.editProviderProfile,
                                      arguments: {
                                        'model': controller.menuModel!.data,
                                      },
                                    );
                                  },
                                ),
                                Gap(8),
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    color: borderColor,
                                  ),
                                ),
                                rowWithArrow(
                                  FontAwesomeIcons.addressCard,
                                  "Mange your Contacts",
                                  () {
                                    Get.toNamed(AppRoutes.providerContacts);
                                  },
                                ),
                                Gap(8),
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    color: borderColor,
                                  ),
                                ),
                                Gap(8),
                                LanguageWidget(),
                                Gap(8),
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    color: borderColor,
                                  ),
                                ),
                                Gap(8),
                                rowWithArrow(
                                  CupertinoIcons.padlock,
                                  "Change Password",
                                  () {
                                    Get.toNamed(AppRoutes.changePassword);
                                  },
                                ),
                                Gap(8),
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    color: borderColor,
                                  ),
                                ),
                                Gap(8),
                                rowWithArrow(
                                  CupertinoIcons.delete_simple,
                                  "Remove Account",
                                  () {
                                    removeAccountDialog(
                                      removeAccountLoading:
                                          controller.removeAccountLoading,
                                      update: controller.update,
                                    );
                                  },
                                ),
                                Gap(8),
                                FractionallySizedBox(
                                  widthFactor: 10,
                                  child: Divider(
                                    color: borderColor,
                                  ),
                                ),
                                Gap(8),
                                rowWithArrow(
                                  Icons.logout_rounded,
                                  "Logout",
                                  () {
                                    logoutDialog();
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
      ),
    );
  }

  Widget boxWidget(IconData icon, Color color, String title, String subTitle,
      void Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor)),
        child: Row(
          children: [
            CircleAvatar(
              radius: 19.sp,
              backgroundColor: color.withAlpha(30),
              child: Icon(
                icon,
                color: color,
                size: 20.sp,
              ),
            ),
            Gap(10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                ),
                Text(
                  subTitle,
                  style: TextStyle(color: greyColor, fontSize: 13.sp),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget rowWidget(String title, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Text(title,
                  style:
                      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300))),
          Expanded(
              flex: 2,
              child: Text(
                data,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black54),
              ))
        ],
      ),
    );
  }

  Widget rowWithArrow(IconData icon, String title, void Function() onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Row(
        children: [
          CircleAvatar(
            radius: 18.sp,
            backgroundColor: borderColor.withAlpha(30),
            child: Icon(
              icon,
              color: Colors.black54,
              size: 20.sp,
            ),
          ),
          Gap(15),
          Text(
            title,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
          ),
          Spacer(),
          IconButton(
              onPressed: onPressed,
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 15.sp,
              ))
        ],
      ),
    );
  }
}
