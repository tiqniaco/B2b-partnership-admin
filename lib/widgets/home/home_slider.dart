import '/controller/home/home_client_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeSliders extends StatefulWidget {
  const HomeSliders({super.key});

  @override
  State<HomeSliders> createState() => _HomeSlidersState();
}

class _HomeSlidersState extends State<HomeSliders> {
  CarouselSliderController carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    Get.put(HomeClientController());
    return GetBuilder<HomeClientController>(
      id: "slider",
      builder: (controller) {
        if (controller.banners.isEmpty) {
          return const SizedBox(); // Return an empty widget if no banners are loaded
        }
        return SizedBox(
          height: 150.h,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  child: SizedBox(
                    height: height / 1.4,
                    child: CarouselSlider.builder(
                      carouselController: carouselController,
                      options: CarouselOptions(
                        viewportFraction: 0.9,
                        onPageChanged: (index, reson) {
                          controller.changeSlider(index);
                        },
                        aspectRatio: 30 / 9,
                        animateToClosest: true,
                        height: height / 1.4,
                        autoPlay: true,
                        padEnds: true,
                        enableInfiniteScroll: true,
                        autoPlayInterval: const Duration(seconds: 7),
                      ),
                      itemCount: controller.banners.length,
                      itemBuilder: (context, index, realindex) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: CachedNetworkImageProvider(
                                controller.banners[index].image!,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
