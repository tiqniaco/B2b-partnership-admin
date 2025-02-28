import '/controller/provider/my_services/edit_provider_service_controller.dart';
import '/core/global/widgets/custom_loading_button.dart';
import '/core/global/widgets/custom_network_image.dart';
import '/widgets/request_services/build_text_form.dart';
import '/widgets/select_city_widget.dart';
import '/widgets/select_country_widget.dart';
import '/widgets/select_specialization_widget.dart';
import '/widgets/select_sup_specialization_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class EditProviderServiceDetailsWidget extends StatelessWidget {
  const EditProviderServiceDetailsWidget({
    super.key,
    required this.controller,
  });

  final EditProviderServiceController controller;

  @override
  Widget build(BuildContext context) {
    if (controller.selectedCity == null ||
        controller.selectedCountry == null ||
        controller.selectedSpecialization == null ||
        controller.selectedSubSpecialization == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            child: Form(
              key: controller.formKey,
              child: Column(
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
                              child: CustomNetworkImage(
                                imageUrl: controller.image,
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
                  ),
                  Gap(20.h),
                  SelectCountryWidget(
                    enabled: false,
                    value: controller.selectedCountry!,
                    models: controller.countries,
                    onChanged: (val) {
                      controller.onCountryChanged(val);
                    },
                  ),
                  Gap(20.h),
                  SelectCityWidget(
                    value: controller.selectedCity!,
                    models: controller.cities,
                    onChanged: (val) {
                      controller.onCityChanged(val);
                    },
                  ),
                  Gap(20.h),
                  SelectSpecializationWidget(
                    value: controller.selectedSpecialization!,
                    models: controller.specializations,
                    onChanged: (val) {
                      controller.onSpecializeChanged(val);
                    },
                  ),
                  Gap(20.h),
                  SelectSupSpecializationWidget(
                    value: controller.selectedSubSpecialization!,
                    models: controller.subSpecializations,
                    onChanged: (val) {
                      controller.onSubSpecializeChanged(val);
                    },
                  ),
                  Gap(30.h),
                  CustomLoadingButton(
                    onPressed: () {
                      return controller.updateServices();
                    },
                    text: "Edit",
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
