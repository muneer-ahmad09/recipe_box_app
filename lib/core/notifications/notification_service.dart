import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_router.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  final NotificationRouter _notificationRouter =
  const NotificationRouter();

  Future<void> initialize() async {
    await _initializeLocalNotifications();
    await _initializeFirebaseMessaging();
  }

  // Future<void> _initializeLocalNotifications() async {
  //   const androidSettings = AndroidInitializationSettings(
  //     '@mipmap/ic_launcher',
  //   );
  //
  //   const settings = InitializationSettings(
  //     android: androidSettings,
  //   );
  //
  //   await _localNotifications.initialize(settings: settings);
  // }

  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const settings = InitializationSettings(android: androidSettings);

    await _localNotifications.initialize(
      settings: settings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  // void _onNotificationTapped(NotificationResponse response) {
  //   final payload = response.payload;
  //
  //   if (payload == null) {
  //     return;
  //   }
  //
  //   final data = jsonDecode(payload);
  //
  //   print('NOTIFICATION TAPPED');
  //   print('Type: ${data['type']}');
  //   print('Recipe ID: ${data['recipeId']}');
  // }

  void _onNotificationTapped(
      NotificationResponse response,
      ) {
    final payload = response.payload;

    if (payload == null) {
      return;
    }

    final data = jsonDecode(payload) as Map<String, dynamic>;

    _notificationRouter.handle(data);
  }

  Future<void> _initializeFirebaseMessaging() async {
    await _firebaseMessaging.requestPermission();

    final token = await _firebaseMessaging.getToken();

    // print('FCM TOKEN: $token');

    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(
      _handleNotificationOpenedFromBackground,
    );
    final initialMessage = await _firebaseMessaging.getInitialMessage();

    if (initialMessage != null) {
      _handleNotificationOpenedFromTerminated(initialMessage);
    }
  }

  // void _handleNotificationOpenedFromTerminated(RemoteMessage message) {
  //   print('NOTIFICATION OPENED FROM TERMINATED APP');
  //   print('Data: ${message.data}');
  // }

  void _handleNotificationOpenedFromTerminated(
      RemoteMessage message,
      ) {
    _notificationRouter.handle(message.data);
  }

  void _handleNotificationOpenedFromBackground(
      RemoteMessage message,
      ) {
    _notificationRouter.handle(message.data);
  }
  // void _handleNotificationOpenedFromBackground(RemoteMessage message) {
  //   print('NOTIFICATION OPENED FROM BACKGROUND');
  //   print('Data: ${message.data}');
  // }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    print('Foreground notification received');
    print('Title: ${message.notification?.title}');
    print('Body: ${message.notification?.body}');

    await _showLocalNotification(message);
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'Default Notifications',
      channelDescription: 'Default notification channel',
      importance: Importance.high,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      id: message.hashCode,
      title: message.notification?.title ?? 'Recipe Box',
      body: message.notification?.body ?? '',
      notificationDetails: details,
      payload: jsonEncode(message.data),
    );
  }

  // Future<void> _showLocalNotification(
  //     RemoteMessage message,
  //     ) async {
  //   const androidDetails = AndroidNotificationDetails(
  //     'default_channel',
  //     'Default Notifications',
  //     channelDescription: 'Default notification channel',
  //     importance: Importance.high,
  //     priority: Priority.high,
  //   );
  //
  //   const details = NotificationDetails(
  //     android: androidDetails,
  //   );
  //
  //   await _localNotifications.show(
  //     id: message.hashCode,
  //     title: message.notification?.title ?? 'Recipe Box',
  //     body: message.notification?.body ?? '',
  //     notificationDetails: details,
  //     payload: message.data.toString(),
  //   );
  // }
}
