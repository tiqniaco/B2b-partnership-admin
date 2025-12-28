import 'package:b2b_partnership_admin/controller/settings/payment_controller.dart';
import 'package:b2b_partnership_admin/models/payment_model.dart';
import 'package:b2b_partnership_admin/widgets/payments/package_card.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class PaymentsView extends GetView<PaymentController> {
  const PaymentsView({super.key, required this.packages});
  final List<PaymentPackage> packages;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Select the perfect package for your needs',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: packages.length,
            itemBuilder: (context, index) {
              return PaymentPackageCard(
                package: packages[index],
                isSelected: true,
                onTapDelete: () {
                  controller.deletePackage(packages[index].id!);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

