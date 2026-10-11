import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_manager_firebase_assignment/common/service/push_notificattion_service.dart';

Future<void> saveDeviceTokenToFirestore() async {
  // 1. Get the current user's ID
  String? userId = FirebaseAuth.instance.currentUser?.uid;
  
  // 2. Fetch the unique FCM token we generated in PushNotificationService
  String? fcmToken = await PushNotificationService.getToken();

  if (userId != null && fcmToken != null) {
    // 3. Save it to a 'users' collection under their specific UID
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'fcmToken': fcmToken,
      'lastUpdated': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true)); // merge: true prevents overwriting other user data
  }
}
