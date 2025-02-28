// ignore_for_file: avoid_print

import '/core/crud/custom_request.dart';
import '/core/enums/status_request.dart';
import '/core/network/api_constance.dart';
import '/models/pervious_work_model.dart';
import '/models/previous_work_image_model.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class PreviousDetailsWorkController extends GetxController {
  int currentPage = 0;
  late ProviderPerviousWorkModel model;
  List<PreviousImagesModel> images = [];
  StatusRequest statusRequest = StatusRequest.loading;

  @override
  void onInit() {
    model = Get.arguments['model'];
    getImages();
    super.onInit();
  }

  Future<void> getImages() async {
    print("get details .........");
    statusRequest = StatusRequest.loading;
    final result = await CustomRequest(
      path: ApiConstance.getWorkImages,
      data: {"provider_previous_work_id": model.id},
      fromJson: (json) {
        return json['images']
            .map<PreviousImagesModel>(
                (type) => PreviousImagesModel.fromJson(type))
            .toList();
      },
    ).sendGetRequest();
    result.fold((l) {
      statusRequest = StatusRequest.error;
      Logger().e(l.errMsg);
      update();
    }, (r) {
      images = r;
      statusRequest = StatusRequest.success;
      update();
    });
  }

  changeSlider(int index) {
    print(index);
    currentPage = index;
    update(["slider"]);
  }
}
