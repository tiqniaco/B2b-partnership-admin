import '/core/functions/translate_database.dart';
import '/core/global/widgets/custom_network_image.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';
import '/core/utils/font_manager.dart';
import '/models/shop_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ShopProductItemWidget extends StatelessWidget {
  const ShopProductItemWidget({
    super.key,
    required this.product,
    required this.showCategories,
    required this.onTap,
  });

  final ShopProductModel product;
  final bool showCategories;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor,
            width: 1.w,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.symmetric(horizontal: 8.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FractionallySizedBox(
                widthFactor: 1.2,
                child: Stack(
                  children: [
                    CustomNetworkImage(
                      imageUrl: product.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    if (product.discount != "0")
                      PositionedDirectional(
                        top: 8.h,
                        end: 8.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 5.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(
                            "-${product.discount}%",
                            style: getBoldStyle.copyWith(
                              fontSize: 10.sp,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Gap(8.h),
            Text(
              translateDatabase(
                arabic: product.titleAr,
                english: product.titleEn,
              ),
              style: getLightStyle.copyWith(
                fontWeight: FontManager.mediumFontWeight,
                fontSize: showCategories ? 11.sp : 13.sp,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                if (product.discount != "0")
                  Text(
                    "${product.price}\$",
                    style: getLightStyle.copyWith(
                      fontSize: showCategories ? 11.sp : 13.sp,
                      color: blackColor.withAlpha(150),
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                Gap(5.w),
                Text(
                  product.discount != "0"
                      ? "${double.parse(product.price) - (double.parse(product.discount) / 100 * double.parse(product.price))}\$"
                      : "${product.price}\$",
                  style: getLightStyle.copyWith(
                      fontWeight: FontManager.semiBoldFontWeight,
                      fontSize: showCategories ? 11.sp : 13.sp,
                      color: primaryColor),
                ),
              ],
            ),
            Gap(8.h),
          ],
        ),
      ),
    );
  }
}
