import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:task_manager_firebase_assignment/common/service/local_notification_service.dart';
import 'package:task_manager_firebase_assignment/common/service/push_notificattion_service.dart';
import 'package:task_manager_firebase_assignment/firebase_options.dart';

class Global {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await GoogleSignIn.instance.initialize();

   await LocalNotificationsService.init();
   // FirebaseMessaging.onBackgroundMessage(Fire)
    await PushNotificationService.init();
  }
}
