import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:task_manager_firebase_assignment/common/routes/app_navigator.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationsService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static final NotificationDetails _details = NotificationDetails(
    android: AndroidNotificationDetails(
      'Class-id',
      'Class-channel',

      importance: Importance.max,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(),
  );

  static Future<void> init() async {
    tz.initializeTimeZones();
    const InitializationSettings _settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );
    await _plugin.initialize(
      settings: _settings,
      onDidReceiveNotificationResponse: onTap,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.requestNotificationsPermission();
  }

  static Future<void> onTap(NotificationResponse response) async {
    AppNavigator.openDetails(response.payload ?? '');
  }

  static Future<void> showNow({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    
    await _plugin.show(id: id,
    payload: payload,
    body:body ,
    title:title ,
    notificationDetails: _details,
    );
  }

  static Future<void> scheduleIn({
    required int id,
    required String title,
    required String body,
    required Duration delay,
    String? payload,
  }) async {
    await _plugin.zonedSchedule(
      id: id,
      scheduledDate: tz.TZDateTime.now(tz.local).add(delay),
      notificationDetails: _details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      body: body,
      title: title,
      payload: payload,
    );

    
  }

  static Future<void> cancel(int id) async {
    _plugin.cancel(id: id);
  }

  static Future<void> cancelAll() async {
    _plugin.cancelAll();
  }
}
