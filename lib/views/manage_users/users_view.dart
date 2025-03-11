// ignore_for_file: deprecated_member_use

import 'package:b2b_partnership_admin/app_routes.dart';
import 'package:b2b_partnership_admin/widgets/block_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../controller/manage_users/manage_users_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(UsersController());
    return Scaffold(
      body: Builder(builder: (context) {
        return SafeArea(
          child: GetBuilder<UsersController>(builder: (controller) {
            return ListView(
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
                    blockWidget(
                        Colors.green, "Clients".tr, CupertinoIcons.person_2_fill,
                        () {
                      Get.toNamed(AppRoutes.manageClients);
                    }),
                    blockWidget(
                        Colors.orange, "Providers".tr, FontAwesomeIcons.userTie,
                        () {
                      Get.toNamed(AppRoutes.manageProviders);
                    }),
                    blockWidget(
                        Colors.brown, "Admins".tr, Icons.admin_panel_settings, () {
                      Get.toNamed(AppRoutes.manageAdmins);
                    }),
                  ],
                ),
                Gap(50)
              ],
            );
          }),
        );
      }),
    );
  }
}
