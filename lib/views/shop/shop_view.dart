import 'package:b2b_partnership_admin/app_routes.dart';
import 'package:b2b_partnership_admin/controller/shop/shop_controller.dart';
import 'package:b2b_partnership_admin/core/functions/translate_database.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/core/theme/text_style.dart';
import 'package:b2b_partnership_admin/widgets/shop/shop_item_product_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ShopView extends StatelessWidget {
  const ShopView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopController>(
      init: ShopController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 5.w,
            toolbarHeight: context.isTablet ? 50.h : null,
            title: Expanded(
              child: TextFormField(
                controller: controller.searchController,
                style: getRegularStyle,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.getShopProducts(firstTime: true);
                    },
                    icon: Icon(
                      CupertinoIcons.search,
                      size: context.isTablet ? 13.w : 18.w,
                      color: blackColor,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: context.isTablet ? 10.h : 0,
                    horizontal: context.isTablet ? 10.w : 20.w,
                  ),
                  hintText: 'Search...'.tr,
                  hintStyle: getRegularStyle,
                  border: InputBorder.none,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: greyColor),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                onChanged: (value) {
                  if (value.isEmpty) {
                    controller.getShopProducts(firstTime: true);
                  }
                },
                onFieldSubmitted: (value) {
                  if (value.isNotEmpty) {
                    controller.getShopProducts(firstTime: true);
                  }
                },
              ),
            ),
            backgroundColor: whiteColor,
            actions: [
              // IconButton(
              //   onPressed: () {
              //     controller.getShopProducts(firstTime: true);
              //   },
              //   icon: Icon(
              //     CupertinoIcons.search,
              //     color: blackColor,
              //   ),
              // ),
              Container(
                margin: EdgeInsetsDirectional.only(end: 8.w),
                child: IconButton(
                  tooltip: "Orders".tr,
                  onPressed: () {
                    Get.toNamed(AppRoutes.shopOrders);
                  },
                  icon: SvgPicture.asset(
                    'assets/svgs/bag2.svg',
                    colorFilter: ColorFilter.mode(
                      blackColor,
                      BlendMode.srcIn,
                    ),
                    width: 23.w,
                  ),
                ),
              ),
              Gap(10.w)
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            shape: CircleBorder(),
            onPressed: () {
              Get.toNamed(
                AppRoutes.shopAddNewProduct,
                arguments: {
                  'categoryId':
                      controller.selectedCategory?.id.toString() ?? "",
                },
              );
            },
            child: Icon(
              Icons.add,
              color: whiteColor,
              size: 20.sp,
            ),
          ),
          body: controller.selectedCategory == null
              ? SizedBox.shrink()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 125.h,
                      child: CustomServerStatusWidget(
                        statusRequest: controller.categoriesStatus,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.all(10),
                          itemBuilder: (context, index) {
                            if (index == 0) {
                              return InkWell(
                                onTap: () {
                                  Get.toNamed(AppRoutes.shopAddNewCategory);
                                },
                                child: SizedBox(
                                  width: 100.w,
                                  height: 100.h,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        child: Image.asset(
                                          "assets/images/rr.png",
                                          fit: BoxFit.fitHeight,
                                          width: 140.w,
                                          height: 110.h,
                                        ),
                                      ),
                                      Container(
                                        width: 100.w,
                                        height: 110.h,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                            color: blackColor.withAlpha(50)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20.0,
                                            left: 12.0,
                                            right: 12.0,
                                            bottom: 10.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              color: Colors.white,
                                              size: 25.sp,
                                            ),
                                            Gap(8.h),
                                            Text(
                                              'Add Category'.tr,
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: whiteColor),
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.r),
                                    border: Border.all(
                                        width: 4,
                                        color: controller
                                                    .selectedCategory!.id !=
                                                controller
                                                    .shopCategories[index - 1]
                                                    .id
                                            ? Colors.transparent
                                            : primaryColor.withAlpha(150))),
                                child: InkWell(
                                  onTap: () {
                                    controller.onTapCategory(index - 1);
                                  },
                                  child: SizedBox(
                                    width: 100.w,
                                    height: 110.h,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          child: CustomNetworkImage(
                                            imageUrl: controller
                                                .shopCategories[index - 1]
                                                .image,
                                            width: 100.w,
                                            height: 110.h,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        if (controller.selectedCategory!.id !=
                                            controller
                                                .shopCategories[index - 1].id)
                                          Container(
                                            width: 100.w,
                                            height: 110.h,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5.r),
                                                color:
                                                    blackColor.withAlpha(140)),
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            //mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Get.toNamed(
                                                        AppRoutes
                                                            .shopEditCategory,
                                                        arguments: {
                                                          'model': controller
                                                                  .shopCategories[
                                                              index - 1],
                                                        },
                                                      );
                                                    },
                                                    child: Icon(
                                                      FontAwesomeIcons
                                                          .solidPenToSquare,
                                                      size: 17.sp,
                                                      color: whiteColor,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      controller
                                                          .deleteCategoryDialog(
                                                              index - 1);
                                                    },
                                                    child: Icon(
                                                        FontAwesomeIcons.trash,
                                                        color: whiteColor,
                                                        size: 17.sp),
                                                  ),
                                                ],
                                              ),
                                              Gap(10.h),
                                              Spacer(),
                                              Text(
                                                translateDatabase(
                                                  arabic: controller
                                                      .shopCategories[index - 1]
                                                      .nameAr,
                                                  english: controller
                                                      .shopCategories[index - 1]
                                                      .nameEn,
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: whiteColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                          separatorBuilder: (context, index) => Gap(5.w),
                          itemCount: controller.shopCategories.length + 1,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: Text(
                        translateDatabase(
                            arabic: controller.selectedCategory!.nameAr,
                            english: controller.selectedCategory!.nameEn),
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: blackColor),
                      ),
                    ),
                    Expanded(
                      child: CustomServerStatusWidget(
                        statusRequest: controller.productsStatus,
                        child: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => Gap(20.h),
                          padding: EdgeInsets.all(10),
                          itemCount: controller.shopProducts.length,
                          itemBuilder: (context, index) {
                            final product = controller.shopProducts[index];
                            return ShopProductItemWidget(
                              product: product,
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.shopProductDetails,
                                  arguments: {
                                    "product": product,
                                    "productId": product.id.toString(),
                                  },
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                    Gap(40)
                  ],
                ),
        );
      },
    );
  }
}
