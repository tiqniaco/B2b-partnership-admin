import '/controller/provider/my_services/edit_provider_service_controller.dart';
import '/core/global/widgets/custom_server_status_widget.dart';
import '/core/theme/app_color.dart';
import '/core/theme/text_style.dart';
import '/core/utils/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class EditProviderServiceFeaturesWidget extends StatelessWidget {
  const EditProviderServiceFeaturesWidget({
    super.key,
    required this.controller,
  });
  final EditProviderServiceController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addNewServiceFeatureDialog();
        },
        child: Icon(
          FontAwesomeIcons.plus,
          size: 18.sp,
        ),
      ),
      body: CustomServerStatusWidget(
        statusRequest: controller.statusRequestFeature,
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(
                vertical: 10.h,
                horizontal: 16.w,
              ),
              sliver: SliverList.separated(
                itemCount: controller.serviceFeatures.length,
                itemBuilder: (context, index) {
                  final feature = controller.serviceFeatures[index];
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: borderColor,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 8.h,
                          horizontal: 8.w,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            EditFeatureTextRowWidget(
                              title: "Arabic Title:",
                              value: feature.featureAr!,
                            ),
                            Gap(4.h),
                            EditFeatureTextRowWidget(
                              title: "English Title:",
                              value: feature.featureEn!,
                            ),
                          ],
                        ),
                      ),
                      if (controller.serviceFeatures.length != 1)
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                          child: TextButton(
                            onPressed: () {
                              controller.removeServiceFeatureDialog(
                                id: feature.id,
                              );
                            },
                            child: Text("- Remove"),
                          ),
                        ),
                    ],
                  );
                },
                separatorBuilder: (context, index) => Gap(10.h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditFeatureTextRowWidget extends StatelessWidget {
  const EditFeatureTextRowWidget({
    super.key,
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: getLightStyle.copyWith(
            fontWeight: FontManager.mediumFontWeight,
          ),
        ),
        Gap(8.w),
        Expanded(
          child: Text(
            value,
            style: getLightStyle.copyWith(
              fontWeight: FontManager.semiBoldFontWeight,
            ),
            maxLines: 3,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
