import 'dart:developer';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import '/core/constants/app_constants.dart';
import '/core/theme/app_color.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationsService {
  final AwesomeNotifications _awesomeNotifications = AwesomeNotifications();

  NotificationsService() {
    initialize();
  }

  // Initializes the awesome_notifications package and sets up the handlers
  // for background, foreground, and app opened with notification events.
  Future<void> initialize() async {
    try {
      await AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          Permission.notification.request();
        }
      });

      await _awesomeNotifications.initialize(
        null,
        [
          NotificationChannel(
            channelKey: kNotificationChannelKey,
            channelName: kNotificationChannelName,
            channelDescription: kNotificationChannelDescription,
            defaultColor: primaryColor,
            ledColor: whiteColor,
            importance: NotificationImportance.High,
            enableLights: true,
            enableVibration: true,
            playSound: true,
            // icon: 'resource://drawable/ic_launcher',
          ),
        ],
        channelGroups: [
          NotificationChannelGroup(
            channelGroupKey: kNotificationGroupKey,
            channelGroupName: kNotificationGroupAlertSummary,
          )
        ],
      );

      FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
      FirebaseMessaging.onMessage.listen(_foregroundHandler);
      FirebaseMessaging.onMessageOpenedApp.listen(_openAppWithNotification);

      await initialListeners();
    } catch (e) {
      log(e.toString(), name: 'NotificationsService');
    }
  }

  Future<String> getFirebaseToken() async {
    String token = await FirebaseMessaging.instance.getToken() ?? "";
    log(token.toString());
    return token;
  }

  /// Use this method to detect when a new notification is created
  Future<void> initialListeners() async {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: onActionReceivedMethod,
      onNotificationCreatedMethod: onNotificationCreatedMethod,
      onNotificationDisplayedMethod: onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: onDismissActionReceivedMethod,
    );
  }

  /// Use this method to detect when a new notification or a schedule is created
  @pragma("vm:entry-point")
  static Future<void> onNotificationCreatedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Your code goes here
  }

  /// Use this method to detect every time that a new notification is displayed
  @pragma("vm:entry-point")
  static Future<void> onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    // Your code goes here
  }

  /// Use this method to detect if the user dismissed a notification
  @pragma("vm:entry-point")
  static Future<void> onDismissActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    // Your code goes here
  }

  /// Use this method to detect when the user taps on a notification or action button
  @pragma("vm:entry-point")
  static Future<void> onActionReceivedMethod(
    ReceivedAction receivedAction,
  ) async {
    // Your code goes here
  }

  // Handles notifications that are received in the background.
  Future<void> _backgroundHandler(RemoteMessage message) async {
    // Log the notification data to the console.
    log(message.data.toString());
    // Create a new basic notification with the title and description from
    // the notification data.
    createNewBasicNotification(
      title: message.notification?.title ?? "",
      description: message.notification?.body ?? "",
    );
  }

  // Handles notifications that are received in the foreground.
  Future<void> _foregroundHandler(RemoteMessage message) async {
    // Log the notification data to the console.
    log(message.data.toString());
    // Create a new basic notification with the title and description from
    // the notification data.
    createNewBasicNotification(
      title: message.notification?.title ?? "",
      description: message.notification?.body ?? '',
    );
  }

  // Handles notifications that are opened from the notification drawer.
  Future<void> _openAppWithNotification(RemoteMessage message) async {
    // Log the notification data to the console.
    log(message.data.toString());
    //Get.toNamed(AppRoutes.notifications, arguments: message.data);
    // // Create a new basic notification with the title and description from
    // // the notification data.
    // createNewBasicNotification(
    //   title: message.notification!.title!,
    //   description: message.notification!.body!,
    // );
  }

  // Creates a new basic notification with the given title and description.
  Future<void> createNewBasicNotification({
    required String title,
    required String description,
  }) async {
    // Create a new notification with the given title and description.
    await _awesomeNotifications.createNotification(
      content: NotificationContent(
        id: _generateId(),
        channelKey: kNotificationChannelKey,
        title: title,
        body: description,
      ),
    );
  }

  Future<void> createScheduledNotification({
    required int id,
    required String title,
    required String description,
    required DateTime dateTime,
  }) async {
    try {
      await _awesomeNotifications.createNotification(
        content: NotificationContent(
          id: id,
          channelKey: kNotificationChannelKey,
          title: title,
          body: description,
          wakeUpScreen: true,
          displayOnBackground: true,
          displayOnForeground: true,
          category: NotificationCategory.Alarm,
        ),
        schedule: NotificationCalendar(
          allowWhileIdle: true,
          year: dateTime.year,
          month: dateTime.month,
          day: dateTime.day,
          hour: dateTime.hour,
          minute: dateTime.minute,
        ),
      );
    } on Exception catch (e) {
      log(e.toString(), name: 'NotificationsService');
    }
  }

  Future<void> createRepeatingScheduledNotification({
    required int id,
    required String title,
    required String description,
    required DateTime dateTime,
  }) async {
    try {
      await _awesomeNotifications.createNotification(
        content: NotificationContent(
          id: id,
          channelKey: kNotificationChannelKey,
          title: title,
          body: description,
          wakeUpScreen: true,
          displayOnBackground: true,
          displayOnForeground: true,
          category: NotificationCategory.Alarm,
        ),
        schedule: NotificationCalendar(
          allowWhileIdle: true,
          // year: dateTime.year,
          // month: dateTime.month,
          day: dateTime.day,
          hour: dateTime.hour,
          minute: dateTime.minute,
          repeats: true,
        ),
      );
    } on Exception catch (e) {
      log(e.toString(), name: 'NotificationsService');
    }
  }

  Future<void> cancelScheduledNotification(int id) async {
    try {
      await _awesomeNotifications.cancel(id);
    } on Exception catch (e) {
      log(e.toString(), name: 'NotificationsService');
    }
  }

  Future<void> cancelAllScheduledNotifications() async {
    try {
      await _awesomeNotifications.cancelAll();
    } on Exception catch (e) {
      log(e.toString(), name: 'NotificationsService');
    }
  }

  // Generates a unique ID for the notification.
  _generateId() {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;
  }
}
