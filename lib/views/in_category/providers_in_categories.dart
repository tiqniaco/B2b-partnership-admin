import '/app_routes.dart';
import '/controller/in_category/providers_in_category_controller.dart';
import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
import '/widgets/home/provider_widget.dart';
import '/widgets/home/search_widget.dart';
import '/widgets/home/sub_category_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProvidersInCategories extends StatefulWidget {
  const ProvidersInCategories({super.key});

  @override
  State<ProvidersInCategories> createState() => _ProvidersInCategoriesState();
}

class _ProvidersInCategoriesState extends State<ProvidersInCategories>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Get.put(ProvidersInCategoryController());
    return GetBuilder<ProvidersInCategoryController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          automaticallyImplyLeading: false,
          titleSpacing: 20,
          title: Row(
            children: [
              InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.arrow_back_ios)),
              Gap(5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Category!",
                      style: TextStyle(fontSize: 13.sp, color: greyColor),
                    ),
                    Text(
                      translateDatabase(
                          arabic: controller.specialization.nameAr!,
                          english: controller.specialization.nameEn!),
                      style: TextStyle(fontSize: 16.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            Container(
              height: 42.h,
              width: 42.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  controller.specialization.image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Gap(20)
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SearchWidget(
                onTap: () {
                  Get.toNamed(AppRoutes.search);
                },
              ),
            ),
            Gap(5),
            FractionallySizedBox(
              widthFactor: 1,
              child: Divider(),
            ),
            Gap(5),
            SizedBox(
              height: 47,
              child: SubCategoryWidget(
                subSpecializations: controller.subSpecializations,
              ),
            ),
            Gap(15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text("${controller.providers.length} providers founded",
                  style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp)),
            ),
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
              itemCount: controller.providers.length,
              itemBuilder: (context, index) => ProviderWidget(
                  provider: controller.providers[index],
                  toggleFavorite: () {
                    controller.toggleFavorites(
                        controller.providers[index].providerId.toString());
                  }),
            )),
          ],
        ),
      );
    });
  }
}
