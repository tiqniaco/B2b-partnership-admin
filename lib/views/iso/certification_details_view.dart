import 'package:b2b_partnership_admin/controller/iso/iso_details_controller.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/models/iso_model.dart';
import 'package:b2b_partnership_admin/widgets/iso/build_section_header.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class CertificationDetailsScreen extends StatelessWidget {
  const CertificationDetailsScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    Get.put(IsoDetailsController());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Certification Details',
          style: TextStyle(
            fontSize: 18.r,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
      ),
      body: GetBuilder<IsoDetailsController>(
        builder: (controller) => Form(
          key: controller.formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildHeroSection(controller.iso),
                      _buildDetailsSection(controller.iso),
                      _buildFeaturesSection(controller, context),
                      _buildBenefitsSection(controller, context),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection(IsoModel iso) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              CupertinoIcons.globe,
              color: Colors.white,
              size: 50,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            iso.title ?? '_',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "certification['title']",
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFFDCEEFB),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 16),
                SizedBox(width: 8),
                Text(
                  'Certified & Active',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsSection(IsoModel iso) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          Text(
            'About This Certification',
            style: TextStyle(
              fontSize: 17.r,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            iso.description ?? '',
            style: TextStyle(
              fontSize: 14.r,
              color: Color(0xFF64748B),
              height: 1.6,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Certification Price:',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF334155),
                ),
              ),
              Text(
                '\$${iso.price}',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(
      IsoDetailsController controller, BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
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
          buildSectionHeader('What\'s Included', () {
            controller.addIncludedItem(context);
          }),
          const SizedBox(height: 16),
          ...controller.isoIncludedList.map((feature) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCEEFB),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.verified,
                        color: const Color.fromARGB(255, 55, 62, 78),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            feature.title ?? '',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                          Text(
                            feature.description ?? '',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.defaultDialog(
                            title: 'Remove Item'.tr,
                            middleText:
                                'Are you sure you want to remove this item?'.tr,
                            middleTextStyle: TextStyle(fontSize: 14.r),
                            contentPadding: EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            backgroundColor: Colors.white,
                            textConfirm: 'Yes'.tr,
                            textCancel: 'No',
                            onConfirm: () {
                              controller.deleteInclude(feature.id!);
                              Get.back();
                            });
                      },
                      child: Icon(
                        CupertinoIcons.delete,
                        color: blackColor,
                        size: 14.r,
                      ),
                    ),
                    Gap(12),
                    InkWell(
                      onTap: () {
                        controller.editIncludedItem(context, feature);
                      },
                      child: Icon(
                        Icons.edit,
                        color: blackColor,
                        size: 14.r,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildBenefitsSection(
      IsoDetailsController controller, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor.withOpacity(0.1),
            primaryColor.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: primaryColor.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: primaryColor,
                size: 24,
              ),
              const SizedBox(width: 8),
              const Text(
                'Key Benefits',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                ),
              ),
              Spacer(),
              IconButton(
                onPressed: () => controller.addBenefitItem(context),
                icon: const Icon(Icons.add_circle),
                color: Colors.deepPurple,
                iconSize: 28,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ...controller.isoBenefitsList.map((benefit) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: primaryColor,
                      size: 18,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        benefit.title ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF334155),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.defaultDialog(
                            title: 'Remove Item'.tr,
                            middleText:
                                'Are you sure you want to remove this item?'.tr,
                            middleTextStyle: TextStyle(fontSize: 14.r),
                            contentPadding: EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            backgroundColor: Colors.white,
                            textConfirm: 'Yes'.tr,
                            textCancel: 'No',
                            onConfirm: () {
                              controller.deleteBenefit(benefit.id!);
                              Get.back();
                            });
                      },
                      child: Icon(
                        CupertinoIcons.delete,
                        color: blackColor,
                        size: 14.r,
                      ),
                    ),
                    Gap(12),
                    InkWell(
                      onTap: () {
                        controller.editBenefitItem(context, benefit);
                      },
                      child: Icon(
                        Icons.edit,
                        color: blackColor,
                        size: 14.r,
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
