import '/controller/provider/my_services/add_provider_service_controller.dart';
import '/core/global/widgets/custom_loading_button.dart';
import '/core/theme/app_color.dart';
import '/widgets/request_services/build_text_form.dart';
import '/widgets/select_city_widget.dart';
import '/widgets/select_country_widget.dart';
import '/widgets/select_specialization_widget.dart';
import '/widgets/select_sup_specialization_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AddProviderServiceView extends StatelessWidget {
  const AddProviderServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddProviderServiceController>(
      init: AddProviderServiceController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.close,
                size: 20.sp,
              ),
            ),
            iconTheme: IconThemeData(color: blackColor),
            title: Text('Add Service',
                style: TextStyle(fontSize: 20.sp, color: blackColor)),
            backgroundColor: whiteColor,
            elevation: 0,
          ),
          body: controller.selectedCity == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: controller.formKey,
                  child: Stepper(
                    currentStep: controller.currentStep,
                    onStepContinue: controller.onStepContinue,
                    onStepCancel: controller.onStepCancel,
                    onStepTapped: controller.onStepTaped,
                    controlsBuilder: (_, controls) {
                      return Row(
                        children: [
                          controller.currentStep > 0
                              ? TextButton(
                                  onPressed: controls.onStepCancel,
                                  child: Text('Previous'),
                                )
                              : SizedBox.shrink(),
                          Gap(10.w),
                          if (controller.currentStep != 2)
                            CustomLoadingButton(
                              borderRadius: 10.r,
                              height: 30.h,
                              width: 0.23.sw,
                              onPressed: controller.onStepContinue,
                              text: "Next",
                            )
                          else
                            CustomLoadingButton(
                              borderRadius: 10.r,
                              height: 30.h,
                              width: 0.3.sw,
                              onPressed: () {
                                return controller.addServices();
                              },
                              text: "Add",
                            ),
                        ],
                      );
                    },
                    steps: [
                      /// Step 1
                      Step(
                        isActive: controller.currentStep == 0,
                        state: controller.getStepStats(
                          controller.currentStep == 0,
                        ),
                        title: Text('Service Details'),
                        content: ProviderServiceStep1(
                          controller: controller,
                        ),
                      ),

                      /// Step 2
                      Step(
                        title: Text('Location'),
                        state: controller.getStepStats(
                          controller.currentStep == 1,
                        ),
                        content: ProviderServiceStep2(
                          controller: controller,
                        ),
                        isActive: controller.currentStep == 1,
                      ),

                      /// Step 3
                      Step(
                        state: controller.getStepStats(
                          controller.currentStep == 2,
                        ),
                        title: Text('Service Features'),
                        content: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            for (int index = 0;
                                index < controller.features.length;
                                index++)
                              Column(
                                children: [
                                  controller.features[index].widget,
                                  if (controller.features.length != 1)
                                    Align(
                                      alignment: AlignmentDirectional.centerEnd,
                                      child: TextButton(
                                        onPressed: () {
                                          controller.removeFeatures(index);
                                        },
                                        child: Text("- Remove"),
                                      ),
                                    ),
                                ],
                              ),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: TextButton(
                                onPressed: () {
                                  controller.increaseFeatures();
                                },
                                child: Text("+ Add More"),
                              ),
                            ),
                          ],
                        ),
                        isActive: controller.currentStep == 2,
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class ProviderServiceStep2 extends StatelessWidget {
  const ProviderServiceStep2({
    super.key,
    required this.controller,
  });
  final AddProviderServiceController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(10.h),
        SelectCountryWidget(
          enabled: false,
          value: controller.selectedCountry,
          models: controller.countries,
          onChanged: (val) {
            controller.onCountryChanged(val);
          },
        ),
        Gap(40),
        SelectCityWidget(
          value: controller.selectedCity!,
          models: controller.cities,
          onChanged: (val) {
            controller.onCityChanged(val);
          },
        ),
        Gap(40),
        SelectSpecializationWidget(
          value: controller.selectedSpecialization,
          models: controller.specializations,
          onChanged: (val) {
            controller.onSpecializeChanged(val);
          },
        ),
        Gap(40),
        SelectSupSpecializationWidget(
          value: controller.selectedSubSpecialization,
          models: controller.subSpecializations,
          onChanged: (val) {
            controller.onSubSpecializeChanged(val);
          },
        ),
        Gap(30),
      ],
    );
  }
}

class ProviderServiceStep1 extends StatelessWidget {
  const ProviderServiceStep1({
    super.key,
    required this.controller,
  });
  final AddProviderServiceController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: GestureDetector(
            onTap: controller.galleryImage,
            child: controller.imageFile != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.file(
                      controller.imageFile!,
                      height: 130.h,
                      width: 180.h,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: 130.h,
                    width: 180.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Icon(
                      Icons.image,
                      size: 50,
                      color: Colors.grey.shade700,
                    ),
                  ),
          ),
        ),
        Gap(40.h),
        // buildTextField(controller.titleArController, 'Title (Arabic)',
        //     Icons.title, "enter title in arabic"),
        // Gap(30),
        buildTextField(
          controller.titleEnController,
          'Title',
          Icons.title,
          "enter title",
          (val) {
            return controller.validUserData(val);
          },
        ),
        Gap(20.h),
        buildTextField(
          controller.descriptionController,
          'Description',
          Icons.description,
          "enter service description",
          (val) {
            return controller.validUserData(val);
          },
        ),
        Gap(20.h),
        buildTextField(
          controller.addressController,
          'Address',
          Icons.location_on,
          "enter your address",
          (val) {
            return controller.validUserData(val);
          },
        ),
        Gap(20.h),
        buildTextField(
          controller.overviewController,
          'Overview',
          Icons.location_on,
          "enter service overview",
          (val) {
            return controller.validUserData(val);
          },
        ),
        Gap(20.h),
        buildTextField(
          controller.videoController,
          'Video Link',
          Icons.location_on,
          "enter service video (optional)",
          (val) {
            return controller.validUserData(val);
          },
          hasValidation: false,
        ),
        Gap(12.h),
      ],
    );
  }
}
