import 'package:b2b_partnership_admin/controller/settings/payment_controller.dart';
import 'package:b2b_partnership_admin/core/global/widgets/text_form_widget.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/views/settings/payment_months_widget.dart';

import 'package:flutter/material.dart';

import 'package:b2b_partnership_admin/core/global/widgets/custom_loading_button.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AddPaymentMethod extends StatelessWidget {
  AddPaymentMethod({super.key});
  final controller = Get.find<PaymentController>();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
      init: PaymentController(),
      builder: (PaymentController controller) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 10.h,
                ),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Choose Months Plans".tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17.r),
                          ),
                          InkWell(
                            onTap: () {
                              onAddMonth(context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                  color: Colors.indigo,
                                  border: Border.all(color: Colors.indigo),
                                  borderRadius: BorderRadius.circular(8)),
                              child: Icon(
                                Icons.add,
                                size: 16.r,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(16),
                      PaymentMonthsWidget(
                        months: controller.monthsList,
                      ),
                      Gap(26),
                      Text(
                        "Additional Information".tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17.r),
                      ),
                      Gap(14),
                      TextFormField(
                        controller: controller.nameController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          labelText: "Title".tr,
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 13.sp),
                          hintText: "enter title".tr,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter title".tr;
                          }
                          return null;
                        },
                      ),
                      Gap(12),
                      TextFormField(
                        controller: controller.priceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(16),
                          labelText: "Price".tr,
                          hintText: "enter price".tr,
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 13.sp),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter price".tr;
                          }
                          return null;
                        },
                      ),
                      Gap(18),
                      Row(
                        children: [
                          Expanded(
                            child: _buildCountField(
                              controller: controller.servicesCountController,
                              labelText: "Services Count".tr,
                              hintText: "enter services count".tr,
                              onIncrement: () =>
                                  controller.incrementServicesCount(),
                              onDecrement: () =>
                                  controller.decrementServicesCount(),
                            ),
                          ),
                          Gap(12),
                          Expanded(
                            child: _buildCountField(
                              controller: controller.productsCountController,
                              labelText: "Products Count".tr,
                              hintText: "enter Products Count".tr,
                              onIncrement: () =>
                                  controller.incrementProductsCount(),
                              onDecrement: () =>
                                  controller.decrementProductsCount(),
                            ),
                          ),
                        ],
                      ),
                      Gap(20),
                      // Switch buttons section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Is Trial".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            ),
                          ),
                          Switch(
                            value: controller.isTrial,
                            onChanged: (value) {
                              controller.toggleTrial(value);
                            },
                            inactiveThumbColor: Colors.grey,
                            trackOutlineColor:
                                WidgetStatePropertyAll(Colors.grey),
                            trackOutlineWidth: WidgetStatePropertyAll(1),
                            //inactiveTrackColor: greyColor.withAlpha(100),
                            activeColor: Colors.indigo,
                          ),
                        ],
                      ),
                      Gap(8),
                      if (controller.isTrial)
                        TextFormField(
                          controller: controller.trailsDaysController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(16),
                            labelText: "Trail Days".tr,
                            hintText: "enter trail days".tr,
                            labelStyle:
                                TextStyle(color: Colors.grey, fontSize: 13.sp),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter price".tr;
                            }
                            return null;
                          },
                        ),
                      Gap(8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Is Active".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            ),
                          ),
                          Switch(
                            value: controller.isActive,
                            onChanged: (value) {
                              controller.toggleActive(value);
                            },
                            inactiveThumbColor: Colors.grey,
                            trackOutlineColor:
                                WidgetStatePropertyAll(Colors.grey),
                            trackOutlineWidth: WidgetStatePropertyAll(1),
                            activeColor: Colors.indigo,
                          ),
                        ],
                      ),
                      Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Is Popular".tr,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            ),
                          ),
                          Switch(
                            value: controller.isPopular,
                            onChanged: (value) {
                              controller.togglePopular(value);
                            },
                            inactiveThumbColor: Colors.grey,
                            trackOutlineColor:
                                WidgetStatePropertyAll(Colors.grey),
                            trackOutlineWidth: WidgetStatePropertyAll(1),
                            activeColor: Colors.indigo,
                          ),
                        ],
                      ),

                      Gap(24),

                      CustomLoadingButton(
                        onPressed: () {
                          return controller.addPackage();
                        },
                        text: 'Add'.tr,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<dynamic> onAddMonth(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return GetBuilder<PaymentController>(
            builder: (con) => Form(
              key: controller.addMonthFormKey,
              child: Container(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Add New Months plan".tr,
                          style: TextStyle(
                            color: blackColor,
                            fontSize: 17.sp,
                          ),
                        ),
                        // Gap(10),

                        Gap(15.h),
                        TextFormWidget(
                          enabled: true,
                          contentPadding: EdgeInsets.all(15),
                          textFormController:
                              controller.monthsDurationController,
                          validator: (val) {
                            return val!.isEmpty ? "can't be empty".tr : null;
                          },
                          hintText: 'Duration , ex: 2'.tr,
                        ),

                        Gap(10.h),
                        CustomLoadingButton(
                          onPressed: () {
                            return controller.addMonths();
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
                              "Cancel".tr,
                              style: TextStyle(
                                  color: whiteColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Gap(20)
                      ]),
                ),
              ),
            ),
          );
        });
  }

  Widget _buildCountField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.all(16),
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(color: Colors.grey, fontSize: 13.sp),
        suffixIcon: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: onIncrement,
              child: Icon(
                Icons.arrow_drop_up,
                size: 24.r,
                color: Colors.indigo,
              ),
            ),
            InkWell(
              onTap: onDecrement,
              child: Icon(
                Icons.arrow_drop_down,
                size: 24.r,
                color: Colors.indigo,
              ),
            ),
          ],
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter $labelText".tr;
        }
        return null;
      },
    );
  }
}
