import 'package:b2b_partnership_admin/app_routes.dart';
import 'package:b2b_partnership_admin/controller/home/admin_home_controller.dart';
import 'package:b2b_partnership_admin/core/utils/assets_data.dart';
import 'package:b2b_partnership_admin/widgets/block_widget.dart';

import '/controller/settings/setting_controller.dart';
import '/core/theme/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class AdminHomeView extends StatefulWidget {
  const AdminHomeView({super.key});

  @override
  State<AdminHomeView> createState() => _AdminHomeViewState();
}

class _AdminHomeViewState extends State<AdminHomeView>
    with TickerProviderStateMixin {
  final settingController = Get.put(SettingController());
  @override
  Widget build(BuildContext context) {
    Get.put(AdminHomeController());
    return GetBuilder<AdminHomeController>(
      builder: (AdminHomeController controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: whiteColor,
            automaticallyImplyLeading: false,
            titleSpacing: 20,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome!",
                  style: TextStyle(fontSize: 13.sp, color: greyColor),
                ),
                Text(
                  settingController.menuModel?.data?.name ?? "",
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
            actions: [
              Container(
                height: 42.h,
                width: 42.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: settingController.menuModel?.data?.image ?? "",
                    errorWidget: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[200],
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                        ),
                        child: Image.asset(
                          AssetsData.manIconImage,
                          fit: BoxFit.contain,
                        ),
                      );
                    },
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Gap(20)
            ],
          ),
          body: ListView(
            children: [
              Gap(10.h),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(
                  thickness: 1,
                ),
              ),
              Gap(10.h),
              GridView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 20,
                    childAspectRatio: 7 / 6.5),
                children: [
                  blockWidget(Colors.orange, "Categories", Icons.category, () {
                    Get.toNamed(AppRoutes.manageCategory);
                  }),
                  blockWidget(Colors.indigo, "Provider Types",
                      CupertinoIcons.person_2_fill, () {
                    Get.toNamed(AppRoutes.manageProviderTypes);
                  }),
                  blockWidget(Colors.teal, "Locations", CupertinoIcons.map_fill,
                      () {
                    Get.toNamed(AppRoutes.manageLocations);
                  }),
                  blockWidget(Colors.brown, "Products",
                      CupertinoIcons.cart_fill, () {}),
                  blockWidget(
                      Colors.pink, "Services", CupertinoIcons.cart_fill, () {}),
                  blockWidget(Colors.cyan, "Categories",
                      CupertinoIcons.cart_fill, () {})
                ],
              ),
              Gap(50)
            ],
          ),
        );
      },
    );
  }
}
