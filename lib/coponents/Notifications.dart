import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pro_delivery/pages/Setting.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails('channel id', 'channel name',
          importance: Importance.max),
      iOS: DarwinNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap/launcher_icon');
    final iOS = DarwinInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: iOS);

    await _notifications.initialize(settings,
        onDidReceiveNotificationResponse: (payload) async {
      onNotifications.add(payload.payload ?? '');
    });
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(id, title, body, await notificationDetails(),
          payload: payload);
}
