import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  // NotificationService a singleton object
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  static const int id = 0;

  // to initialize settings for Android and iOS
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // encapsulate initialization settings logic and be called from main.dart upon app launch
  Future<void> init() async {
    // Android initialization settings
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('alarm_clock');

    // iOS initialization settings
    const IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings();

    // InitializationSettings for initializing settings for both Android and iOS
    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings
    );
  }

  Future<void> showNotification(Duration duration, String module) async {
    const AndroidNotificationDetails _androidNotificationDetails = AndroidNotificationDetails(
      'Channel ID',
      'Timer',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true
    );

    const IOSNotificationDetails _iOSNotificationDetails = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true
    );

    NotificationDetails platformChannelSpecifics = const NotificationDetails(
      android: _androidNotificationDetails,
      iOS: _iOSNotificationDetails
    );

    String message;
    int minutes = duration.inMinutes;
    if (minutes != 1) {
      message = '$minutes minutes';
    } else {
      message = '$minutes minute';
    }

    await flutterLocalNotificationsPlugin.show(
      id,
      'Study Wyth Me',
      'Congratulations! You have completed your $message of focus time for $module!',
      platformChannelSpecifics
    );
  }

  Future<void> showPausedNotification(Duration duration, String module) async {
    const AndroidNotificationDetails _androidNotificationDetails = AndroidNotificationDetails(
      'Channel ID',
      'Timer',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true
    );

    const IOSNotificationDetails _iOSNotificationDetails = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true
    );

    NotificationDetails platformChannelSpecifics = const NotificationDetails(
      android: _androidNotificationDetails,
      iOS: _iOSNotificationDetails
    );

    String message;
    int minutes = duration.inMinutes;
    if (minutes != 1) {
      message = '$minutes minutes';
    } else {
      message = '$minutes minute';
    }

    await flutterLocalNotificationsPlugin.show(
      id,
      'Study Wyth Me',
      'Timer of $message for $module has been cancelled!',
      platformChannelSpecifics
    );
  }
}