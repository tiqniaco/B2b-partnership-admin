import 'package:b2b_partnership_admin/controller/settings/payment_controller.dart';
import 'package:b2b_partnership_admin/core/theme/app_color.dart';
import 'package:b2b_partnership_admin/views/settings/add_payment_method.dart';
import 'package:b2b_partnership_admin/views/settings/payments_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ManagePayment extends StatefulWidget {
  const ManagePayment({super.key});

  @override
  State<ManagePayment> createState() => _ManagePaymentState();
}

class _ManagePaymentState extends State<ManagePayment> {
  @override
  Widget build(BuildContext context) {
    Get.put(PaymentController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Package'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: GetBuilder<PaymentController>(
        builder: (controller) => SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                    color: borderColor,
                    borderRadius: BorderRadius.circular(24)),
                child: Row(
                  children: [
                    buildToggleButton(controller.isPackage, 'Package',
                        onTap: () {
                      controller.togglePackage();
                    }),
                    buildToggleButton(controller.isAddPackage, 'Add Package',
                        onTap: () {
                      controller.toggleAddPackage();
                    }),
                  ],
                ),
              ),
              controller.isPackage
                  ? Expanded(
                      child: PaymentsView(
                        packages: controller.packages,
                      ),
                    )
                  : Expanded(
                      child: AddPaymentMethod(),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildToggleButton(bool isSelected, String title,
      {void Function()? onTap}) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? whiteColor : transparentColor,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(title,
              style: TextStyle(
                fontSize: 15.r,
              )),
        ),
      ),
    );
  }
}
