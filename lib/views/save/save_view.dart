// ignore_for_file: deprecated_member_use

import '/controller/save/saved_controller.dart';
import '/core/theme/app_color.dart';
import '/widgets/home/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SaveView extends StatelessWidget {
  const SaveView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SavedController());
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor,
        title: Text(
          "Saved Providers",
          style: TextStyle(color: whiteColor, fontWeight: FontWeight.w400),
        ),
      ),
      body: GetBuilder<SavedController>(builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10.0, bottom: 5, left: 10, right: 10),
              child: Row(
                children: [
                  Text(
                    controller.favorites.length.toString(),
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                  ),
                  Gap(10),
                  Text(
                    "Saved Providers",
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            Divider(),
            Gap(10),
            Expanded(
                child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 10,
                  childAspectRatio: 6 / 9.8),
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 15),
              itemCount: controller.favorites.length,
              itemBuilder: (context, index) => ProviderWidget(
                  provider: controller.favorites[index],
                  toggleFavorite: () {
                    controller.onTapFavorite(
                        controller.favorites[index].providerId.toString());
                  }),
            )),
          ],
        );
      }),
    );
  }
}
