import '/controller/orders/orders_controller.dart';
import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PaymentFilter extends StatelessWidget {
  const PaymentFilter({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersController());
    return GetBuilder<OrdersController>(builder: (controller) {
      return Row(
        children: [
          Text(
            "Payment",
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
          ),
          Gap(7),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              underline: SizedBox.shrink(),
              value: controller.selectedPayment,
              items: controller.paymentStatus.map((String status) {
                return DropdownMenuItem<String>(
                  value: status,
                  child: Text(
                    status,
                    style: TextStyle(color: greyColor),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                controller.onPaymentChanged(newValue!);
              },
            ),
          ),
        ],
      );
    });
  }
}
