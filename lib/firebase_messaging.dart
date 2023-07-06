import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingService {
  FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future getFirebaseToken() async {
    return await _fcm.getToken();
  }

  Future<void> initialize() async {
    // Request permission for foreground notifications
    NotificationSettings settings = await _fcm.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Configure handlers for foreground messages
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        // Handle the incoming message when the app is in the foreground
        print("Handling a foreground message: ${message.messageId}");
      });
    }
  }
}
