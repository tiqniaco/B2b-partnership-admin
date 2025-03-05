import 'package:b2b_partnership_admin/models/job_details_model.dart';
import 'package:get/get.dart';

class JobDetailsController extends GetxController {
  JobDetailsModel? jobDetailsModel;

  @override
  void onInit() {
    jobDetailsModel = Get.arguments['job'];
    super.onInit();
  }
}
