import '/controller/provider/provider_contacts_controller.dart';
import '/core/global/widgets/custom_loading_button.dart';
import '/core/global/widgets/custom_server_status_widget.dart';
import '/core/global/widgets/custom_sliver_server_status_widget.dart';
import '/widgets/request_services/build_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProviderContactsView extends StatelessWidget {
  const ProviderContactsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProviderContactsController>(
      init: ProviderContactsController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: Text('My Contacts'),
          ),
          body: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  vertical: 10.h,
                  horizontal: 16.w,
                ),
                sliver: CustomSliverServerStatusWidget(
                  statusRequest: controller.statusRequest,
                  errorMessage: controller.errorMessage,
                  child: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Gap(20.h),
                        buildTextField(
                          controller.phoneController,
                          'Phone',
                          Icons.phone,
                          'enter phone number',
                          (val) {
                            return "";
                          },
                          hasValidation: false,
                        ),
                        Gap(20.h),
                        buildTextField(
                          controller.emailController,
                          'Email',
                          Icons.email,
                          'enter email',
                          (val) {
                            return "";
                          },
                          hasValidation: false,
                        ),
                        Gap(20.h),
                        buildTextField(
                          controller.whatsappController,
                          'Address',
                          Icons.location_on,
                          'enter address',
                          (val) {
                            return "";
                          },
                          hasValidation: false,
                        ),
                        Gap(20.h),
                        buildTextField(
                          controller.telegramController,
                          'Telegram',
                          Icons.telegram,
                          'enter telegram',
                          (val) {
                            return "";
                          },
                          hasValidation: false,
                        ),
                        Gap(20.h),
                        buildTextField(
                          controller.instagramController,
                          'Instagram',
                          Icons.location_on,
                          'enter instagram',
                          (val) {
                            return "";
                          },
                          hasValidation: false,
                        ),
                        Gap(20.h),
                        buildTextField(
                          controller.facebookController,
                          'Facebook',
                          Icons.facebook,
                          'enter facebook',
                          (val) {
                            return "";
                          },
                          hasValidation: false,
                        ),
                        Gap(20.h),
                        buildTextField(
                          controller.linkedinController,
                          'Linkedin',
                          Icons.location_on,
                          'enter linkedin',
                          (val) {
                            return "";
                          },
                          hasValidation: false,
                        ),
                        Gap(20.h),
                        buildTextField(
                          controller.websiteController,
                          'Website',
                          Icons.web,
                          'enter website',
                          (val) {
                            return "";
                          },
                          hasValidation: false,
                        ),
                        Gap(20.h),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomSheet: BottomAppBar(
            height: 0.1.sh,
            child: Column(
              children: [
                CustomLoadingButton(
                  onPressed: () {
                    return controller.updateProviderContacts();
                  },
                  text: 'Change'.tr,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
