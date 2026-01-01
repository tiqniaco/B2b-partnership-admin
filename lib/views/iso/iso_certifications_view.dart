import 'package:b2b_partnership_admin/app_routes.dart';
import 'package:b2b_partnership_admin/controller/iso/iso_controller.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class IsoCertificationsView extends StatelessWidget {
  const IsoCertificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(IsoController());
    return Scaffold(
      appBar: AppBar(
          title: Text("ISO Certifications".tr,
              style: TextStyle(
                fontSize: 18.r,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0F172A),
              ))),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          Get.toNamed(AppRoutes.addIso);
        },
        child: Icon(Icons.add),
      ),
      body: GetBuilder<IsoController>(
        builder: (controller) => SafeArea(
          child: Column(
            children: [
              Expanded(
                  child: ListView.separated(
                separatorBuilder: (context, index) => Gap(12),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                //shrinkWrap: true,
                //physics: const NeverScrollableScrollPhysics(),
                // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 2,
                //   crossAxisSpacing: 16,
                //   mainAxisSpacing: 16,
                //   childAspectRatio: 0.8,
                // ),
                itemCount: controller.isoList.length,
                itemBuilder: (context, index) {
                  final cert = controller.isoList[index];
                  return InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.isoCertificationDetails,
                          arguments: {"iso": cert});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0A000000),
                            blurRadius: 4,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: borderColor.withAlpha(30)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton.icon(
                                        onPressed: () {
                                          Get.toNamed(AppRoutes.editIso,
                                              arguments: {"iso": cert});
                                        },
                                        label: Text("Edit"),
                                        icon: Icon(Icons.edit),
                                      ),
                                      TextButton.icon(
                                        onPressed: () {
                                          Get.defaultDialog(
                                              title: "Delete".tr,
                                              content: Text(
                                                "Are you sure you want to delete this certification?"
                                                    .tr,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              confirm: TextButton(
                                                  child: Text(
                                                    "Yes".tr,
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  onPressed: () {
                                                    controller
                                                        .deleteIso(cert.id!);
                                                    Get.back();
                                                  }),
                                              cancel: TextButton(
                                                  child: Text(
                                                    "No".tr,
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                  onPressed: () {
                                                    Get.back();
                                                  }));
                                        },
                                        label: Text("Delete"),
                                        icon: Icon(CupertinoIcons.delete),
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(),
                                Gap(4),
                                Text(
                                  cert.title ?? '',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "cert['title']",
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF334155),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  cert.description ?? '',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF64748B),
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
