import '../../../controller/manage_users/provider_profile/previous_work_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class WorkImage extends StatelessWidget {
  const WorkImage({super.key});

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    Get.put(PreviousDetailsWorkController());
    return GetBuilder<PreviousDetailsWorkController>(builder: (controller) {
      return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MasonryGridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemCount: controller.images.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(controller.images[index].image!,
                    fit: BoxFit.cover),
              );
            },
          ),
        ),
      );
    });
  }
}
