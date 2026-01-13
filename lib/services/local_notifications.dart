import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotifications {
  const LocalNotifications._();

  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const int _timerFinishedId = 1001;

  static Future<void> init() async {
    tz.initializeTimeZones();

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidInit);

    await _plugin.initialize(initSettings);

    await _requestAndroidPermissionIfNeeded();
  }

  static Future<void> _requestAndroidPermissionIfNeeded() async {
    if (defaultTargetPlatform != TargetPlatform.android) return;

    final android =
        _plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
    await android?.requestNotificationsPermission();
  }

  static NotificationDetails _timerDetails() {
    const androidDetails = AndroidNotificationDetails(
      'study_timer',
      'Study Timer',
      channelDescription: 'Study timer notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    return const NotificationDetails(android: androidDetails);
  }

  static Future<void> showTimerFinished() async {
    await _plugin.show(
      _timerFinishedId,
      'Timer finished!',
      '⏰ Your study timer has ended',
      _timerDetails(),
    );
  }

  static Future<void> scheduleTimerFinished(DateTime at) async {
    if (!at.isAfter(DateTime.now())) {
      return;
    }
    final when = tz.TZDateTime.from(at, tz.local);

    await _plugin.zonedSchedule(
      _timerFinishedId,
      'Timer finished!',
      '⏰ Your study timer has ended',
      when,
      _timerDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: null,
    );
  }

  static Future<void> cancelTimerFinished() async {
    await _plugin.cancel(_timerFinishedId);
  }
}
