import '/controller/request_services/add_request_service_controller.dart';
import '/core/global/widgets/custom_loading_button.dart';
import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

const primaryColor = Color(0xffbe0000);

class AddServiceRequest extends StatelessWidget {
  AddServiceRequest({super.key});
  final controller = Get.put(AddRequestServiceController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddRequestServiceController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            leading: controller.currentStep == 0
                ? IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      size: 20.sp,
                    ))
                : IconButton(
                    onPressed: controller.previousStep,
                    icon: Icon(
                      Icons.arrow_back_ios,
                      size: 20.sp,
                    )),
            iconTheme: IconThemeData(color: blackColor),
            title: Text('Add Service',
                style: TextStyle(fontSize: 20.sp, color: blackColor)),
            backgroundColor: whiteColor,
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                          'Step ${controller.currentStep + 1} of ${controller.steps.length}  '),
                      Expanded(
                        child: LinearProgressIndicator(
                          borderRadius: BorderRadius.circular(30),
                          minHeight: 10,
                          value: (controller.currentStep + 1) /
                              controller.steps.length,
                          backgroundColor: Colors.grey[200],
                          color: primaryColor,
                        ),
                      ),
                    ],
                  ),
                  Gap(25),
                  Form(
                    key: controller.formKey,
                    child: controller.steps[controller.currentStep],
                  ),
                  CustomLoadingButton(
                    borderRadius: 12,
                    onPressed: () {
                      if (controller.currentStep ==
                          controller.steps.length - 1) {
                        return controller.addServices();
                      } else {
                        return controller.nextStep;
                      }
                    },
                    text: controller.currentStep == controller.steps.length - 1
                        ? 'Submit'
                        : 'Next',
                  ),
                  Gap(300)
                ],
              ),
            ),
          ));
    });
  }
}
