import 'package:b2b_partnership_admin/core/global/widgets/custom_server_status_widget.dart';

import '../../../controller/manage_users/provider_profile/provider_profile_controller.dart';
import '/core/theme/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProviderProfileController());
    return GetBuilder<ProviderProfileController>(builder: (controller) {
      return CustomServerStatusWidget(
        statusRequest: controller.statusRequestReview,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(16),
          itemCount: controller.reviews.length,
          itemBuilder: (context, index) {
            final review = controller.reviews[index];
            return Container(
                color: Colors.white,
                margin: EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: controller.getRandomColor(),
                      child: Text(review.name![0],
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    Gap(15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(review.name!,
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold)),
                              InkWell(
                                onTap: () {
                                  controller.deleteReviewDialog(review.id!);
                                },
                                child: Icon(
                                  Icons.remove_circle,
                                  color: primaryColor,
                                ),
                              )
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(5, (index) {
                              return Icon(
                                index < int.parse(review.rating!)
                                    ? Icons.star
                                    : Icons.star_border,
                                color: starColor,
                                size: 15.sp,
                              );
                            }),
                          ),
                          Text(
                            review.review!,
                            style: TextStyle(fontSize: 13.sp),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          )
                        ],
                      ),
                    )
                  ],
                ));
          },
        ),
      );
    });
  }
}
