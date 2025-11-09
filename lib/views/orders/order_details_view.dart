import 'package:b2b_partnership_admin/core/functions/translate_database.dart';
import 'package:b2b_partnership_admin/models/client_model.dart';
import 'package:url_launcher/url_launcher.dart';

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
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(color: whiteColor),
          titleSpacing: 0,
          title: Text(
            "#${controller.orderId}",
            style: TextStyle(
              color: whiteColor,
            ),
          ),
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
                            _buildClientInfo(controller.model!.client),
                            Gap(10.h),
                            OrderDetailsItemWidget(
                              title: "${"Order Date".tr}: ",
                              value: controller.model?.data.createdAt == "null"
                                  ? "Invalid Date"
                                  : DateTimeConvertor.formatDate(
                                      controller.model?.data.createdAt ?? "",
                                    ),
                            ),
                            Gap(10.h),
                            OrderDetailsItemWidget(
                              title: "${"Order Expiration Date".tr}: ",
                              value: DateTimeConvertor.formatDate(
                                controller.model?.data.expirationDate ?? "",
                              ),
                            ),
                            Gap(10.h),
                            OrderDetailsItemWidget(
                              title: "${"Order Total".tr}: ",
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
                              "${"Order Items".tr}:",
                              style: getSemiBoldStyle.copyWith(
                                fontWeight: FontManager.boldFontWeight,
                                color: primaryColor,
                              ),
                            ),
                            Gap(10.h),
                          ],
                        ),
                      ),
                      SliverList.separated(
                        separatorBuilder: (context, index) => Gap(20),
                        itemCount: controller.model?.items.length ?? 0,
                        itemBuilder: (context, index) {
                          return ShopProductItemWidget(
                            product: controller.model!.items[index],
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
                      SliverToBoxAdapter(
                        child: Gap(30),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  // ✅ Client Information UI
  Widget _buildClientInfo(ClientModel client) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: greyCart,
                  backgroundImage:
                      client.image != null && client.image!.isNotEmpty
                          ? NetworkImage(client.image!)
                          : const AssetImage("assets/images/default_user.png")
                              as ImageProvider,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    client.name ?? "Unknown",
                    style: getMediumStyle.copyWith(
                        fontWeight: FontManager.boldFontWeight, fontSize: 16.r),
                  ),
                ),
              ],
            ),
            const Divider(),

            _buildInfoRow(
              icon: Icons.email,
              label: "Email".tr,
              value: client.email ?? "No Email",
              isClickable: client.email != null,
              onTap: () {
                if (client.email != null) {
                  launchUrl(Uri.parse("mailto:${client.email}"));
                }
              },
            ),

            _buildInfoRow(
              icon: Icons.phone,
              label: "Phone".tr,
              value: "+${client.countryCode} ${client.phone ?? "No Phone"}",
              isClickable: client.phone != null,
              onTap: () {
                if (client.phone != null) {
                  launchUrl(
                      Uri.parse("tel:${client.countryCode}${client.phone}"));
                }
              },
            ),

            _buildInfoRow(
              icon: Icons.flag,
              label: "Country".tr,
              value: translateDatabase(
                      arabic: client.countryNameAr!,
                      english: client.countryNameEn!) ??
                  "N/A",
            ),

            _buildInfoRow(
              icon: Icons.location_city,
              label: "City".tr,
              value: translateDatabase(
                      arabic: client.governmentNameAr!,
                      english: client.governmentNameEn!) ??
                  "N/A",
            ),

            _buildInfoRow(
              icon: Icons.calendar_today,
              label: "Joined On".tr,
              value: client.createdAt ?? "N/A",
            ),
          ],
        ),
      ),
    );
  }

// 🔹 Reusable Info Row
  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool isClickable = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: InkWell(
        onTap: isClickable ? onTap : null,
        child: Row(
          children: [
            Icon(
              icon,
              size: 20.r,
              color: Colors.grey[700],
            ),
            SizedBox(width: 10.w),
            Text(
              "$label: ",
              style: getLightStyle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(8),
            Expanded(
              child: Text(
                value,
                style: TextStyle(
                  color: isClickable ? primaryColor : blackColor,
                  decoration: isClickable ? TextDecoration.underline : null,
                  decorationThickness: 0.5,
                  decorationColor: blackColor,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
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
