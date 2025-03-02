// ignore_for_file: avoid_print

import '/models/specialize_model.dart';
import 'package:get/get.dart';


class AdminHomeController extends GetxController {
  int length = 6;
  List<SpecializeModel> specializations = [];
  // List<SubSpecializeModel> subSpecializations = [];
  // StatusRequest statusRequestSpecialization = StatusRequest.loading;
  // StatusRequest statusRequestSubSpecialization = StatusRequest.loading;

  

  onTapSeeMore() {
    length = specializations.length;

    update();
  }

  onTapSeeLess() {
    length = 6;

    update();
  }



  

 

}
