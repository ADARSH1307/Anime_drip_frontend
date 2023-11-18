import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HelperNotification {
  static Future<void> initialize(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('notification.mp3'); // Set your custom sound here
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }
}
