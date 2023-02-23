import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  LocalNotification._internal();

  static const channelId = 'S.O.S';

  static final LocalNotification _localNotification =
      LocalNotification._internal();

  factory LocalNotification() {
    return _localNotification;
  }

  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  FlutterLocalNotificationsPlugin initNotification() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');

    var initializationSettingsDarwin = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    return _flutterLocalNotificationsPlugin;
  }

  void showNotification(
      {@required String? notiTitle, @required String? notiBody}) {
    _showNotification(notiTitle, notiBody);
  }

  Future<void> _showNotification(String? notiTitle, String? notiBody) async {
    var androidNotificationDetails = AndroidNotificationDetails(
        channelId, 'channel name',
        channelDescription: 'channel description',
        ticker: 'ticker',
        importance: Importance.max,
        priority: Priority.high);

    var iosNotificationDetails = DarwinNotificationDetails(
      badgeNumber: 1,
    );

    var notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await _flutterLocalNotificationsPlugin
        .show(0, notiTitle, notiBody, notificationDetails, payload: '');
  }
}
