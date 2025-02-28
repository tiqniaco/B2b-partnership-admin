import '/models/specialize_model.dart';
import 'package:get/get.dart';

class SeeAllCategoryController extends GetxController {
  late List<SpecializeModel> categories;

  @override
  void onInit() {
    categories = Get.arguments['categories'];
    super.onInit();
  }
}
