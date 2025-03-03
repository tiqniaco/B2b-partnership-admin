import 'package:b2b_partnership_admin/controller/shop/products/shop_add_new_product_controller.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/core/theme/text_style.dart';
import 'package:b2b_partnership_admin/core/utils/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ShopAddNewProductView extends StatelessWidget {
  const ShopAddNewProductView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopAddNewProductController>(
      init: ShopAddNewProductController(),
      builder: (ShopAddNewProductController controller) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: Text(
                "Add New Product",
                style: TextStyle(
                  color: whiteColor,
                ),
              ),
              iconTheme: IconThemeData(
                color: whiteColor,
              ),
            ),
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => controller.selectImage(),
                            child: Container(
                              height: 130.h,
                              width: 200.h,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                border: Border.all(color: greyColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: controller.image == null
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image,
                                          size: 40.sp,
                                          color: greyColor,
                                        ),
                                        Gap(4.h),
                                        Text("No image selected"),
                                        Gap(4.h),
                                        Text(
                                          "Click to Select image",
                                          style: TextStyle(color: greyColor),
                                        ),
                                      ],
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.file(
                                        controller.image!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                            ),
                          ),
                          Gap(12.h),
                          InkWell(
                            onTap: () => controller.selectFile(),
                            child: Container(
                              // height: 70.h,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                border: Border.all(color: greyColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 10.h,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (controller.file == null)
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Upload product",
                                                style: getLightStyle.copyWith(
                                                  color: greyColor,
                                                  fontWeight: FontManager
                                                      .semiBoldFontWeight,
                                                ),
                                              ),
                                              Gap(8.w),
                                              Icon(
                                                Icons.cloud_upload,
                                                size: 20.sp,
                                                color: greyColor,
                                              ),
                                            ],
                                          ),
                                          Gap(8.h),
                                          Text(
                                            "Accepted files: pdf, doc, docx, xls, xlsx, csv, txt, zip, rar, ppt, pptx, jpg, jpeg, png, gif, svg",
                                            style: getLightStyle.copyWith(
                                              color: greyColor,
                                              fontWeight:
                                                  FontManager.regularFontWeight,
                                              fontSize: 10.sp,
                                            ),
                                            textAlign: TextAlign.center,
                                            maxLines: 3,
                                          ),
                                        ],
                                      ),
                                    )
                                  else ...[
                                    Expanded(
                                      child: Text(
                                        controller.file?.path.split('/').last ??
                                            '',
                                        style: getLightStyle.copyWith(
                                          color: greyColor,
                                          fontWeight:
                                              FontManager.mediumFontWeight,
                                        ),
                                      ),
                                    ),
                                    Gap(8.w),
                                    IconButton(
                                      onPressed: () {
                                        controller.deleteFile();
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.xmark,
                                        size: 20.sp,
                                        color: redColor,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          Gap(16.h),
                          TextFormField(
                            controller: controller.titleArController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Title (Arabic)",
                              hintText: "enter title (Arabic)",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter title (Arabic)";
                              }
                              return null;
                            },
                          ),
                          Gap(10.h),
                          TextFormField(
                            controller: controller.titleEnController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Title (English)",
                              hintText: "enter title (English)",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter title (English)";
                              }
                              return null;
                            },
                          ),
                          Gap(10.h),
                          TextFormField(
                            controller: controller.priceController,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(
                                  r'^\d+\.?\d{0,2}',
                                ),
                              )
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Price",
                              hintText: "enter price",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter price";
                              }
                              return null;
                            },
                          ),
                          Gap(10.h),
                          TextFormField(
                            controller: controller.discountController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(
                                  r'^\d{1,3}',
                                ),
                              ),
                            ],
                            decoration: InputDecoration(
                              labelText: "Discount %",
                              hintText: "enter discount",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter discount";
                              }
                              return null;
                            },
                          ),
                          Gap(10.h),
                          TextFormField(
                            minLines: null,
                            maxLines: null,
                            controller: controller.descriptionEnController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Description (English)",
                              hintText: "enter description (English)",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter description (English)";
                              }
                              return null;
                            },
                          ),
                          Gap(10.h),
                          TextFormField(
                            minLines: null,
                            maxLines: null,
                            keyboardType: TextInputType.text,
                            controller: controller.descriptionArController,
                            decoration: InputDecoration(
                              labelText: "Description (Arabic)",
                              hintText: "enter description (Arabic)",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter description (Arabic)";
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              child: Column(
                children: [
                  CustomLoadingButton(
                    onPressed: () {
                      return controller.addProduct();
                    },
                    text: 'Add',
                  ),
                ],
              ),
            ));
      },
    );
  }
}
