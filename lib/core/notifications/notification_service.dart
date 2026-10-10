import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_router.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  String? _fcmToken;

  Stream<String> get onTokenRefresh => _firebaseMessaging.onTokenRefresh;

  String? get fcmToken => _fcmToken;

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  final NotificationRouter _notificationRouter = NotificationRouter();

  Future<void> initialize() async {
    await _initializeLocalNotifications();
    await _initializeFirebaseMessaging();
  }

  Future<String?> getToken() async {
    if (_fcmToken != null) {
      return _fcmToken;
    }

    _fcmToken = await _firebaseMessaging.getToken();

    return _fcmToken;
  }

  void handlePendingNotification() {
    _notificationRouter.handlePending();
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

  void _onNotificationTapped(NotificationResponse response) {
    final payload = response.payload;

    if (payload == null) {
      return;
    }

    final data = jsonDecode(payload) as Map<String, dynamic>;

    _notificationRouter.handle(data);
  }

  Future<void> _initializeFirebaseMessaging() async {
    await _firebaseMessaging.requestPermission();

    _fcmToken = await _firebaseMessaging.getToken();

    debugPrint('FCM token obtained: $_fcmToken');

    FirebaseMessaging.instance.onTokenRefresh.listen((token) {
      _fcmToken = token;

      debugPrint('FCM token refreshed: $token');
    });

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

  void _handleNotificationOpenedFromTerminated(RemoteMessage message) {
    _notificationRouter.handle(message.data);
  }

  void _handleNotificationOpenedFromBackground(RemoteMessage message) {
    _notificationRouter.handle(message.data);
  }

  // void _handleNotificationOpenedFromBackground(RemoteMessage message) {
  //   print('NOTIFICATION OPENED FROM BACKGROUND');
  //   print('Data: ${message.data}');
  // }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {

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
