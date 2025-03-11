import 'package:b2b_partnership_admin/core/enums/store_order_status_enum.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_loading_button.dart';
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
                            _buildClientInfo(controller.model!.client),
                            Gap(10.h),
                            OrderDetailsItemWidget(
                              title: "${"Order Status".tr}: ",
                              value:
                                  "${controller.model?.data.status.capitalizeFirst}"
                                      .tr,
                            ),
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
                            Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                border: Border.all(color: borderColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    "${"Change Order Status".tr}:",
                                    style: getMediumStyle.copyWith(
                                      fontWeight: FontManager.boldFontWeight,
                                    ),
                                  ),
                                  Gap(24.w),
                                  Expanded(
                                    child: DropdownButtonFormField<
                                        StoreOrderStatusWithoutAllEnum>(
                                      isExpanded: true,
                                      value: controller.status,
                                      decoration: InputDecoration(
                                        enabled: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 12.h, horizontal: 12.w),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.r),
                                          borderSide: const BorderSide(
                                            color: blackColor,
                                            width: 1,
                                          ),
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7),
                                          borderSide: const BorderSide(
                                            color: pageColor,
                                            width: 1.5,
                                          ),
                                        ),
                                        label: Text(
                                          'Select Status'.tr,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17.sp,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ),
                                      icon: Icon(
                                        Icons.keyboard_arrow_down_outlined,
                                        size: 23.sp,
                                        color: greyColor,
                                      ),
                                      items: StoreOrderStatusWithoutAllEnum
                                          .values
                                          .map(
                                        (item) {
                                          return DropdownMenuItem<
                                              StoreOrderStatusWithoutAllEnum>(
                                            value: item,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    "${item.name.capitalizeFirst}"
                                                        .tr,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      color: greyColor
                                                          .withAlpha(160),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ).toList(),
                                      onChanged: (value) {
                                        controller.onChangeStatus(value!);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Gap(10.h),
                            CustomLoadingButton(
                              onPressed: () {
                                return controller.updateOrderStatus();
                              },
                              text: 'Update Status'.tr,
                            ),
                            Gap(10.h),
                            Text("Client Data".tr),
                            Gap(10.h),
                            // dataItem("Name".tr,
                            //     "${controller.model.?.name ?? ""}"),
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

  // ✅ Client Information UI
  Widget _buildClientInfo(ClientModel client) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Profile Image & Name
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
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
                      fontWeight: FontManager.boldFontWeight,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),

            // ✅ Email with Mail Launcher
            _buildInfoRow(
              icon: Icons.email,
              label: "Email",
              value: client.email ?? "No Email",
              isClickable: client.email != null,
              onTap: () {
                if (client.email != null) {
                  launchUrl(Uri.parse("mailto:${client.email}"));
                }
              },
            ),

            // ✅ Phone with Call Launcher
            _buildInfoRow(
              icon: Icons.phone,
              label: "Phone",
              value: "+${client.countryCode} ${client.phone ?? "No Phone"}",
              isClickable: client.phone != null,
              onTap: () {
                if (client.phone != null) {
                  launchUrl(
                      Uri.parse("tel:${client.countryCode}${client.phone}"));
                }
              },
            ),

            // ✅ Client ID
            _buildInfoRow(
              icon: Icons.perm_identity,
              label: "Client ID",
              value: client.clientId ?? "N/A",
            ),

            // ✅ Country
            _buildInfoRow(
              icon: Icons.flag,
              label: "Country",
              value: client.countryNameEn ?? "N/A",
            ),

            // ✅ Government
            _buildInfoRow(
              icon: Icons.location_city,
              label: "City",
              value: client.governmentNameEn ?? "N/A",
            ),

            // ✅ Created At
            _buildInfoRow(
              icon: Icons.calendar_today,
              label: "Joined On",
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
              size: 20.sp,
              color: Colors.grey[700],
            ),
            SizedBox(width: 10.w),
            Text(
              "$label: ",
              style: getLightStyle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
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

  dataItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              "$title:",
              style: getMediumStyle.copyWith(
                fontWeight: FontManager.semiBoldFontWeight,
              ),
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
