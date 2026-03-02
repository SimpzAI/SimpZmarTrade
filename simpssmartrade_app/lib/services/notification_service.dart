import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'app_prefs.dart';

class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  static const _chPreopen = 'intraday_preopen';
  static const _chRegime = 'intraday_regime';
  static const _chManage = 'intraday_manage';
  static const _chExit = 'intraday_exit';

  Future<void> initialize() async {
    tzdata.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: androidInit);
    await _plugin.initialize(settings);

    final android = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await android?.requestNotificationsPermission();

    // channels + sounds (res/raw/*.wav)
    await android?.createNotificationChannel(const AndroidNotificationChannel(
      _chPreopen,
      '09:15 Pre-open',
      description: 'Pre-open reminder',
      importance: Importance.defaultImportance,
      sound: RawResourceAndroidNotificationSound('preopen'),
    ));
    await android?.createNotificationChannel(const AndroidNotificationChannel(
      _chRegime,
      '09:30 Regime check',
      description: 'Regime check reminder',
      importance: Importance.defaultImportance,
      sound: RawResourceAndroidNotificationSound('regime'),
    ));
    await android?.createNotificationChannel(const AndroidNotificationChannel(
      _chManage,
      '11:00 Manage trades',
      description: 'Manage trades reminder',
      importance: Importance.defaultImportance,
      sound: RawResourceAndroidNotificationSound('manage'),
    ));
    await android?.createNotificationChannel(const AndroidNotificationChannel(
      _chExit,
      '15:10 Exit discipline',
      description: 'Exit reminder',
      importance: Importance.defaultImportance,
      sound: RawResourceAndroidNotificationSound('exit'),
    ));
  }

  Future<void> cancelAll() async => _plugin.cancelAll();

  Future<void> scheduleDefaultRemindersIfEnabled() async {
    final enabled = await AppPrefs.getRemindersEnabled();
    if (!enabled) return;
    await scheduleDefaultReminders();
  }

  Future<void> scheduleDefaultReminders() async {
    await cancelAll();

    await _scheduleDaily(
      id: 915,
      hour: 9,
      minute: 15,
      title: '09:15 Pre-open',
      body: 'No trades. Plan only.',
      channelId: _chPreopen,
      channelName: '09:15 Pre-open',
    );

    await _scheduleDaily(
      id: 930,
      hour: 9,
      minute: 30,
      title: '09:30 Regime check',
      body: 'Decide Bull/Base/Bear. Only LONGs.',
      channelId: _chRegime,
      channelName: '09:30 Regime check',
    );

    await _scheduleDaily(
      id: 1100,
      hour: 11,
      minute: 0,
      title: '11:00 Manage trades',
      body: 'Trail SL / book partial / avoid overtrading.',
      channelId: _chManage,
      channelName: '11:00 Manage trades',
    );

    await _scheduleDaily(
      id: 1510,
      hour: 15,
      minute: 10,
      title: '15:10 Exit discipline',
      body: 'Close intraday positions. Avoid late risk.',
      channelId: _chExit,
      channelName: '15:10 Exit discipline',
    );
  }

  Future<void> _scheduleDaily({
    required int id,
    required int hour,
    required int minute,
    required String title,
    required String body,
    required String channelId,
    required String channelName,
  }) async {
    final now = tz.TZDateTime.now(tz.local);
    var next = tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);
    if (next.isBefore(now)) next = next.add(const Duration(days: 1));

    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: 'SimpSmarTrade intraday reminders',
        importance: Importance.defaultImportance,
        priority: Priority.defaultPriority,
        playSound: true,
      ),
    );

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      next,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }
}
