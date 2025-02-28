import '/app_routes.dart';
import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
import '/models/specialize_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({super.key, required this.specializations});
  final List<SpecializeModel> specializations;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: specializations.length,
        separatorBuilder: (context, index) => Gap(20),
        itemBuilder: (context, index) => InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.providersInCategory,
                    arguments: {"model": specializations[index]});
              },
              child: Container(
                width: 100.h,
                height: 120.h,
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.withAlpha(80))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // border: Border.all(color: primaryColor, width: 0.5),
                          color: pageColor.withAlpha(60)),
                      child: CachedNetworkImage(
                        imageUrl: specializations[index].image!,
                        height: 32.h,
                      ),
                    ),
                    Gap(8),
                    Text(
                      translateDatabase(
                          arabic: specializations[index].nameAr!,
                          english: specializations[index].nameEn!),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 12.sp, fontWeight: FontWeight.w400),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ));
  }
}
