import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/core/network/api_constance.dart';
import '/core/constants/app_constants.dart';
import 'services_locator.dart';

enum SharedKey {
  firstTime,
  token,
  language,
  isDarkMode,
  userId,
  userRoleId,
  userEmail,
  phone,
  userRole,
}

class AppPreferences {
  final _sharedPreferences = Get.find<ServicesLocator>().sharedPreferences;

  AppPreferences({bool fromLogin = false}) {
    init(fromLogin: fromLogin);
  }

  Future<void> init({bool fromLogin = false}) async {
    if (getAppLanguageCode() == '') {
      kAppLanguageCode = getAppLanguageCode() ?? kDefaultLanguage;
      setAppLanguageCode(kAppLanguageCode);
      Get.updateLocale(Locale(kAppLanguageCode));
    } else {
      kAppLanguageCode = getAppLanguageCode() ??
          Get.deviceLocale?.languageCode ??
          kDefaultLanguage;
      Get.updateLocale(Locale(kAppLanguageCode));
    }
    kFirstTime = getFirstTime();
    ApiConstance.token = getToken();
    kUserId = getUserId();

    await Future.delayed(const Duration(seconds: 1), () {
      log(kAppLanguageCode, name: 'Language Code');
      log(kFirstTime.toString(), name: 'First Time');
      log(ApiConstance.token, name: 'Token');
      log(kUserId.toString(), name: 'User Id');
      log(getUserRole(), name: 'User Role');
    });
  }

  /// Save the first time to the shared preferences
  Future<void> setFirstTime(bool isFirstTime) async {
    await _sharedPreferences.setBool(
      SharedKey.firstTime.toString(),
      isFirstTime,
    );
  }

  /// Get the first time from the shared preferences
  bool getFirstTime() {
    return _sharedPreferences.getBool(SharedKey.firstTime.toString()) ?? true;
  }

  /// Save the Token to the shared preferences
  Future<void> setToken(String token) async {
    ApiConstance.token = token;
    await _sharedPreferences.setString(
      SharedKey.token.toString(),
      token,
    );
  }

  /// Get the Token from the shared preferences
  String getToken() {
    return _sharedPreferences.getString(SharedKey.token.toString()) ?? '';
  }

  /// Remove the Token from the shared preferences
  Future<void> removeToken() async {
    ApiConstance.token = '';
    await _sharedPreferences.remove(SharedKey.token.toString());
  }

  /// Save the App Language Code to the shared preferences
  Future<void> setAppLanguageCode(String languageCode) async {
    await _sharedPreferences.setString(
      SharedKey.language.toString(),
      languageCode,
    );
  }

  /// Get the App Language Code from the shared preferences
  String? getAppLanguageCode() {
    return _sharedPreferences.getString(SharedKey.language.toString());
  }

  /// Remove the App Language Code from the shared preferences
  Future<void> removeLanguageCode() async {
    await _sharedPreferences.remove(SharedKey.language.toString());
  }

  /// Save the userId to the shared preferences
  Future<void> setUserId(String userId) async {
    await _sharedPreferences.setString(
      SharedKey.userId.toString(),
      userId,
    );
  }

  /// Save the userId to the shared preferences
  Future<void> setUserRoleId(String userId) async {
    await _sharedPreferences.setString(
      SharedKey.userRoleId.toString(),
      userId,
    );
  }

  /// Get the userId from the shared preferences
  String getUserId() {
    return _sharedPreferences.getString(SharedKey.userId.toString()) ?? '';
  }

  String getUserRoleId() {
    return _sharedPreferences.getString(SharedKey.userRoleId.toString()) ?? '';
  }

  /// Remove the userId from the shared preferences
  Future<void> removeUserId() async {
    await _sharedPreferences.remove(SharedKey.userId.toString());
  }

  /// Save the userEmail to the shared preferences
  Future<void> setUserEmail(String userEmail) async {
    await _sharedPreferences.setString(
      SharedKey.userEmail.toString(),
      userEmail,
    );
  }

  /// Get the userEmail from the shared preferences
  String getUserEmail() {
    return _sharedPreferences.getString(SharedKey.userEmail.toString()) ?? '';
  }

  /// Remove the userEmail from the shared preferences
  Future<void> removeUserEmail() async {
    await _sharedPreferences.remove(SharedKey.userEmail.toString());
  }

  /// Save the phone to the shared preferences
  Future<void> setPhone(String phone) async {
    await _sharedPreferences.setString(
      SharedKey.phone.toString(),
      phone,
    );
  }

  /// Get the phone from the shared preferences
  String getPhone() {
    return _sharedPreferences.getString(SharedKey.phone.toString()) ?? '';
  }

  /// Remove the phone from the shared preferences
  Future<void> removePhone() async {
    await _sharedPreferences.remove(SharedKey.phone.toString());
  }

  Future<void> setUserRole(String userRole) async {
    await _sharedPreferences.setString(
      SharedKey.userRole.toString(),
      userRole,
    );
  }

  String getUserRole() {
    return _sharedPreferences.getString(SharedKey.userRole.toString()) ?? '';
  }

  Future<void> removeUserRole() async {
    await _sharedPreferences.remove(SharedKey.userRole.toString());
  }

  /// Clear all the shared preferences
  Future<void> clear() async {
    await _sharedPreferences.clear();
  }
}
