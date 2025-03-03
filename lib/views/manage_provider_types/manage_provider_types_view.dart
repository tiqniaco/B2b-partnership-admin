import 'package:b2b_partnership_admin/controller/manage_provider_types/manage_provider_types_controller.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partnership_admin/core/global/widgets/text_form_widget.dart';
import 'package:b2b_partnership_admin/widgets/manage_provider_types/provider_type_widget.dart';

import '/core/global/widgets/custom_server_status_widget.dart';
import '/core/theme/app_color.dart';
import '../../widgets/manage_category/row_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ManageProviderTypesView extends StatefulWidget {
  const ManageProviderTypesView({super.key});

  @override
  State<ManageProviderTypesView> createState() =>
      _ManageProviderTypesViewState();
}

class _ManageProviderTypesViewState extends State<ManageProviderTypesView>
    with TickerProviderStateMixin {
  final controller = Get.put(ManageProviderTypesController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManageProviderTypesController>(
      builder: (ManageProviderTypesController controller) {
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
                  "Provider Types",
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
                  title: "Types",
                  onTap: () {
                    onAddType();
                  },
                ),
              ),
              Gap(18),
              CustomServerStatusWidget(
                statusRequest: controller.statusRequest,
                child: ProviderTypeWidget(
                  types: controller.types,
                  
                ),
              ),
              Gap(50)
            ],
          ),
        );
      },
    );
  }

  onAddType() {
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
                      "Add New Type".tr,
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
                        return controller.addProviderType();
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

  

}
