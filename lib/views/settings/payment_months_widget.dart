import 'package:b2b_partnership_admin/controller/settings/payment_controller.dart';
import 'package:b2b_partnership_admin/models/months_model.dart';
import 'package:gap/gap.dart';
import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class PaymentMonthsWidget extends StatelessWidget {
  const PaymentMonthsWidget({super.key, required this.months});
  final List<PaymentMonths> months;

  @override
  Widget build(BuildContext context) {
    Get.find<PaymentController>();
    return GetBuilder<PaymentController>(builder: (controller) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Wrap(
          spacing: 10.w,
          runSpacing: 10.h,
          children: months.map((month) {
            return InkWell(
              onTap: () {
                controller.onTapMonth(month);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: controller.selectedMonth?.id == month.id
                      ? primaryColor.withAlpha(20)
                      : whiteColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.withAlpha(80)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      month.durationMonths.toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Gap(4),
                    Text(
                      "month",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: blackColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Gap(12.w),
                    InkWell(
                        onTap: () {
                          Get.defaultDialog(
                            title: 'Delete this month'.tr,
                            titleStyle: TextStyle(fontSize: 13.sp),
                            middleText: "Are you sure to delete?".tr,
                            textConfirm: 'Yes',
                            textCancel: 'No',
                            onConfirm: () {
                              controller.deleteMonth(month.id!);
                              Get.back();
                            },
                          );
                        },
                        child: Icon(Icons.close,
                            color: primaryColor, size: 16.sp)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
