import '/controller/service_details_controller.dart';
import '/core/functions/translate_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FeatureWidget extends StatelessWidget {
  const FeatureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ServiceDetailsController());
    return GetBuilder<ServiceDetailsController>(builder: (controller) {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 16),
        itemCount: controller.serviceFeatures.length,
        itemBuilder: (context, index) {
          final feature = controller.serviceFeatures[index];
          return FeaturItem(
            feature: translateDatabase(
                arabic: feature.featureAr!, english: feature.featureEn!),
          );
        },
      );
    });
  }
}

class FeaturItem extends StatelessWidget {
  final String feature;

  const FeaturItem({
    super.key,
    required this.feature,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        margin: EdgeInsets.only(bottom: 5),
        child: Row(
          children: [
            Icon(
              Icons.check,
              color: Colors.green,
              size: 20.sp,
            ),
            Gap(10),
            Expanded(
              child: Text(
                feature,
                style: TextStyle(fontSize: 13.sp),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            )
          ],
        ));
  }
}
