import 'package:get/get.dart';

class PdfViewController extends GetxController {
  late String file;

  @override
  void onInit() {
    file = Get.arguments['file'];
    super.onInit();
  }
}
