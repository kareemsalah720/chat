import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseNotifications {
  // Create an instance of FirebaseMessaging
  final _firebaseMessaging = FirebaseMessaging.instance;
  // Initialize Firebase Messaging
  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    String? token = await _firebaseMessaging.getToken();
    print("Token....: $token");
    handleBackgroundMessages();
  }
  // Handle incoming messages
  void handleMessages(RemoteMessage? message) {
    if (message != null) {
      print('Message title: ${message.notification?.title}');
      print('Message body: ${message.notification?.body}');
      print('Message data: ${message.data}');
    }
    
  }
  // Handle background messages
  Future <void> handleBackgroundMessages() async {
    FirebaseMessaging.instance.getInitialMessage().then((handleMessages));
    FirebaseMessaging.onMessageOpenedApp.listen((handleMessages));
    
  }
}