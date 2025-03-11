import 'package:b2b_partnership_admin/controller/shop/category/shop_edit_category_controller.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ShopEditCategoryView extends StatelessWidget {
  const ShopEditCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopEditCategoryController>(
      init: ShopEditCategoryController(),
      builder: (ShopEditCategoryController controller) => Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          title: Text('Edit Category'.tr),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 10.h,
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 10.h,
                    ),
                    child: controller.image == null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              controller.model!.image,
                              fit: BoxFit.contain,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              controller.image!,
                              fit: BoxFit.contain,
                            ),
                          ),
                  ),
                ),
                Gap(26.h),
                TextFormField(
                  controller: controller.nameArController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Name in Arabic".tr,
                    hintText: "enter name (Arabic)",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter name (Arabic)";
                    }
                    return null;
                  },
                ),
                Gap(20.h),
                TextFormField(
                  controller: controller.nameEnController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Name in English".tr,
                    hintText: "enter name (English)",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter name (English)";
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          child: CustomLoadingButton(
            onPressed: () {
              return controller.addNewCategory();
            },
            text: "Edit".tr,
          ),
        ),
      ),
    );
  }
}
