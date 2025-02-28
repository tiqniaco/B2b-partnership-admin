import '/app_routes.dart';
import '/controller/provider/my_services/get_my_service_controller.dart';
import '/core/global/widgets/custom_server_status_widget.dart';
import '/core/theme/app_color.dart';
import '/widgets/in_category/service_widget_vertical.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyService extends StatelessWidget {
  MyService({super.key});
  final controller = Get.put(GetMyServiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: Text(
          'My Services',
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.bold,
            color: blackColor,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(AppRoutes.addProviderService);
        },
        shape: CircleBorder(),
        child: Icon(Icons.add),
      ),
      body: GetBuilder<GetMyServiceController>(
        builder: (controller) => CustomServerStatusWidget(
          statusRequest: controller.statusRequestServices,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ServiceWidgetVertical(
                  services: controller.providerServices,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
