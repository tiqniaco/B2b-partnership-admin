import 'package:b2b_partnership_admin/controller/manage_users/provider_profile/provider_profile_controller.dart';
import 'package:b2b_partnership_admin/core/global/widgets/custom_server_status_widget.dart';
import 'package:b2b_partnership_admin/widgets/job_widget.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class JobListWidget extends StatelessWidget {
  const JobListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProviderProfileController>(builder: (controller) {
      return CustomServerStatusWidget(
        statusRequest: controller.statusRequestJobs,
        child: ListView.separated(
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 20),
            itemCount: controller.jobs.length,
            separatorBuilder: (context, index) => Gap(20),
            itemBuilder: (context, index) => JobWidget(
                  model: controller.jobs[index],
                  onTapDelete: () {
                    controller.deleteJobsDialog(controller.jobs[index].id);
                  },
                )),
      );
    });
  }
}
