import 'package:b2b_partnership_admin/controller/jobs/jobs_controller.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_sliver_server_status_widget.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/core/theme/text_style.dart';
import 'package:b2b_partnership_admin/widgets/job_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                    "Jobs".tr.toUpperCase(),
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
                        return JobWidget(
                          model: controller.jobs[index],
                          onTapDelete: () {
                            controller
                                .deleteJobsDialog(controller.jobs[index].id);
                          },
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
