import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> handleBackgroundMessages(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    print('FCM Token : $fCMToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessages);

    await _setupLocalNotifications();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showForegroundNotification(message);
    });
  }

  Future<void> _setupLocalNotifications() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings =
        InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(initializationSettings);
  }

  Future<void> _showForegroundNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'channel_id', // Sesuaikan ID channel
      'Channel Name', // Sesuaikan nama channel
      importance: Importance.high,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      message.notification.hashCode,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
  }
}
