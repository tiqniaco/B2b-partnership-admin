import '/app_routes.dart';
import '/controller/provider/home/provider_home_controller.dart';
import '/controller/provider/home/provider_home_layout_controller.dart';
import '/controller/provider/setting/provider_setting_controller.dart';
import '/core/global/widgets/custom_server_status_widget.dart';
import '/core/theme/app_color.dart';
import '/widgets/home/banner_widget.dart';
import '/widgets/home/category_widget.dart';
import '/widgets/home/home_row_widget.dart';
import '/widgets/home/home_slider.dart';
import '/widgets/home/provider_widget.dart';
import '/widgets/home/search_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProviderHomeView extends StatefulWidget {
  const ProviderHomeView({super.key});

  @override
  State<ProviderHomeView> createState() => _ProviderHomeViewState();
}

class _ProviderHomeViewState extends State<ProviderHomeView>
    with TickerProviderStateMixin {
  final settingController = Get.put(ProviderSettingController());
  @override
  Widget build(BuildContext context) {
    Get.put(ProviderHomeController());
    return GetBuilder<ProviderHomeController>(
      builder: (ProviderHomeController controller) {
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
                    errorWidget: (context, url, error) =>
                        Icon(CupertinoIcons.person),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Gap(20)
            ],
          ),
          body: ListView(
            children: [
              Gap(25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SearchWidget(
                  onTap: () {
                    Get.put(ProviderHomeLayoutController(this))
                        .onBNavPressed(2);
                  },
                ),
              ),
              Gap(5),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(10),
              CustomServerStatusWidget(
                  statusRequest: controller.statusRequestBanner,
                  child: HomeSliders()),
              Gap(25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: HomeRowWidget(
                  title: "Browse categories",
                  onTap: () {
                    Get.toNamed(AppRoutes.seeAllCategories,
                        arguments: {"categories": controller.specializations});
                  },
                ),
              ),
              Gap(18),
              SizedBox(
                  height: 120.h,
                  child: CustomServerStatusWidget(
                    statusRequest: controller.statusRequestSpecialization,
                    child: CategoryWidget(
                        specializations: controller.specializations),
                  )),
              Gap(30),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: HomeRowWidget(
                  title: "Top Rated Providers",
                  onTap: () {
                    Get.toNamed(AppRoutes.seeAll, arguments: {
                      "providers": controller.topProviders,
                      "title": "Top Rated Provider"
                    });
                  },
                ),
              ),
              Gap(10),
              SizedBox(
                  height: 235.h,
                  child: CustomServerStatusWidget(
                      statusRequest: controller.statusRequestProviders,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: controller.topProviders.length,
                        separatorBuilder: (context, index) => Gap(20),
                        itemBuilder: (context, index) => ProviderWidget(
                          provider: controller.topProviders[index],
                          toggleFavorite: () {
                            controller.toggleFavorites(
                                controller.topProviders[index].providerId!);
                          },
                        ),
                      ))),
              Gap(10),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(25),
              BannerWidget(
                image: "assets/images/man.jpeg",
                title: "Freelance Services!!",
                onPressed: () {
                  Get.put(ProviderHomeLayoutController(this)).onBNavPressed(1);
                },
                description:
                    "You can browse the services available \n for freelance work",
                buttonTitle: 'View Now',
              ),
              Gap(15),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(45),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: HomeRowWidget(
                  title: "Egypt Top Rated",
                  onTap: () {
                    Get.toNamed(AppRoutes.seeAll, arguments: {
                      "providers": controller.topEgypt,
                      "title": "Egypt Top Rated"
                    });
                  },
                ),
              ),
              Gap(15),
              SizedBox(
                  height: 235.h,
                  child: CustomServerStatusWidget(
                      statusRequest: controller.statusRequestProviders,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: controller.topEgypt.length,
                        separatorBuilder: (context, index) => Gap(20),
                        itemBuilder: (context, index) => ProviderWidget(
                          provider: controller.topEgypt[index],
                          toggleFavorite: () {
                            controller.toggleFavorites(
                                controller.topEgypt[index].providerId!);
                          },
                        ),
                      ))),
              Gap(15),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(25),
              BannerWidget(
                image: "assets/images/job.jpeg",
                title: "Need employees?",
                onPressed: () {
                  // Get.toNamed(AppRoutes.getRequestServices);
                },
                description: "You can add the available\njob for recruitment",
                buttonTitle: 'Add Now',
              ),
              //JobBannerWidget(),
              Gap(55),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: HomeRowWidget(
                  title: "Saudi Arabia Top Rated",
                  onTap: () {
                    Get.toNamed(AppRoutes.seeAll, arguments: {
                      "providers": controller.topSaudi,
                      "title": "Saudi Arabia Top Rated"
                    });
                  },
                ),
              ),
              Gap(20),
              SizedBox(
                  height: 235.h,
                  child: CustomServerStatusWidget(
                      statusRequest: controller.statusRequestProviders,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: controller.topSaudi.length,
                        separatorBuilder: (context, index) => Gap(20),
                        itemBuilder: (context, index) => ProviderWidget(
                          provider: controller.topSaudi[index],
                          toggleFavorite: () {
                            controller.toggleFavorites(
                                controller.topSaudi[index].providerId!);
                          },
                        ),
                      ))),
              Gap(35),
              FractionallySizedBox(
                widthFactor: 1,
                child: Divider(),
              ),
              Gap(25),
              BannerWidget(
                image: "assets/images/product.jpeg",
                title: "Shopping?",
                onPressed: () {
                  Get.toNamed(AppRoutes.shop);
                },
                description: "Order whatever you need\nfrom the shop",
                buttonTitle: 'Order Now',
              ),
              Gap(45),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: HomeRowWidget(
                  title: "UAE Top Rated",
                  onTap: () {
                    Get.toNamed(AppRoutes.seeAll, arguments: {
                      "providers": controller.topUAE,
                      "title": "UAE Top Rated"
                    });
                  },
                ),
              ),
              Gap(20),
              SizedBox(
                  height: 235.h,
                  child: CustomServerStatusWidget(
                      statusRequest: controller.statusRequestProviders,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        itemCount: controller.topUAE.length,
                        separatorBuilder: (context, index) => Gap(20),
                        itemBuilder: (context, index) => ProviderWidget(
                            provider: controller.topUAE[index],
                            toggleFavorite: () {
                              controller.toggleFavorites(
                                  controller.topUAE[index].providerId!);
                            }),
                      ))),
              // TextButton(
              //     onPressed: () {
              //       Get.toNamed(AppRoutes.providerHomeLayout);
              //     },
              //     child: Text("Clients")),
              Gap(50)
            ],
          ),
        );
      },
    );
  }

  containerWidget(Color bgColor, String title) {
    return Container(
      // margin: EdgeInsets.all(5),
      height: 130.h,
      width: 94.h,
      decoration: BoxDecoration(
          color: bgColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                color: whiteColor, // const Color.fromARGB(255, 239, 229, 229),
                shape: BoxShape.circle),
            child: Image.asset(
              "assets/images/job.png",
              height: 50.h,
              width: 50.h,
            ),
          ),
          Gap(10),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
              color: blackColor,
            ),
          )
        ],
      ),
    );
  }
}
