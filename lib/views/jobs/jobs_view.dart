import 'package:b2b_partnership_admin/app_routes.dart';
import 'package:b2b_partnership_admin/controller/jobs/jobs_controller.dart';
import 'package:b2b_partnership_admin/core/enums/jobs_contract_type_enum.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_network_image.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_sliver_server_status_widget.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/core/theme/text_style.dart';
import 'package:b2b_partnership_admin/core/utils/font_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class JobsView extends StatelessWidget {
  const JobsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JobsController>(
      init: JobsController(),
      builder: (JobsController controller) {
        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              controller: controller.scrollController,
              slivers: [
                SliverAppBar(
                  pinned: true,
                  floating: true,
                  backgroundColor: whiteColor,
                  elevation: 0,
                  titleSpacing: 0,
                  title: Text(
                    "Jobs".toUpperCase(),
                    style: getSemiBoldStyle.copyWith(
                      letterSpacing: 1.5.w,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // Gap(20.h),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 10.h,
                  ),
                  sliver: CustomSliverServerStatusWidget(
                    statusRequest: controller.statusRequest,
                    child: SliverList.separated(
                      itemCount: controller.jobs.length,
                      itemBuilder: (context, index) {
                        final job = controller.jobs[index];
                        return InkWell(
                          onTap: () {
                            Get.toNamed(
                              AppRoutes.jobDetails,
                              arguments: {
                                "job": job,
                              },
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: whiteColor,
                              border: Border.all(color: borderColor),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 35.r,
                                  child: CustomNetworkImage(
                                    imageUrl: job.image,
                                    fit: BoxFit.contain,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                Gap(12.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Company: ${job.name}",
                                        style: getRegularStyle.copyWith(
                                          fontWeight:
                                              FontManager.mediumFontWeight,
                                        ),
                                      ),
                                      Gap(5.h),
                                      Text(
                                        "Job Title: ${job.title}",
                                        style: getRegularStyle.copyWith(
                                          fontWeight:
                                              FontManager.mediumFontWeight,
                                        ),
                                      ),
                                      Gap(5.h),
                                      Text(
                                        "Contract Type: ${job.contractType.text}",
                                        style: getLightStyle,
                                      ),
                                      Gap(5.h),
                                      Text(
                                        "Expiry Date: ${job.expiryDate}",
                                        style: getLightStyle,
                                      ),
                                      if (job.salary != "null") ...[
                                        Gap(5.h),
                                        Text(
                                          "Salary: ${job.salary}",
                                          style: getLightStyle,
                                        )
                                      ],
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
