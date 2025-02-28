import '/controller/see_all/see_all_controller.dart';
import '/core/theme/app_color.dart';
import '/widgets/home/provider_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SeeAll extends StatelessWidget {
  const SeeAll({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SeeAllController());
    return GetBuilder<SeeAllController>(
      builder: (controller) => Scaffold(
          appBar: AppBar(
            backgroundColor: whiteColor,
            title: Text(controller.title),
          ),
          body: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 10,
                childAspectRatio: 6 / 9.8),
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 15),
            itemCount: controller.providers.length,
            itemBuilder: (context, index) => ProviderWidget(
                provider: controller.providers[index],
                toggleFavorite: () {
                  controller.toggleFavorites(
                      controller.providers[index].providerId.toString());
                }),
          )),
    );
  }
}
