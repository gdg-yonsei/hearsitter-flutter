import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationUtil{
  LocalNotificationUtil._internal();

  static const channelId = 'HearSitter';

  static final LocalNotificationUtil _localNotification =
      LocalNotificationUtil._internal();

  factory LocalNotificationUtil() => _localNotification;


  FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

   initNotification() async {
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
        channelId, 'HearSitter',
        channelDescription: 'Sound Detection',
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
