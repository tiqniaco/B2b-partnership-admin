import 'dart:developer';

import '/core/constants/app_constants.dart';
import '/core/services/app_prefs.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

Future<void> subscribeTopics(int id, String role) async {
  kUserId = id.toString();
  Get.find<AppPreferences>().setUserId(id.toString());
  if (role == "provider") {
    await FirebaseMessaging.instance.subscribeToTopic('all');
    await FirebaseMessaging.instance.subscribeToTopic('providers');
    await FirebaseMessaging.instance.subscribeToTopic('provider$id');
    log('provider$id', name: 'subscribeTopics');
  } else if (role == "client") {
    await FirebaseMessaging.instance.subscribeToTopic('all');
    await FirebaseMessaging.instance.subscribeToTopic('clients');
    await FirebaseMessaging.instance.subscribeToTopic('client$id');
    log('client$id', name: 'subscribeTopics');
  } else if (role == "admin") {
    await FirebaseMessaging.instance.subscribeToTopic('all');
    await FirebaseMessaging.instance.subscribeToTopic('admins');
    await FirebaseMessaging.instance.subscribeToTopic('admin$id');
    log('admin$id', name: 'subscribeTopics');
  }
}
