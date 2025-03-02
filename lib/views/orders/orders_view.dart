import '/controller/orders/orders_controller.dart';
import '/core/global/widgets/custom_sliver_server_status_widget.dart';
import '/core/theme/app_color.dart';
import '/widgets/orders/order_filter.dart';
import '/widgets/orders/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrdersView extends StatelessWidget {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(
        init: OrdersController(),
        builder: (OrdersController controller) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: whiteColor,
              // automaticallyImplyLeading: false,
              title: Text("All Orders"),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 10.h,
              ),
              child: CustomScrollView(
                controller: controller.scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        OrderFilter(),
                        Gap(10.h),
                      ],
                    ),
                  ),
                  CustomSliverServerStatusWidget(
                    statusRequest: controller.statusRequest,
                    child: SliverList.separated(
                      itemCount: controller.orders.length,
                      itemBuilder: (context, index) {
                        return OrderWidget(
                          orderModel: controller.orders[index],
                        );
                      },
                      separatorBuilder: (context, index) => Gap(10.h),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
