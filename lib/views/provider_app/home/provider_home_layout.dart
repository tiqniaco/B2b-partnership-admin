// ignore_for_file: deprecated_member_use

import '/controller/provider/home/provider_home_layout_controller.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '/core/theme/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProviderHomeLayout extends StatefulWidget {
  const ProviderHomeLayout({super.key});

  @override
  State<ProviderHomeLayout> createState() => _ProviderHomeLayoutState();
}

class _ProviderHomeLayoutState extends State<ProviderHomeLayout>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProviderHomeLayoutController>(
      init: ProviderHomeLayoutController(this),
      builder: (controller) => Scaffold(
        backgroundColor: backgroundColor,
        body: TabBarView(
          controller: controller.convexController,
          children: [
            ...controller.screens,
          ],
        ),
        bottomNavigationBar: ConvexAppBar(
          controller: controller.convexController,
          top: -30,
          height: 60.h,
          style: TabStyle.fixedCircle,
          backgroundColor: whiteColor,
          color: unSelectedBNavColor,
          activeColor: primaryColor,
          curveSize: 140,
          items: [
            TabItem(
              icon: SvgPicture.asset("assets/svgs/home.svg",
                  height: 20.sp,
                  color: controller.currentIndex == 0
                      ? primaryColor
                      : unSelectedBNavColor),
              title: "Home",
            ),
            TabItem(
              icon: Icon(
                  CupertinoIcons
                      .news, //SvgPicture.asset("assets/svgs/bag2.svg",
                  // height: 20.sp,
                  color: controller.currentIndex == 1
                      ? primaryColor
                      : unSelectedBNavColor),
              title: "Posts",
            ),
            TabItem(
              icon: Container(
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: primaryColor),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 6.0, right: 7),
                    child: SvgPicture.asset("assets/svgs/search.svg",
                        height: 20.sp, color: Colors.white),
                  ),
                ),
              ),
              title: "Search",
            ),
            TabItem(
              icon: SvgPicture.asset("assets/svgs/save.svg",
                  height: 20.sp,
                  color: controller.currentIndex == 3
                      ? primaryColor
                      : unSelectedBNavColor),
              title: "My Services",
            ),
            TabItem(
              icon: SvgPicture.asset("assets/svgs/setting.svg",
                  height: 20.sp,
                  color: controller.currentIndex == 4
                      ? primaryColor
                      : unSelectedBNavColor),
              title: "Menu",
            ),
          ],
          initialActiveIndex: controller.currentIndex,
          onTap: (index) => controller.onBNavPressed(index),
        ),
      ),
    );
  }
}
