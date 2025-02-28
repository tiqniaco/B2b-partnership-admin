import '/core/localization/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '/core/global/widgets/custom_network_image.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';

class CartItemWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final int quantity;
  final int id;
  final bool deleteLoading;
  final bool fromOrderDetails;

  const CartItemWidget({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.quantity,
    required this.id,
    required this.deleteLoading,
    this.fromOrderDetails = false,
  });

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(CartController());
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(20.w),
      ),
      height: fromOrderDetails ? 0.12.sh : null,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 10.h,
        ),
        child: Row(
          children: [
            CustomNetworkImage(
              imageUrl: imageUrl,
              width: 0.18.sw,
              fit: BoxFit.fitHeight,
            ),
            Gap(14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: getBoldStyle.copyWith(
                      fontSize: 16.sp,
                    ),
                    maxLines: 2,
                  ),
                  Gap(4.h),
                  Text(
                    '${AppStrings.EGP.tr} $price',
                    style: getRegularStyle.copyWith(
                      fontSize: 14.sp,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Gap(3.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (!fromOrderDetails)
                  InkWell(
                    onTap: () {
                      // Decrease quantity action
                      // controller.incrementQuantity(
                      //   id: id,
                      //   quantity: quantity,
                      // );
                    },
                    child: Card(
                      elevation: 5,
                      shape: const CircleBorder(),
                      child: Icon(
                        FontAwesomeIcons.circlePlus,
                        color: primaryColor,
                        size: 24.sp,
                      ),
                    ),
                  ),
                if (fromOrderDetails)
                  Text(
                    AppStrings.quantity.tr,
                    style: getBoldStyle.copyWith(
                      fontSize: 14.sp,
                    ),
                  ),
                Text(
                  '$quantity',
                  style: getBoldStyle.copyWith(
                    fontSize: 16.sp,
                  ),
                ),
                if (!fromOrderDetails)
                  InkWell(
                    onTap: () {
                      // // Decrease quantity action
                      // if (quantity > 1) {
                      //   controller.decrementQuantity(
                      //     id: id,
                      //     quantity: quantity,
                      //   );
                      // } else {
                      //   controller.removeItem(id);
                      // }
                    },
                    child: Card(
                      elevation: 5,
                      shape: const CircleBorder(),
                      child: SizedBox(
                        width: 25.w,
                        height: 25.w,
                        child: deleteLoading
                            ? SizedBox(
                                width: 24.sp,
                                child: const CircularProgressIndicator(),
                              )
                            : Icon(
                                quantity == 1
                                    ? FontAwesomeIcons.trashCan
                                    : Icons.remove,
                                color:
                                    quantity == 1 ? dangerColor : primaryColor,
                                size: quantity == 1 ? 16.w : 24.sp,
                              ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
