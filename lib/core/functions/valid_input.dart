import 'package:get/get.dart';

validInput(String val, int min, int max, String type, {pass}) {
  if (val.isEmpty) {
    return "can't be empty".tr;
  }

  if (type == "username") {
    const namePattern = r'^[a-zA-Z]{3,}(?: [a-zA-Z]+){0,2}$';
    if (!RegExp(namePattern).hasMatch(val)) {
      return "invalid username".tr;
    }
  }

  if (type == "email") {
    if (!GetUtils.isEmail(val)) {
      return "invalid email".tr;
    }
  }

  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val)) {
      return "invalid phone number".tr;
    }
  }

  if (type == "confirm") {
    if (!GetUtils.hasMatch(val, pass)) {
      return "match the password".tr;
    }
  }

  if (type == "number") {
    if (!GetUtils.isNum(val)) {
      return "must be a number".tr;
    }
  }

  if (type == "text") {
    if (!GetUtils.isAlphabetOnly(val)) {
      return "must be a text".tr;
    }
  }

  if (val.length < min) {
    return "${"can't be less than".tr}$min";
  }

  if (val.length > max) {
    return "${"can't be larger than".tr}$max";
  }
}
