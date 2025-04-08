
import 'package:b2b_partnership_admin/core/functions/translate_database.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/core/theme/text_style.dart';
import 'package:b2b_partnership_admin/core/utils/font_manager.dart';
import 'package:b2b_partnership_admin/models/shop_product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ShopProductItemWidget extends StatelessWidget {
  const ShopProductItemWidget({
    super.key,
    required this.product,
    required this.onTap,
  });

  final ShopProductModel product;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 190.h,
        width: 1.sp,
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
            FractionallySizedBox(
              widthFactor: 1.2,
              child: Stack(
                children: [
                  CustomNetworkImage(
                    imageUrl: product.image,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 130.h,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    width: double.infinity,
                    height: 130.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: blackColor.withAlpha(170),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.black.withAlpha(170),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Text(
                      translateDatabase(
                        arabic: product.descriptionAr,
                        english: product.descriptionEn,
                      ),
                      style: context.isTablet
                          ? getBoldStyle.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontManager.mediumFontWeight,
                              color: whiteColor)
                          : getBoldStyle.copyWith(
                              fontWeight: FontManager.mediumFontWeight,
                              fontSize: 15.sp,
                              color: whiteColor),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (product.discount != "0")
                    PositionedDirectional(
                      bottom: 0.h,
                      end: 24.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 7.h,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor, // Colors.red,
                          borderRadius: BorderRadius.circular(0.r),
                        ),
                        child: Text(
                          "-${product.discount}%",
                          style: getLightStyle.copyWith(
                            fontWeight: FontManager.boldFontWeight,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Gap(8.h),
            Text(
              translateDatabase(
                arabic: product.titleAr,
                english: product.titleEn,
              ),
              style: context.isTablet
                  ? getLightStyle.copyWith(
                      fontSize: 9.sp,
                      fontWeight: FontManager.mediumFontWeight,
                    )
                  : getLightStyle.copyWith(
                      fontWeight: FontManager.regularFontWeight,
                      fontSize: 15.sp,
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
                    style: context.isTablet
                        ? getLightStyle.copyWith(
                            fontSize: 12.sp,
                            color: blackColor.withAlpha(150),
                            decoration: TextDecoration.lineThrough,
                          )
                        : getLightStyle.copyWith(
                            fontSize: 16.sp,
                            color: blackColor.withAlpha(150),
                            decoration: TextDecoration.lineThrough,
                          ),
                  ),
                Gap(10.w),
                Text(
                  product.discount != "0"
                      ? "${double.parse(product.price) - (double.parse(product.discount) / 100 * double.parse(product.price))}\$"
                      : "${product.price}\$",
                  style: context.isTablet
                      ? getLightStyle.copyWith(
                          fontSize: 9.sp,
                          color: primaryColor,
                          fontWeight: FontManager.semiBoldFontWeight,
                        )
                      : getLightStyle.copyWith(
                          fontWeight: FontManager.boldFontWeight,
                          fontSize: 16.sp,
                          color: Colors.amber,
                        ),
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
