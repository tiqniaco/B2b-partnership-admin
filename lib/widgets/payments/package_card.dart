import 'package:b2b_partnership_admin/app_routes.dart';
import 'package:b2b_partnership_admin/core/global/widgets/get_color.dart';
import 'package:b2b_partnership_admin/models/payment_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class PaymentPackageCard extends StatelessWidget {
  final PaymentPackage package;
  final bool isSelected;
  final VoidCallback onTapDelete;

  const PaymentPackageCard({
    super.key,
    required this.package,
    required this.isSelected,
    required this.onTapDelete,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = getRandomColor();
    return GestureDetector(
      onTap: onTapDelete,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        package.name.toString().capitalizeFirst ?? '',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        package.price ?? '',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text(
                          " / ${package.monthsPlanName.toString()} months",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 6),
                  const Divider(),
                  const SizedBox(height: 10),
                  if (package.description != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Row(
                        children: [
                          Icon(
                            Icons.check_circle,
                            color: color,
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              package.description ?? '',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: color,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Number of Services:',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            package.serviceCount.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Row(
                    children: [
                      TextButton.icon(
                        style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                const Color.fromARGB(255, 244, 244, 244))),
                        onPressed: () {
                          Get.toNamed(AppRoutes.editPaymentMethod,
                              arguments: {"method": package});
                        },
                        label: Text("Edit"),
                        icon: Icon(Icons.edit),
                      ),
                      Gap(12),
                      TextButton.icon(
                          onPressed: () {
                            Get.defaultDialog(
                              title: 'Delete this package'.tr,
                              titleStyle: TextStyle(fontSize: 13.sp),
                              middleText: "Are you sure to delete?".tr,
                              textConfirm: 'Yes',
                              textCancel: 'No',
                              onConfirm: onTapDelete,
                            );
                          },
                          style: ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  const Color.fromARGB(255, 244, 244, 244))),
                          label: Text("Delete"),
                          icon: Icon(Icons.delete_outline_rounded)),
                    ],
                  )
                ],
              ),
            ),
            if (package.isPopular!)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'POPULAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
