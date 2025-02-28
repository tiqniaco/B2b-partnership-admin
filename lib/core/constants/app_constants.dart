import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// App Name and Version Constants
const String kAppName = 'Medical Center';
const String kAppVersion = '1.0.0';
const String kAppVersionCode = '1';
const String kAppVersionName = '1.0.0';
const String kAppPackageName = 'tiqnia.medical.center.app';

/// App Constants
const kDefaultLanguage = 'en';
const kDefaultCountry = 'US';
const kDefaultLocale = Locale(kDefaultLanguage, kDefaultCountry);
const kDefaultPadding = 18.0;
const kDefaultAppTransitionAnimation = Transition.fade;
String kAppLanguageCode = '';
bool kFirstTime = true;
String kUserId = '';
String kUserName = '';

/// Animation Constants
const kDefaultTransitionDuration = Duration(milliseconds: 300);
const kDefaultAnimationDuration = Duration(milliseconds: 300);
const kSplashAnimationDuration = Duration(seconds: 1, milliseconds: 300);
const kSplashDuration = Duration(seconds: 2, milliseconds: 500);

/// Notification constants
const String kNotificationChannelKey = 'doctor_app_channel';
const String kNotificationChannelName = 'Doctor App Notifications';
const String kNotificationChannelDescription =
    'Notification channel for Doctor App';
const String kNotificationGroupKey = 'doctor_app_group';
const String kNotificationGroupAlertSummary =
    'You have $kNotificationCount notifications';
const int kNotificationCount = 10;

/// Database constants
const String kDatabaseName = 'doctor_app.db';
const String kDatabaseVersion = '1';
const String kDatabaseAlarmTable = 'alarm';
const String kDatabaseColumnId = 'id';
const String kDatabaseColumnTitle = 'title';
const String kDatabaseColumnDescription = 'description';
const String kDatabaseColumnDate = 'date';
const String kDatabaseColumnWeekDay = 'weekday';
const String kDatabaseColumnTime = 'time';
const String kDatabaseColumnNumberPerTime = 'numberPerTime';
const String kDatabaseColumnType = 'type';
const String kDatabaseColumnStatus = 'status';

/// Other Constants
const String kBaseImageUrl =
    "https://tiqnia.com/Apps/b2b_partenership/laravel/public/";
