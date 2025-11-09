import '/app_routes.dart';
import '/core/theme/app_color.dart';
import '/models/provider_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pannable_rating_bar/flutter_pannable_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ProviderWidgetItem extends StatelessWidget {
  const ProviderWidgetItem(
      {super.key, required this.provider, required this.toggleFavorite});
  final ProviderModel provider;
  final void Function() toggleFavorite;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.providerProfile,
            arguments: {"id": provider.providerId.toString()});
      },
      child: Container(
        width: 145.h,
        height: 120.h,
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.withAlpha(80))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: provider.image,
                    height: 70.h,
                    width: 85.h,
                    fit: BoxFit.cover,
                  ),
                ),
                Gap(5),
                Column(
                  children: [
                    Text(
                      provider.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    PannableRatingBar(
                      rate: double.parse(provider.rating),
                      items: List.generate(
                          5,
                          (index) => RatingWidget(
                                selectedColor: Colors.amber,
                                unSelectedColor: Colors.grey,
                                child: Icon(
                                  Icons.star,
                                  size: 15.sp,
                                ),
                              )),
                      onHover: (value) {},
                    ),
                    Text(
                      provider.bio,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ],
            ),
            Gap(9),
            Divider(),
            Gap(9),
            Row(
              children: [
                Row(
                  children: [
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[200]!)),
                        padding: EdgeInsets.all(10),
                        child: provider.isFavorite == "1"
                            ? InkWell(
                                onTap: toggleFavorite,
                                child: Icon(
                                  size: 20.sp,
                                  Icons.bookmarks,
                                  color: primaryColor,
                                ),
                              )
                            : InkWell(
                                onTap: toggleFavorite,
                                child: Icon(
                                  size: 20.sp,
                                  Icons.bookmarks_outlined,
                                  color: Colors.black54,
                                ),
                              ),
                      ),
                    ),
                    Gap(15),
                    SizedBox(
                      width: 80.w,
                      height: 32.h,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.providerProfile, arguments: {
                              "id": provider.providerId.toString()
                            });
                          },
                          child: Text(
                            "View",
                            style: TextStyle(
                                fontSize: 11.sp, fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
