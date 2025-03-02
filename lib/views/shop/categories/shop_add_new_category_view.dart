import 'package:b2b_partnership_admin/controller/shop/shop_add_new_category_controller.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_loading_button.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ShopAddNewCategoryView extends StatelessWidget {
  const ShopAddNewCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ShopAddNewCategoryController>(
      init: ShopAddNewCategoryController(),
      builder: (ShopAddNewCategoryController controller) => Scaffold(
        appBar: AppBar(
          title: const Text('Add New Category'),
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
                    child: controller.image == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                Gap(16.h),
                TextFormField(
                  controller: controller.nameArController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Name (Arabic)",
                    hintText: "enter name (Arabic)",
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter name (Arabic)";
                    }
                    return null;
                  },
                ),
                Gap(10.h),
                TextFormField(
                  controller: controller.nameEnController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Name (English)",
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
            text: "Add".tr,
          ),
        ),
      ),
    );
  }
}
