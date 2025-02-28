import '/controller/provider/my_services/edit_provider_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProviderServiceView extends StatelessWidget {
  const EditProviderServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EditProviderServiceController>(
      init: EditProviderServiceController(),
      builder: (EditProviderServiceController controller) {
        return DefaultTabController(
          length: controller.tabBarViews(controller).length,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                'Edit Service',
              ),
              bottom: TabBar(
                tabs: controller.tabs,
              ),
            ),
            body: TabBarView(
              children: controller.tabBarViews(controller),
            ),
          ),
        );
      },
    );
  }
}
