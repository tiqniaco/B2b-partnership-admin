import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '/app_routes.dart';
import '/controller/shop/shop_controller.dart';
import '/core/functions/translate_database.dart';
import '/core/global/widgets/custom_network_image.dart';
import '/core/global/widgets/custom_server_status_widget.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';
import '/core/utils/font_manager.dart';
import '/widgets/shop/shop_item_product_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            titleSpacing: 16.w,
            title: Row(
              children: [
                SizedBox(
                  width: 0.5.sw,
                  child: TextFormField(
                    controller: controller.searchController,
                    style: getRegularStyle,
                    decoration: InputDecoration(
                      hintText: 'Search...'.tr,
                      hintStyle: getRegularStyle,
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: greyColor),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onFieldSubmitted: (value) {
                      if (value.isNotEmpty) {
                        controller.getShopProducts(firstTime: true);
                      }
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    controller.getShopProducts(firstTime: true);
                  },
                  icon: Icon(
                    CupertinoIcons.search,
                    color: blackColor,
                  ),
                ),
              ],
            ),
            backgroundColor: whiteColor,
            actions: [
              Container(
                margin: EdgeInsetsDirectional.only(end: 8.w),
                child: IconButton(
                  tooltip: "Orders".tr,
                  onPressed: () {
                    Get.toNamed(AppRoutes.shopCart);
                  },
                  icon: SvgPicture.asset(
                    'assets/svgs/bag2.svg',
                    colorFilter: ColorFilter.mode(
                      primaryColor,
                      BlendMode.srcIn,
                    ),
                    width: 25.w,
                  ),
                ),
              ),
            ],
          ),
          body: Row(
            children: [
              if (controller.showCategories)
                SizedBox(
                  width: 0.25.sw,
                  height: 1.sh,
                  child: CustomServerStatusWidget(
                    statusRequest: controller.categoriesStatus,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 10.h,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8.r),
                            onTap: () {
                              Get.toNamed(AppRoutes.shopAddNewCategory);
                            },
                            child: Container(
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(color: primaryColor),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.plus,
                                    color: primaryColor,
                                    size: 20.sp,
                                  ),
                                  Gap(5.h),
                                  Text(
                                    'Add Category'.tr,
                                    style: TextStyle(
                                      color: blackColor,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Gap(8.h),
                        Expanded(
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.symmetric(
                              vertical: 10.h,
                              horizontal: 4.w,
                            ),
                            itemBuilder: (context, index) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(8.r),
                                    splashColor: primaryColor.withAlpha(10),
                                    onTap: () {
                                      controller.onTapCategory(index);
                                    },
                                    child: SizedBox(
                                      height: 50.h,
                                      child: Column(
                                        children: [
                                          CircleAvatar(
                                            radius: 18.r,
                                            backgroundColor:
                                                primaryColor.withAlpha(10),
                                            child: CustomNetworkImage(
                                              imageUrl: controller
                                                  .shopCategories[index].image,
                                              // shape: BoxShape.circle,
                                            ),
                                          ),
                                          Gap(5.h),
                                          Text(
                                            translateDatabase(
                                              arabic: controller
                                                  .shopCategories[index].nameAr,
                                              english: controller
                                                  .shopCategories[index].nameEn,
                                            ),
                                            style: getLightStyle.copyWith(
                                              fontWeight: controller
                                                          .selectedCategory ==
                                                      controller
                                                          .shopCategories[index]
                                                  ? FontManager.boldFontWeight
                                                  : FontManager
                                                      .regularFontWeight,
                                              color: controller
                                                          .selectedCategory ==
                                                      controller
                                                          .shopCategories[index]
                                                  ? primaryColor
                                                  : greyColor,
                                              fontSize: 9.5.sp,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      Get.toNamed(
                                        AppRoutes.shopEditCategory,
                                        arguments: {
                                          'model':
                                              controller.shopCategories[index],
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                        FontAwesomeIcons.penToSquare),
                                    label: const Text('Edit'),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      controller.deleteCategoryDialog(index);
                                    },
                                    icon: const Icon(FontAwesomeIcons.trash),
                                    label: const Text('Delete'),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) => Gap(20.h),
                            itemCount: controller.shopCategories.length,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Stack(
                children: [
                  PositionedDirectional(
                    start: 0,
                    top: 0,
                    bottom: 0,
                    end: 0,
                    child: VerticalDivider(
                      thickness: 2.w,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8.r),
                      onTap: () {
                        controller.changeShowCategories();
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        color: primaryColor,
                        child: Padding(
                          padding: EdgeInsets.all(8.r),
                          child: Icon(
                            controller.showCategories
                                ? Icons.arrow_back_ios_new
                                : Icons.arrow_forward_ios_outlined,
                            color: whiteColor,
                            size: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: CustomServerStatusWidget(
                  statusRequest: controller.productsStatus,
                  child: GridView.builder(
                    padding: EdgeInsets.all(10),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 15.h,
                      childAspectRatio: 1 / 1.2,
                    ),
                    itemCount: controller.shopProducts.length,
                    itemBuilder: (context, index) {
                      final product = controller.shopProducts[index];
                      return ShopProductItemWidget(
                        product: product,
                        showCategories: controller.showCategories,
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.shopProductDetails,
                            arguments: {
                              "product": product,
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: primaryColor,
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
        );
      },
    );
  }
}
