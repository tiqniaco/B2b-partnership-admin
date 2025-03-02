import 'package:b2b_partnership_admin/controller/manage_location/manage_location_controller.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partnership_admin/core/global/widgets/text_form_widget.dart';
import 'package:b2b_partnership_admin/widgets/manage_location/city_widget.dart';
import 'package:b2b_partnership_admin/widgets/manage_location/country_widget.dart';

import '/core/global/widgets/custom_server_status_widget.dart';
import '/core/theme/app_color.dart';
import '../../widgets/manage_category/row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ManageLocationView extends StatefulWidget {
  const ManageLocationView({super.key});

  @override
  State<ManageLocationView> createState() => _ManageLocationViewState();
}

class _ManageLocationViewState extends State<ManageLocationView>
    with TickerProviderStateMixin {
  final controller = Get.put(ManageLocationController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageLocationController>(
      builder: (ManageLocationController controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: whiteColor,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Manage!!",
                  style: TextStyle(fontSize: 15.sp, color: greyColor),
                ),
                Text(
                  "Countries & Cities",
                  style: TextStyle(fontSize: 15.sp),
                ),
              ],
            ),
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
              Gap(10.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: RowWidget(
                  title: "Countries",
                  onTap: () {
                    onAddCountry();
                  },
                ),
              ),
              Gap(18),
              CustomServerStatusWidget(
                statusRequest: controller.statusRequestCountry,
                child: CountryWidget(
                  countries: controller.countries,
                  length: controller.countries.length > controller.length
                      ? controller.length
                      : controller.countries.length,
                ),
              ),
              Gap(8.h),
              if (controller.countries.length > controller.length)
                controller.countries.length == controller.length
                    ? InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          controller.onTapSeeLess();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "See less",
                              style: TextStyle(
                                  color: primaryColor, fontSize: 14.sp),
                            ),
                            Gap(10),
                            Icon(
                              Icons.keyboard_arrow_up_outlined,
                              size: 17.sp,
                              color: primaryColor,
                            )
                          ],
                        ),
                      )
                    : InkWell(
                        splashColor: Colors.transparent,
                        onTap: () {
                          controller.onTapSeeMore();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "See more",
                              style: TextStyle(
                                  color: primaryColor, fontSize: 14.sp),
                            ),
                            Gap(10),
                            Icon(
                              Icons.keyboard_arrow_down_outlined,
                              size: 17.sp,
                              color: primaryColor,
                            )
                          ],
                        ),
                      ),
              Gap(30),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: RowWidget(
                  title: "Cities",
                  onTap: () {
                    onAddCity();
                  },
                ),
              ),
              Gap(15.h),
              CustomServerStatusWidget(
                statusRequest: controller.statusRequestCity,
                child: CityWidget(
                  cities: controller.cities,
                ),
              ),
              Wrap(children: []),
              Gap(50)
            ],
          ),
        );
      },
    );
  }

  onAddCity() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Form(
            key: controller.formKey,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add New City",
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 17.sp,
                      ),
                    ),
                    Gap(15.h),
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
                        return controller.addCity();
                      },
                      text: "Add".tr,
                      borderRadius: 10.r,
                      backgroundColor: primaryColor.withAlpha(100),
                    ),
                    Gap(15.h),
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
          );
        });
  }

  onAddCountry() {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return GetBuilder<ManageLocationController>(
            builder: (con) => Form(
              key: controller.formKey,
              child: Container(
                padding: EdgeInsets.all(20),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Add New Country",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 17.sp,
                        ),
                      ),
                      Gap(10),
                      GestureDetector(
                        onTap: controller.galleryImage,
                        child: controller.imageFile != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  controller.imageFile!,
                                  height: 70.h,
                                  width: 100.h,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                height: 70.h,
                                width: 100.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(
                                  Icons.image,
                                  size: 35.sp,
                                  color: Colors.grey,
                                )),
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
          );
        });
  }
}
