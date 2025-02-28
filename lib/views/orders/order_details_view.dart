import '/app_routes.dart';
import '/controller/orders/order_details_controller.dart';
import '/core/global/widgets/custom_server_status_widget.dart';
import '/core/services/date_time_convertor.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';
import '/core/utils/font_manager.dart';
import '/widgets/shop/shop_item_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OrderDetailsView extends StatelessWidget {
  const OrderDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderDetailsController>(
      init: OrderDetailsController(),
      builder: (OrderDetailsController controller) => Scaffold(
        appBar: AppBar(
          title: Text("#${controller.orderId}"),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10.w,
            vertical: 10.h,
          ),
          child: controller.model == null
              ? const Center(child: CircularProgressIndicator())
              : CustomServerStatusWidget(
                  statusRequest: controller.statusRequest,
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            OrderDetailsItemWidget(
                              title: "Order Status: ",
                              value: controller
                                      .model?.data.status.capitalizeFirst ??
                                  "",
                            ),
                            Gap(10.h),
                            OrderDetailsItemWidget(
                              title: "Order Date: ",
                              value: DateTimeConvertor.formatDate(
                                controller.model?.data.createdAt ?? "",
                              ),
                            ),
                            Gap(10.h),
                            OrderDetailsItemWidget(
                              title: "Order Expiration Date: ",
                              value: DateTimeConvertor.formatDate(
                                controller.model?.data.expirationDate ?? "",
                              ),
                            ),
                            Gap(10.h),
                            OrderDetailsItemWidget(
                              title: "Order Total: ",
                              value:
                                  "${controller.model?.data.totalPrice.toString() ?? ""}\$",
                            ),
                            Gap(10.h),
                          ],
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(),
                            Text(
                              "Order Items:",
                              style: getSemiBoldStyle.copyWith(
                                fontWeight: FontManager.boldFontWeight,
                                color: primaryColor,
                              ),
                            ),
                            Gap(10.h),
                          ],
                        ),
                      ),
                      SliverGrid.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10.h,
                          crossAxisSpacing: 10.w,
                          childAspectRatio: 1 / 1.2,
                        ),
                        itemCount: controller.model?.items.length ?? 0,
                        itemBuilder: (context, index) {
                          return ShopProductItemWidget(
                            product: controller.model!.items[index],
                            showCategories: false,
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.orderItem,
                                arguments: {
                                  "product": controller.model!.items[index],
                                  'orderStatus':
                                      controller.model?.data.status ?? "",
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

class OrderDetailsItemWidget extends StatelessWidget {
  const OrderDetailsItemWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: greyColor.withAlpha(100),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: getMediumStyle.copyWith(
              fontWeight: FontManager.semiBoldFontWeight,
            ),
          ),
          Text(
            value,
            style: getMediumStyle.copyWith(
              fontWeight: FontManager.semiBoldFontWeight,
              color: primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
