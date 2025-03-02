import 'package:b2b_partnership_admin/controller/manage_location/manage_location_controller.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partnership_admin/core/global/widgets/text_form_widget.dart';
import 'package:b2b_partnership_admin/models/country_model.dart';

import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CountryWidget extends StatelessWidget {
  CountryWidget({super.key, required this.countries, required this.length});
  final List<CountryModel> countries;
  final int length;
  final controller =
      Get.put(ManageLocationController()); // ManageCategoriesController(),
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageLocationController>(
        builder: (controller) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Wrap(
                spacing: 10.w,
                runSpacing: 10.h,
                children: countries.map((country) {
                  return InkWell(
                    onTap: () {
                      controller.onTapCountry(country);
                    },
                    child: Container(
                      // width: 100.h,
                      // height: 130.h,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: controller.selectedId == country.id
                              ? primaryColor.withAlpha(40)
                              : pageColor.withAlpha(60),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.withAlpha(80))),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CachedNetworkImage(
                            imageUrl: country.flag!,
                            height: 25.h,
                          ),
                          Gap(10.w),
                          Text(
                            translateDatabase(
                                arabic: country.nameAr!,
                                english: country.nameEn!),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14.sp, fontWeight: FontWeight.w400),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Gap(15.w),
                          InkWell(
                              onTap: () {
                                controller.onTapCountry(country);
                                onTapMoreIcon(country.id!, model: country);
                              },
                              child: Icon(Icons.more_vert, size: 17.sp)),
                          Gap(5)
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ));

    // builder: (controller) => GridView.builder(
    //     shrinkWrap: true,
    //     physics: const NeverScrollableScrollPhysics(),
    //     padding: EdgeInsets.symmetric(horizontal: 20),
    //     scrollDirection: Axis.vertical,
    //     itemCount: length, // countries.length,
    //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //       crossAxisCount: 3,
    //       mainAxisSpacing: 10,
    //       crossAxisSpacing: 10,
    //       mainAxisExtent: 180,
    //     ),
    //     itemBuilder: (context, index) => InkWell(
    //           onTap: () {
    //             controller.onTapCategory(index);
    //           },
    //           child: Container(
    //             width: 100.h,
    //             height: 130.h,
    //             padding: EdgeInsets.all(18),
    //             decoration: BoxDecoration(
    //                 color: controller.selectedIndex == index
    //                     ? primaryColor.withAlpha(60)
    //                     : pageColor.withAlpha(60),
    //                 borderRadius: BorderRadius.circular(12),
    //                 border: Border.all(color: Colors.grey.withAlpha(80))),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.end,
    //               children: [
    //                 Container(
    //                   padding: EdgeInsets.all(15),
    //                   decoration: BoxDecoration(
    //                       shape: BoxShape.circle,
    //                       // border: Border.all(color: primaryColor, width: 0.5),
    //                       color: controller.selectedIndex == index
    //                           ? whiteColor.withAlpha(200)
    //                           : pageColor.withAlpha(60)),
    //                   child: CachedNetworkImage(
    //                     imageUrl: countries[index].flag!,
    //                     height: 32.h,
    //                   ),
    //                 ),
    //                 Gap(8),
    //                 Text(
    //                   translateDatabase(
    //                       arabic: countries[index].nameAr!,
    //                       english: countries[index].nameEn!),
    //                   textAlign: TextAlign.center,
    //                   style: TextStyle(
    //                       fontSize: 12.sp, fontWeight: FontWeight.w400),
    //                   maxLines: 2,
    //                   overflow: TextOverflow.ellipsis,
    //                 ),
    //                 IconButton(
    //                     onPressed: () {
    //                       controller.onTapCategory(index);
    //                       onTapMoreIcon(countries[index].id!,
    //                           model: countries[index]);
    //                     },
    //                     icon: Icon(Icons.more_vert, size: 17.sp))
    //               ],
    //             ),
    //           ),
    //         )),

    //);
  }

  onTapMoreIcon(int id, {required CountryModel model}) {
    return Get.defaultDialog(
        titlePadding: EdgeInsets.zero,
        title: " ".tr,
        content: GetBuilder<ManageLocationController>(
            builder: (con) => Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "More Options:".tr,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 17.sp,
                          ),
                        ),
                        Gap(20.h),
                        InkWell(
                          onTap: () {
                            Get.back();
                            controller.onEdit(model);
                            onTapEdit();
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                size: 20.sp,
                              ),
                              Gap(10.w),
                              Text(
                                "Edit".tr,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: blackColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Gap(10.h),
                        Divider(),
                        Gap(10.h),
                        InkWell(
                          onTap: () {
                            Get.back();
                            Get.defaultDialog(
                              titlePadding: EdgeInsets.symmetric(vertical: 10),
                              title: "Delete Category".tr,
                              contentPadding: EdgeInsets.only(bottom: 15.h),
                              content: Container(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Are you sure you want to delete this category?"
                                      .tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16.sp),
                                ),
                              ),
                              onConfirm: () => controller.deleteCountry(id),
                              textConfirm: "Yes".tr,
                              textCancel: "No".tr,
                              onCancel: () {},
                            );
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                size: 20.sp,
                              ),
                              Gap(10.w),
                              Text(
                                "Delete".tr,
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: blackColor,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ]),
                )));
  }

  onTapEdit() {
    return Get.defaultDialog(
        barrierDismissible: false,
        title: "",
        titlePadding: EdgeInsets.zero,
        content: GetBuilder<ManageLocationController>(
          builder: (con) => Form(
            key: controller.formKey,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Edit Category",
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 17.sp,
                      ),
                    ),
                    Gap(10),
                    Center(
                      child: GestureDetector(
                        onTap: controller.galleryImage,
                        child: controller.imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(70),
                                child: Image.file(
                                  controller.imageFile!,
                                  height: 100.h,
                                  width: 100.h,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : SizedBox(
                                // height: 100.h,
                                // width: 100.h,
                                child: ClipRRect(
                                borderRadius: BorderRadius.circular(70),
                                child: CachedNetworkImage(
                                  imageUrl: controller.image!,
                                  height: 100.h,
                                  width: 100.h,
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) => Icon(
                                      Icons.image,
                                      size: 50.sp,
                                      color: Colors.grey.shade700),
                                ),
                              )),
                      ),
                    ),
                    Gap(20.h),
                    TextFormWidget(
                      enabled: true,
                      contentPadding: EdgeInsets.all(15),
                      textFormController: controller.nameEnController,
                      validator: (val) {
                        return controller.validUserData(val);
                      },
                      hintText: 'Name in English',
                    ),
                    Gap(10.h),
                    TextFormWidget(
                      enabled: true,
                      contentPadding: EdgeInsets.all(15),
                      textFormController: controller.nameArController,
                      validator: (val) {
                        return controller.validUserData(val);
                      },
                      hintText: 'Name in Arabic',
                    ),
                    Gap(20.h),
                    CustomLoadingButton(
                      onPressed: () {
                        return controller.addCountry();
                      },
                      text: "Save".tr,
                      borderRadius: 10.r,
                      backgroundColor: primaryColor.withAlpha(100),
                    ),
                    Gap(10.h),
                    InkWell(
                      onTap: () {
                        controller.onEditCancel();
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
        ));
  }
}
