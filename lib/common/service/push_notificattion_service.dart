import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:task_manager_firebase_assignment/common/routes/app_navigator.dart';
import 'package:task_manager_firebase_assignment/common/service/local_notification_service.dart';
// 1. CRITICAL ADDITION: This must be a top-level (outside the class) global function 
// to handle background/terminated data notifications.
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Handling a background message: ${message.messageId}");
}
//vm: Entry point
class PushNotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static final ValueNotifier<List<RemoteMessage>> foregroundMessage =
      ValueNotifier<List<RemoteMessage>>([]);

  static Future<void> init() async {
    // ask the user to allow notification
    final NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      sound: true,
      badge: true,
    );

    if (kDebugMode) {
      print('User granted permission:${settings.authorizationStatus}');
    }
    // Forces the device to show a visual banner even if the app is open
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // 3. CRITICAL ADDITION: Register the background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    
    
    ///1.  FCM gives us the message
    ///App is open (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(
        'foreground message id:${message.messageId} data:${message.data}',
      );
      if (kDebugMode) {
        print("Received foreground message: ${message.notification?.title}");
      }
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        LocalNotificationsService.showNow(
          id: notification.hashCode,
          title: notification.title ?? '',
          body: notification.body ?? '',
          payload: message.data['screen'] ?? '', // Pass your routing data as the payload
        );
      }

      foregroundMessage.value = [...foregroundMessage.value, message];
    });

    ///2. App is minimized (Background) -> User taps the notification banner

    FirebaseMessaging.onMessageOpenedApp.listen(openFromMessage);

    // 4. CRITICAL ADDITION: Trigger the terminated state check on startup
    await handleLaunchMessage();
    getToken();
  }

  // app is terminated : then trigger this
  static Future<void> handleLaunchMessage() async {
    final RemoteMessage? initialMessage = await _messaging.getInitialMessage();
    if (initialMessage != null) {
      openFromMessage(initialMessage);
    }
  }

  // personalization / public notification
  static void openFromMessage(RemoteMessage message) {
    AppNavigator.openDetails(message.data['screen'] ?? '');
  }

  static Future<String?> getToken() async {
    final String? token = await _messaging.getToken(); //return FCM token
    debugPrint('FCM token is:$token');
    return token;
  }
}
