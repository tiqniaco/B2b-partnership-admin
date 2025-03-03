import 'package:b2b_partnership_admin/views/shop/shop_view.dart';

import 'admin_home_controller.dart';
import '/controller/settings/setting_controller.dart';
import '../../views/home/admin_home_view.dart';
import '../../views/manage_users/users_view.dart';
import '/views/settings/settings_view.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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

  final screens = [
    AdminHomeView(),
    const ShopView(),
    Container(),
    const UsersView(),
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
