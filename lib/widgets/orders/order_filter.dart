import 'package:b2b_partnership_admin/controller/orders/orders_controller.dart';
import 'package:b2b_partnership_admin/core/enums/store_order_status_enum.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/core/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderFilter extends StatelessWidget {
  const OrderFilter({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OrdersController());
    return GetBuilder<OrdersController>(builder: (controller) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "ORDERS FILTER".tr,
            style: getMediumStyle.copyWith(
              color: whiteColor,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gap(7),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: whiteColor),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<StoreOrderStatusEnum>(
              style: TextStyle(color: blackColor),
              dropdownColor: primaryColor,
              underline: SizedBox.shrink(),
              value: controller.selectedStatus,
              iconEnabledColor: whiteColor,
              items: StoreOrderStatusEnum.values.map((
                StoreOrderStatusEnum status,
              ) {
                return DropdownMenuItem<StoreOrderStatusEnum>(
                  value: status,
                  child: Text(
                    status.text,
                    style: getRegularStyle.copyWith(
                      color: whiteColor,
                    ),
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
