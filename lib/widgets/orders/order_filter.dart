import '/controller/orders/orders_controller.dart';
import '/core/enums/store_order_status_enum.dart';
import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderFilter extends StatelessWidget {
  const OrderFilter({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersController());
    return GetBuilder<OrdersController>(builder: (controller) {
      return Row(
        children: [
          Text(
            "Order".tr,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.sp),
          ),
          Gap(7),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: borderColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<StoreOrderStatusEnum>(
              underline: SizedBox.shrink(),
              value: controller.selectedStatus,
              items: StoreOrderStatusEnum.values.map((
                StoreOrderStatusEnum status,
              ) {
                return DropdownMenuItem<StoreOrderStatusEnum>(
                  value: status,
                  child: Text(
                    status.text,
                    style: TextStyle(color: greyColor),
                  ),
                );
              }).toList(),
              onChanged: (StoreOrderStatusEnum? newValue) {
                controller.onStatusChanged(newValue!);
              },
            ),
          ),
        ],
      );
    });
  }
}
