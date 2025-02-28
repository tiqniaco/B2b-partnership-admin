import 'admin_home_controller.dart';
import '/controller/settings/setting_controller.dart';
import '../../views/home/admin_home_view.dart';
import '/views/orders/orders_view.dart';
import '/views/save/save_view.dart';
import '/views/search/search_view.dart';
import '/views/settings/settings_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '/core/localization/app_strings.dart';
import 'package:get/get.dart';

class AdminHomeLayoutController extends GetxController {
  late TabController convexController;

  AdminHomeLayoutController(
    TickerProvider vsync,
  ) : convexController = TabController(
          length: 5,
          vsync: vsync,
        );

  int get currentIndex => convexController.index;

  final bottomNavItems = [
    HomeBottomNavModel(
      icon: "assets/svgs/home.svg",
      label: AppStrings.home.tr,
      index: 0,
    ),
    HomeBottomNavModel(
      icon: "assets/svgs/bag2.svg",
      label: "Orders".tr,
      index: 1,
    ),
    HomeBottomNavModel(
      icon: "",
      label: "Search".tr,
      index: 2,
    ),
    HomeBottomNavModel(
      icon: "assets/svgs/save.svg",
      label: "Saved".tr,
      index: 2,
    ),
    HomeBottomNavModel(
      icon: "assets/svgs/setting.svg",
      label: "Menu".tr,
      index: 4,
    ),
  ];

  final screens = [
    AdminHomeView(),
    const OrdersView(),
    const SearchView(),
    const SaveView(),
    const SettingsView(),
  ];

  onBNavPressed(int index) {
    convexController.animateTo(index);
    update();
  }

  @override
  Future<void> onInit() async {
    await Get.put(SettingController()).getMenuModel().then((value) {
      Get.put(AdminHomeController()).update();
    });
    convexController.addListener(() {
      onBNavPressed(convexController.index);
    });
    update();
    super.onInit();
  }
}

class HomeBottomNavModel extends Equatable {
  final String label;
  final String icon;
  final int index;

  const HomeBottomNavModel({
    required this.label,
    required this.icon,
    required this.index,
  });

  @override
  List<Object?> get props => [label, icon, index];
}
