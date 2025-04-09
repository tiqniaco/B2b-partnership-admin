import 'package:b2b_partnership_admin/core/theme/text_style.dart';
import 'package:b2b_partnership_admin/widgets/orders/print_type.dart';

import '/app_routes.dart';
import '/core/services/date_time_convertor.dart';
import '/core/theme/app_color.dart';
import '/models/order_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderWidget extends StatelessWidget {
  const OrderWidget({
    super.key,
    required this.orderModel,
  });

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 20, right: 20),
      child: InkWell(
        onTap: () {
          Get.toNamed(
            AppRoutes.orderDetails,
            arguments: {
              "id": orderModel.id.toString(),
            },
          );
        },
        child: Material(
          elevation: 0.3,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            //padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 255, 252, 252),
              border: Border.all(color: borderColor),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 9.h,
                  ),
                  decoration: BoxDecoration(
                    // color: primaryColor,
                    // gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   colors: [
                    //     const Color.fromARGB(255, 117, 1, 1), // Your base color
                    //     primaryColor,
                    //     lightColor, // A lighter, more vibrant red
                    //   ],
                    // ),
                    border: Border(bottom: BorderSide(color: borderColor)),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        "#",
                        style: getMediumStyle.copyWith(
                            color: blackColor, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        orderModel.id.toString(),
                        style: getRegularStyle.copyWith(
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Spacer(),
                      PrintType(
                        type: orderModel.status,
                      ),
                      Gap(4.w),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 10),
                  child: Column(
                    children: [
                      Gap(8),
                      rowWidget(
                        "Date".tr,
                        orderModel.createdAt != "null"
                            ? DateTimeConvertor.formatDate(
                                orderModel.createdAt,
                              )
                            : "Invalid Date",
                        CupertinoIcons.calendar,
                      ),
                      Gap(8),
                      // Divider(
                      //   color: borderColor,
                      // ),
                      // Gap(8),
                      // rowWidget(
                      //   "Expiry Date".tr,
                      //   DateTimeConvertor.formatDate(
                      //     orderModel.expirationDate!,
                      //   ),
                      //   CupertinoIcons.clock,
                      // ),
                      // Gap(8),
                      Divider(
                        color: borderColor,
                      ),
                      Gap(8),
                      rowWidget(
                        "Billed".tr,
                        "${orderModel.totalPrice} \$",
                        CupertinoIcons.money_dollar_circle,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  rowWidget(String title, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.r,
        ),
        Gap(8.w),
        Text(
          title,
          style: getRegularStyle,
        ),
        Spacer(),
        Text(
          value,
          style: getRegularStyle,
        ),
      ],
    );
  }
}
