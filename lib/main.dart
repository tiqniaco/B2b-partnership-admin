import 'dart:io';

import 'package:firebase_core/firebase_core.dart';

import '/app.dart';
import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'core/services/services_locator.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!Platform.isLinux) {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    }
  }

  await initialServices();
  tz.initializeTimeZones();
  runApp(const MedicalCenterApp());
}
