import 'package:b2b_partnership_admin/controller/shop/products/shop_add_new_product_controller.dart';
import 'package:b2b_partnership_admin/core/functions/translate_database.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/core/theme/text_style.dart';
import 'package:b2b_partnership_admin/core/utils/font_manager.dart';
import 'package:b2b_partnership_admin/models/product_description_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ShopAddNewProductView extends StatelessWidget {
  ShopAddNewProductView({super.key});
  final controller = Get.put(ShopAddNewProductController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopAddNewProductController>(
      init: ShopAddNewProductController(),
      builder: (ShopAddNewProductController controller) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: Text(
                "Add New Product".tr,
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
                                        Text("No cover image selected".tr),
                                        Gap(4.h),
                                        Text(
                                          "Click to Select image".tr,
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
                                                "Upload Bag Demo".tr,
                                                style: getLightStyle.copyWith(
                                                  color: greyColor,
                                                  fontWeight: FontManager
                                                      .semiBoldFontWeight,
                                                ),
                                              ),
                                              Gap(8.w),
                                              Icon(
                                                Icons.cloud_upload,
                                                size: 20.r,
                                                color: greyColor,
                                              ),
                                            ],
                                          ),
                                          Gap(8.h),
                                          Text(
                                            "${"Accepted files".tr}: pdf, doc, docx, xls, xlsx, csv, txt, zip, rar, ppt, pptx, jpg, jpeg, png, gif, svg",
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
                          Gap(12.h),
                          InkWell(
                            onTap: () => controller.selectBagFile(),
                            child: Container(
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
                                  if (controller.bagFile == null)
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
                                                "Upload Bag".tr,
                                                style: getLightStyle.copyWith(
                                                  color: greyColor,
                                                  fontWeight: FontManager
                                                      .semiBoldFontWeight,
                                                ),
                                              ),
                                              Gap(8.w),
                                              Icon(
                                                Icons.cloud_upload,
                                                size: 20.r,
                                                color: greyColor,
                                              ),
                                            ],
                                          ),
                                          Gap(8.h),
                                          Text(
                                            "${"Accepted files".tr}: pdf, doc, docx, xls, xlsx, csv, txt, zip, rar, ppt, pptx, jpg, jpeg, png, gif, svg",
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
                                        controller.bagFile?.path
                                                .split('/')
                                                .last ??
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
                          Gap(32),
                          TextFormField(
                            controller: controller.titleEnController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Title".tr,
                              hintText: "enter title".tr,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter title".tr;
                              }
                              return null;
                            },
                          ),
                          Gap(24),
                          TextFormField(
                            controller: controller.priceController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Price".tr,
                              hintText: "enter price".tr,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter price".tr;
                              }
                              return null;
                            },
                          ),
                          Gap(24),
                          TextFormField(
                            controller: controller.discountController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: "Discount %".tr,
                              hintText: "enter discount".tr,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter discount".tr;
                              }
                              return null;
                            },
                          ),
                          Gap(24),
                          TextFormField(
                            minLines: null,
                            maxLines: null,
                            controller: controller.descriptionEnController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: "Description".tr,
                              hintText: "enter description".tr,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter description".tr;
                              }
                              return null;
                            },
                          ),
                          Gap(24),
                          TextFormField(
                            minLines: null,
                            maxLines: null,
                            keyboardType: TextInputType.text,
                            controller:
                                controller.termsAndConditionsEnController,
                            decoration: InputDecoration(
                              labelText: "Terms & Conditions".tr,
                              hintText: "enter terms & conditions".tr,
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter terms & conditions".tr;
                              }
                              return null;
                            },
                          ),
                          Gap(24),
                          Row(
                            children: [
                              Text(
                                "Choose Bag Content".tr,
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                          Gap(8),
                          GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 3 / 3.5),
                            itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                controller.bagContent
                                        .contains(controller.allContents[index])
                                    ? controller.deleteBagContent(
                                        controller.allContents[index])
                                    : controller.addBagContent(index);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: controller.bagContent.contains(
                                            controller.allContents[index])
                                        ? primaryColor.withAlpha(30)
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Column(
                                  children: [
                                    Image.network(
                                      controller.allContents[index].image!,
                                      height: 80,
                                    ),
                                    Gap(8),
                                    Text(
                                        translateDatabase(
                                            arabic: controller
                                                .allContents[index].nameAr!,
                                            english: controller
                                                .allContents[index].nameEn!),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: 11.r,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                              ),
                            ),
                            shrinkWrap: true,
                            itemCount: controller.allContents.length,
                            physics: const NeverScrollableScrollPhysics(),
                          ),
                          Gap(24),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            decoration: BoxDecoration(
                                color:
                                    const Color.fromARGB(255, 250, 250, 249)),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Training Sessions".tr,
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    Spacer(),
                                    Material(
                                      color: Colors.white,
                                      shape: const CircleBorder(),
                                      elevation: 1,
                                      child: IconButton(
                                          onPressed: () {
                                            onTapAddSession();
                                          },
                                          icon: Icon(
                                            Icons.add,
                                            color: primaryColor,
                                          )),
                                    )
                                  ],
                                ),
                                Gap(10.h),
                                ExpansionPanelList(
                                  expandedHeaderPadding:
                                      EdgeInsets.only(bottom: 15),
                                  elevation: 1,
                                  materialGapSize: 20.h,
                                  expandIconColor: blackColor,
                                  expansionCallback:
                                      (int index, bool isExpanded) {
                                    controller.callBackFun(index, isExpanded);
                                  },
                                  children: controller.descriptions
                                      .map<ExpansionPanel>(
                                          (ProductDescriptionModel item) {
                                    return ExpansionPanel(
                                        headerBuilder: (BuildContext context,
                                            bool isExpanded) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              color: isExpanded
                                                  ? Colors.indigo.withAlpha(170)
                                                  : null,
                                              gradient: isExpanded
                                                  ? LinearGradient(
                                                      begin: Alignment.topLeft,
                                                      end: Alignment.topRight,
                                                      colors: [
                                                        Colors.indigo
                                                            .withAlpha(60),
                                                        Colors.indigo
                                                            .withAlpha(50),
                                                        Colors.indigo
                                                            .withAlpha(40),
                                                        Colors.indigo
                                                            .withAlpha(30),
                                                        Colors.indigo
                                                            .withAlpha(20),
                                                        Colors.indigo
                                                            .withAlpha(10),
                                                        Colors.transparent,
                                                      ],
                                                    )
                                                  : null,
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15.0,
                                                  right: 8,
                                                  top: 10,
                                                  bottom: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      translateDatabase(
                                                          arabic: item.titleAr!,
                                                          english:
                                                              item.titleEn!),
                                                      style: TextStyle(
                                                        fontSize: 16.r,
                                                        color: blackColor,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                      onTap: () {
                                                        Get.defaultDialog(
                                                            title:
                                                                'Options:'.tr,
                                                            titlePadding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 20,
                                                                    bottom: 10),
                                                            titleStyle: TextStyle(
                                                                fontSize: 17.r,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                            contentPadding:
                                                                EdgeInsets.symmetric(
                                                                    horizontal:
                                                                        20.w),
                                                            content: Column(
                                                              children: [
                                                                ListTile(
                                                                  onTap: () {
                                                                    onTapAddDescription(
                                                                      controller
                                                                          .descriptions
                                                                          .indexWhere(
                                                                        (e) =>
                                                                            e ==
                                                                            item,
                                                                      ),
                                                                    );
                                                                  },
                                                                  leading: Icon(
                                                                      Icons
                                                                          .add),
                                                                  title: Text(
                                                                      "Add new content"
                                                                          .tr),
                                                                ),
                                                                ListTile(
                                                                  onTap: () {
                                                                    controller
                                                                        .deleteSessionDialog(
                                                                            item);
                                                                  },
                                                                  leading: Icon(
                                                                      Icons
                                                                          .delete),
                                                                  title: Text(
                                                                      "delete"
                                                                          .tr),
                                                                ),
                                                              ],
                                                            ));
                                                      },
                                                      child: Icon(
                                                        Icons.more_vert,
                                                        color: const Color
                                                            .fromARGB(
                                                            221, 15, 15, 15),
                                                        size: 17.sp,
                                                      )),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        body: Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 15.0,
                                              left: 20.w,
                                              right: 20.w),
                                          child: ListView.separated(
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            separatorBuilder:
                                                (context, index) => Gap(10),
                                            itemCount: item.contents!.length,
                                            itemBuilder: (context, i) => Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Icon(
                                                    Icons.check_circle,
                                                    size: 17.sp,
                                                    color: greenColor,
                                                  ),
                                                ),
                                                Gap(10.w),
                                                Expanded(
                                                  child: Text(
                                                    translateDatabase(
                                                        arabic: item
                                                            .contents![i]
                                                            .contentAr!,
                                                        english: item
                                                            .contents![i]
                                                            .contentEn!),
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      color: blackColor,
                                                    ),
                                                  ),
                                                ),
                                                Gap(5.w),
                                                InkWell(
                                                    onTap: () {
                                                      Get.defaultDialog(
                                                          title: 'Options:'.tr,
                                                          titlePadding:
                                                              const EdgeInsets
                                                                  .only(
                                                                  top: 20,
                                                                  bottom: 10),
                                                          titleStyle: TextStyle(
                                                              fontSize: 17.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                          contentPadding:
                                                              EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          20.w),
                                                          content: Column(
                                                            children: [
                                                              ListTile(
                                                                onTap: () {
                                                                  controller.deleteDescriptionDialog(
                                                                      item,
                                                                      item.contents![
                                                                          i]);
                                                                },
                                                                leading: Icon(
                                                                    Icons
                                                                        .delete),
                                                                title: Text(
                                                                    "delete"
                                                                        .tr),
                                                              ),
                                                            ],
                                                          ));
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: Icon(
                                                        Icons.settings,
                                                        size: 15.sp,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                        ),
                                        isExpanded: item.isExpanded == 0
                                            ? false
                                            : true);
                                  }).toList(),
                                ),
                              ],
                            ),
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
                    text: 'Add'.tr,
                  ),
                ],
              ),
            ));
      },
    );
  }

  Future onTapAddSession() {
    return Get.defaultDialog(
      title: 'Add new Session'.tr,
      titlePadding: const EdgeInsets.only(top: 20, bottom: 10),
      titleStyle: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controller.sessionTitleEnController,
              decoration: InputDecoration(hintText: 'enter title'.tr),
            ),
            Gap(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: Text(
                    'Cancel'.tr,
                    style:
                        TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    controller.onCancelAddSession();
                  },
                ),
                TextButton(
                  child: Text(
                    'Add'.tr,
                    style:
                        TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    controller.addSession();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future onTapAddDescription(int index) {
    return Get.defaultDialog(
      title: 'Add Content'.tr,
      titlePadding: const EdgeInsets.only(top: 20, bottom: 10),
      titleStyle: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w500),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      content: Form(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controller.sessionDescriptionEnController,
              decoration: InputDecoration(hintText: 'enter description'.tr),
            ),
            Gap(20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  child: Text(
                    'Cancel'.tr,
                    style:
                        TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    controller.onCancelAddDescription();
                  },
                ),
                TextButton(
                  child: Text(
                    'Add'.tr,
                    style:
                        TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w500),
                  ),
                  onPressed: () {
                    controller.addDescription(index);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
