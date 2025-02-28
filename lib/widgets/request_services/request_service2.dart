import '/controller/request_services/add_request_service_controller.dart';
import '/widgets/select_city_widget.dart';
import '/widgets/select_country_widget.dart';
import '/widgets/select_specialization_widget.dart';
import '/widgets/select_sup_specialization_widget.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class RequestService2 extends StatelessWidget {
  const RequestService2({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddRequestServiceController>(builder: (controller) {
      return Column(
        children: [
          Gap(20),
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
            value: controller.selectedCity,
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
    });
  }
}
