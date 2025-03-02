import '/controller/search/search_controller.dart';
import '/core/global/widgets/custom_server_status_widget.dart';
import '/core/theme/app_color.dart';
import '../../widgets/manage_category/provider_widget.dart';
import '/widgets/search/select_city_filter.dart';
import '/widgets/search/select_country_filter.dart';
import '/widgets/search/select_specialization_filter.dart';
import '/widgets/search/select_sup_specialization_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SearchControllerIM());
    return GetBuilder<SearchControllerIM>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: whiteColor,
          title: TextFormField(
            decoration: InputDecoration(
                filled: true,
                fillColor: borderColor.withAlpha(30),
                contentPadding: EdgeInsets.all(14),
                hintStyle: TextStyle(fontSize: 14.sp),
                hintText: "Search ...",
                suffixIcon: InkWell(
                  onTap: () {
                    controller.search();
                  },
                  child: Icon(
                    Icons.search,
                    color: greyColor,
                  ),
                )),
          ),
        ),
        body: Form(
          key: controller.formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(15),
                    SizedBox(
                      height: 40,
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 10,
                            childAspectRatio: 3.4 / 9.7),
                        scrollDirection: Axis.horizontal,
                        children: [
                          customWidget(Icons.star_border_rounded, "Rating", () {
                            showRatingSheet(context);
                          }),
                          customWidget(Icons.location_on_outlined, "Location",
                              () {
                            showLocationSheet(context);
                          }),
                          customWidget(Icons.category_outlined, "Category", () {
                            showCategorySheet(context);
                          }),
                          customWidget(CupertinoIcons.refresh_thin, "Reset",
                              () {
                            controller.resetFunction();
                          })
                        ],
                      ),
                    ),
                    Gap(10),
                    controller.isSearch
                        ? Text(
                            "${controller.searchList.length} provider",
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.normal),
                          )
                        : Text(
                            "${controller.topProviders.length} provider",
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.normal),
                          ),
                    Gap(10),
                  ],
                ),
              ),
              Expanded(
                  child: CustomServerStatusWidget(
                statusRequest: controller.isSearch
                    ? controller.statusRequestSearch
                    : controller.statusRequest,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 10,
                      childAspectRatio: 6 / 9.8),
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  itemCount: controller.isSearch
                      ? controller.searchList.length
                      : controller.topProviders.length,
                  itemBuilder: (context, index) => controller.isSearch
                      ? ProviderWidget(
                          provider: controller.searchList[index],
                          toggleFavorite: () {
                            controller.toggleFavorites(controller
                                .searchList[index].providerId
                                .toString());
                          })
                      : ProviderWidget(
                          provider: controller.topProviders[index],
                          toggleFavorite: () {
                            controller.toggleFavorites(controller
                                .topProviders[index].providerId
                                .toString());
                          }),
                ),
              )),
            ],
          ),
        ),
      );
    });
  }

  Widget customWidget(IconData icon, String title, Function() onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: greyColor.withAlpha(150))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(color: blackColor, fontWeight: FontWeight.w500),
            ),
            Gap(5),
            Icon(
              Icons.keyboard_arrow_down_outlined,
              color: blackColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonWidget(String title, Function() onTap, bool active) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 9),
        decoration: BoxDecoration(
            color: active ? primaryColor : Colors.transparent,
            border: Border.all(color: greyColor),
            borderRadius: BorderRadius.circular(5)),
        child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 13.sp,
              color: active ? whiteColor : blackColor),
        ),
      ),
    );
  }

  showRatingSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => GetBuilder<SearchControllerIM>(
            id: "rating",
            builder: (ratingController) {
              return Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: borderColor, width: 1),
                    color: borderColor.withAlpha(20),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 40,
                        child: Divider(
                          thickness: 4,
                          color: greyColor,
                        ),
                      ),
                    ),
                    Gap(6),
                    Text(
                      "Rating Filter:",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w500),
                    ),
                    Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          //ignoreGestures: true,
                          itemSize: 25.sp,
                          initialRating: ratingController.rating,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 1.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            ratingController.onTapRating(rating);
                          },
                        ),
                        Gap(20),
                        IconButton(
                            onPressed: () {
                              ratingController.resetRating();
                            },
                            icon: Icon(
                              CupertinoIcons.refresh,
                              color: greyColor,
                              size: 25.sp,
                            ))
                      ],
                    ),
                    Gap(30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: buttonWidget("Clear Filter", () {
                              ratingController.resetRating();
                            }, false),
                          ),
                          Gap(20),
                          Expanded(
                            child: buttonWidget("Apply Filter", () {
                              ratingController.search();
                            }, true),
                          )
                        ],
                      ),
                    ),
                    Gap(50)
                  ],
                ),
              );
            }));
  }

  showLocationSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => GetBuilder<SearchControllerIM>(
            id: "location",
            builder: (locationController) {
              return Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: borderColor, width: 1),
                    color: borderColor.withAlpha(20),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 40,
                        child: Divider(
                          thickness: 4,
                          color: greyColor,
                        ),
                      ),
                    ),
                    Gap(6),
                    Text(
                      "Location Filter:",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w500),
                    ),
                    Gap(30),
                    SelectCountryFilter(
                      enabled: false,
                    ),
                    Gap(30),
                    SelectCityFilter(),
                    Gap(30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: buttonWidget("Clear Filter", () {
                              locationController.resetLocation();
                            }, false),
                          ),
                          Gap(20),
                          Expanded(
                            child: buttonWidget("Apply Filter", () {
                              locationController.search();
                            }, true),
                          )
                        ],
                      ),
                    ),
                    Gap(50)
                  ],
                ),
              );
            }));
  }

  showCategorySheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) => GetBuilder<SearchControllerIM>(
            id: "category",
            builder: (categoryController) {
              return Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(color: borderColor, width: 1),
                    color: borderColor.withAlpha(20),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: SizedBox(
                        width: 40,
                        child: Divider(
                          thickness: 4,
                          color: greyColor,
                        ),
                      ),
                    ),
                    Gap(6),
                    Text(
                      "Category Filter:",
                      style: TextStyle(
                          fontSize: 15.sp, fontWeight: FontWeight.w500),
                    ),
                    Gap(30),
                    SelectSpecializationFilter(),
                    Gap(30),
                    SelectSupSpecializationFilter(),
                    Gap(30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: buttonWidget("Clear Filter", () {
                              categoryController.resetCategory();
                            }, false),
                          ),
                          Gap(20),
                          Expanded(
                            child: buttonWidget("Apply Filter", () {
                              categoryController.search();
                            }, true),
                          )
                        ],
                      ),
                    ),
                    Gap(50)
                  ],
                ),
              );
            }));
  }
}
