//import 'package:get/get.dart';
import 'package:get/get.dart';

translateDatabase({
  required String arabic,
  required String english,
}) {
  // var storage = GetStorage();

  var langCode = Get.locale?.languageCode ?? "en";
  if (langCode == "ar") {
    return arabic;
  } else {
    return english;
  }
}
