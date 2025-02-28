import '/controller/provider/setting/provider_setting_edit_profile_controller.dart';
import '/core/enums/status_request.dart';
import '/core/global/widgets/custom_loading_button.dart';
import '/core/global/widgets/custom_network_image.dart';
import '/core/theme/app_color.dart';
import '/widgets/auth/auth_text_form.dart';
import '/widgets/auth/select_provider_widget.dart';
import '/widgets/select_city_widget.dart';
import '/widgets/select_country_widget.dart';
import '/widgets/select_specialization_widget.dart';
import '/widgets/select_sup_specialization_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class EditProviderProfileView extends StatelessWidget {
  const EditProviderProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProviderSettingEditProfileController>(
      init: ProviderSettingEditProfileController(),
      builder: (ProviderSettingEditProfileController controller) {
        return Scaffold(
            appBar: AppBar(
              title: const Text("Edit Provider Profile"),
            ),
            body: controller.statusRequestCity == StatusRequest.loading ||
                    controller.statusRequestCountry == StatusRequest.loading ||
                    controller.statusRequestProviderType ==
                        StatusRequest.loading ||
                    controller.statusRequestSpecialization ==
                        StatusRequest.loading ||
                    controller.statusRequestSupSpecialization ==
                        StatusRequest.loading ||
                    controller.model == null
                ? Center(child: const CircularProgressIndicator())
                : CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        child: SingleChildScrollView(
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
                                                border: Border.all(
                                                    color: primaryColor),
                                                shape: BoxShape.circle),
                                            child: CustomNetworkImage(
                                              imageUrl:
                                                  controller.model?.image ?? "",
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
                                              border: Border.all(
                                                  color: primaryColor),
                                              shape: BoxShape.circle),
                                          child: CircleAvatar(
                                            radius: 15.r,
                                            backgroundColor:
                                                const Color.fromARGB(
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
                                  style:
                                      TextStyle(fontSize: 13.sp, color: green),
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
                                  textFormController:
                                      controller.emailController,
                                  validator: (val) {
                                    return controller.validUserData(val);
                                  },
                                ),
                                Gap(20.h),
                                AuthTextForm(
                                  lable: "Bio".tr,
                                  minLines: 4,
                                  maxLines: 10,
                                  preicon: CupertinoIcons.person,
                                  hintText:
                                      "Description of the Company ....".tr,
                                  textFormController: controller.bioController,
                                  validator: (val) {
                                    return controller.validUserData(val);
                                  },
                                ),
                                Gap(20.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SelectCountryWidget(
                                        enabled: false,
                                        value: controller.selectedCountry,
                                        models: controller.countries,
                                        onChanged: (val) {
                                          controller.onCountryChanged(val);
                                        },
                                      ),
                                    ),
                                    Gap(10.w),
                                    Expanded(
                                        child: SelectCityWidget(
                                      value: controller.selectedCity,
                                      models: controller.cities,
                                      onChanged: (val) {
                                        controller.onCityChanged(val);
                                      },
                                    )),
                                  ],
                                ),
                                Gap(20.h),
                                TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: controller.phoneController,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]'),
                                    ),
                                  ],
                                  maxLength: int.parse(
                                      controller.selectedCountry.phoneLength!),
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    label: Text(
                                      "Phone",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17.sp,
                                          color: Colors.black87),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 16),
                                    prefixIcon: SizedBox(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Gap(5),
                                          Icon(
                                            Icons.arrow_drop_down_sharp,
                                            color: blackColor,
                                          ),
                                          Gap(5),
                                          Image.network(
                                            controller.selectedCountry.flag!,
                                            width: 23.h,
                                            height: 23.h,
                                            fit: BoxFit.cover,
                                          ),
                                          Gap(6),
                                          Text(
                                              "+${controller.selectedCountry.code}"),
                                          Gap(8),
                                          Container(
                                            width: 2,
                                            height: 25.h,
                                            color: pageColor,
                                          ),
                                          Gap(10)
                                        ],
                                      ),
                                    ),
                                    hintText: "Without country code".tr,
                                    hintStyle: TextStyle(
                                        fontSize: 12.sp,
                                        color: greyColor.withAlpha(160),
                                        fontWeight: FontWeight.w500),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: blackColor)),
                                  ),
                                ),
                                Gap(20.h),
                                SelectProviderWidget(
                                  providerTypes: controller.providerTypes,
                                  value: controller.selectedProviderType,
                                  onChanged: (value) {
                                    controller.onProviderTypeChanged(value);
                                  },
                                ),
                                Gap(20.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: SelectSpecializationWidget(
                                        value:
                                            controller.selectedSpecialization,
                                        models: controller.specializations,
                                        onChanged: (val) {
                                          controller.onSpecializeChanged(val);
                                        },
                                      ),
                                    ),
                                    Gap(8.w),
                                    Expanded(
                                      child: SelectSupSpecializationWidget(
                                        value: controller
                                            .selectedSubSpecialization,
                                        models: controller.subSpecializations,
                                        onChanged: (val) {
                                          controller
                                              .onSubSpecializeChanged(val);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Gap(20.h),
                                AuthTextForm(
                                  enabled: false,
                                  lable: "Commercial Register".tr,
                                  preicon: CupertinoIcons.person,
                                  hintText: "No file selected   ".tr,
                                  textFormController:
                                      controller.commercialController,
                                  validator: (val) {
                                    return controller.validUserData(val);
                                  },
                                  sufix: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 10),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (controller.commercePdfFile != null)
                                          InkWell(
                                            onTap: () {
                                              controller.removeFile("c");
                                            },
                                            child: Icon(
                                              Icons.close,
                                              size: 23.sp,
                                            ),
                                          ),
                                        Gap(5),
                                        SizedBox(
                                          width: 80.h,
                                          child: ElevatedButton(
                                              onPressed: () {
                                                controller.pickPDF("c");
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30))),
                                              child: Text(
                                                "Upload",
                                                style:
                                                    TextStyle(fontSize: 12.sp),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Gap(20),
                                AuthTextForm(
                                  enabled: false,
                                  lable: "Tax Card".tr,
                                  preicon: CupertinoIcons.person,
                                  hintText: "No file selected   ".tr,
                                  textFormController:
                                      controller.taxCartController,
                                  validator: (val) {
                                    return controller.validUserData(val);
                                  },
                                  sufix: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 8),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        if (controller.taxPdfFile != null)
                                          InkWell(
                                            onTap: () {
                                              //print("hi");
                                              controller.removeFile("t");
                                            },
                                            child: Icon(
                                              Icons.close,
                                              size: 23.sp,
                                            ),
                                          ),
                                        Gap(5),
                                        SizedBox(
                                          width: 80.h,
                                          child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  //padding: EdgeInsets.symmetric(horizontal: 10),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30))),
                                              onPressed: () {
                                                controller.pickPDF(
                                                  "t",
                                                );
                                              },
                                              child: Text(
                                                "Upload",
                                                style:
                                                    TextStyle(fontSize: 12.sp),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Gap(20),
                              ],
                            ),
                          ),
                        ),
                      ),
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
