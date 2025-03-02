import '/core/functions/translate_database.dart';
import '/core/theme/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class JobWidget extends StatelessWidget {
  const JobWidget({
    super.key,
    //required this.spacializations
  });
  //final List<SpacializModel> spacializations;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20),
        itemCount: 5,
        separatorBuilder: (context, index) => Gap(20),
        itemBuilder: (context, index) => Container(
              width: 250.h,
              height: 190.h,
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.withAlpha(90))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl:
                              "https://www.nutsvolts.com/uploads/articles/NV_0704_Christopherson_Large.jpg",
                          height: 70.h,
                          width: 75.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translateDatabase(
                                  arabic:
                                      "Are you looking some who able to rich you business",
                                  english:
                                      "Are you looking some who able to rich you business"),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Gap(5),
                  Divider(),
                  Gap(3),
                  Row(
                    children: [
                      Text(
                        "Starts from :  ",
                        style: TextStyle(fontSize: 15.sp, color: greyColor),
                      ),
                      Text(
                        "\$ 150",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.sp),
                      ),
                    ],
                  )
                ],
              ),
            ));
  }
}
