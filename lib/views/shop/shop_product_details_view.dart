import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/controller/shop/shop_product_details_controller.dart';
import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';
import '/core/utils/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';
import 'package:widget_zoom/widget_zoom.dart';

class ShopProductDetailsView extends StatelessWidget {
  const ShopProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopProductDetailsController>(
      init: ShopProductDetailsController(),
      builder: (ShopProductDetailsController controller) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: Icon(
                FontAwesomeIcons.trashCan,
                size: 16.sp,
                color: redColor,
              ),
              onPressed: () {
                controller.deleteProductDialog();
              },
            ),
            IconButton(
              icon: Icon(
                FontAwesomeIcons.pen,
                size: 16.sp,
              ),
              onPressed: () {
                controller.editProduct();
              },
            ),
          ],
        ),
        body: SafeArea(
          child: SizedBox(
            height: 1.sh,
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 15.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (controller.isLoading)
                    FractionallySizedBox(
                      widthFactor: 1.1,
                      child: LinearProgressIndicator(
                        color: primaryColor,
                        backgroundColor: unSelectedBNavColor,
                      ),
                    ),
                  FractionallySizedBox(
                    widthFactor: 1.1,
                    child: Stack(
                      children: [
                        WidgetZoom(
                          heroAnimationTag: controller.product.id.toString(),
                          zoomWidget: Container(
                            height: 0.46.sh,
                            width: 1.sw,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(controller.product.image),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        if (controller.product.discount != "0")
                          PositionedDirectional(
                            top: 12.h,
                            end: 12.w,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 6.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 2,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Text(
                                "-${controller.product.discount}%",
                                style: getBoldStyle.copyWith(
                                  fontSize: 13.sp,
                                  color: whiteColor,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  Gap(20.h),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          translateDatabase(
                            arabic: controller.product.titleAr,
                            english: controller.product.titleEn,
                          ),
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Gap(10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (controller.product.discount != "0")
                            Text(
                              "${controller.product.price}\$",
                              style: getLightStyle.copyWith(
                                fontSize: 14.sp,
                                color: blackColor.withAlpha(150),
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          Gap(5.w),
                          Text(
                            controller.product.discount != "0"
                                ? "${double.parse(controller.product.price) - (double.parse(controller.product.discount) / 100 * double.parse(controller.product.price))}\$"
                                : "${controller.product.price}\$",
                            style: getLightStyle.copyWith(
                                fontWeight: FontManager.boldFontWeight,
                                fontSize: 15.sp,
                                color: primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap(20.h),
                  Text(
                    "Description:".tr,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontManager.semiBoldFontWeight,
                    ),
                  ),
                  Gap(4.h),
                  ReadMoreText(
                    translateDatabase(
                          arabic: controller.product.descriptionAr,
                          english: controller.product.descriptionEn,
                        ) +
                        " ",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Gap(20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
