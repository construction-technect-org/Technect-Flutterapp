import 'dart:io';

import 'package:construction_technect/app/core/utils/imports.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Top-level function for background message handler (must be top-level)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint('Handling background message: ${message.messageId}');
  debugPrint('Notification Title: ${message.notification?.title}');
  debugPrint('Notification Body: ${message.notification?.body}');
  debugPrint('Data: ${message.data}');
}

class FCMService {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static String? _fcmToken;
  static FlutterLocalNotificationsPlugin? _localNotifications;

  /// Initialize FCM and request permissions
  static Future<void> initialize() async {
    try {
      // Initialize local notifications for foreground notifications
      await _initializeLocalNotifications();

      // Set up background message handler
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

      // Request notification permissions
      final NotificationSettings settings = await _firebaseMessaging
          .requestPermission();

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        debugPrint('User granted notification permission');
      } else if (settings.authorizationStatus ==
          AuthorizationStatus.provisional) {
        debugPrint('User granted provisional notification permission');
      } else {
        debugPrint('User declined or has not accepted notification permission');
      }

      // Get FCM token
      await getFCMToken();

      // Listen for token refresh
      _firebaseMessaging.onTokenRefresh.listen((newToken) {
        _fcmToken = newToken;
        debugPrint('FCM Token refreshed: $newToken');
        // You can call your API here to update the token
        _updateTokenOnServer(newToken);
      });

      // Handle foreground messages
      FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

      // Handle notification taps (when app is in background or terminated)
      FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

      // Check if app was opened from a notification (terminated state)
      final RemoteMessage? initialMessage = await _firebaseMessaging
          .getInitialMessage();
      if (initialMessage != null) {
        _handleNotificationTap(initialMessage);
      }
    } catch (e) {
      debugPrint('Error initializing FCM: $e');
    }
  }

  /// Initialize local notifications for foreground display
  static Future<void> _initializeLocalNotifications() async {
    _localNotifications = FlutterLocalNotificationsPlugin();

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings();

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications!.initialize(
      initSettings,
      onDidReceiveNotificationResponse: (details) {
        // Handle notification tap
        if (details.payload != null) {
          try {
            // Parse payload string back to Map
            // Simple parsing - adjust based on your payload format
            debugPrint('Notification payload: ${details.payload}');
          } catch (e) {
            debugPrint('Error parsing notification payload: $e');
          }
        }
      },
    );

    // Create notification channel for Android
    if (Platform.isAndroid) {
      const androidChannel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
      );

      await _localNotifications!
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(androidChannel);
    }
  }

  /// Handle foreground messages (when app is open)
  static Future<void> _handleForegroundMessage(RemoteMessage message) async {
    debugPrint('Received foreground message: ${message.messageId}');
    debugPrint('Title: ${message.notification?.title}');
    debugPrint('Body: ${message.notification?.body}');
    debugPrint('Data: ${message.data}');

    // Show local notification for foreground messages
    if (message.notification != null && _localNotifications != null) {
      final notification = message.notification!;
      const androidDetails = AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important notifications.',
        importance: Importance.high,
        priority: Priority.high,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const details = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      // Convert data map to JSON string for payload
      final payload = message.data
          .map((key, value) => MapEntry(key, value.toString()))
          .toString();

      await _localNotifications!.show(
        message.hashCode,
        notification.title,
        notification.body,
        details,
        payload: payload,
      );
    }

    // Handle notification data
    _handleNotificationData(message.data);
  }

  /// Handle notification tap (when app is in background or terminated)
  static void _handleNotificationTap(RemoteMessage message) {
    debugPrint('Notification tapped: ${message.messageId}');
    debugPrint('Data: ${message.data}');
    _handleNotificationData(message.data);
  }

  /// Handle notification data and navigate accordingly
  static void _handleNotificationData(Map<String, dynamic> data) {
    try {
      final type = data['type'] as String?;
      final notificationType = data['notificationType'] as String?;
      final entityType = data['entityType'] as String?;
      final entityId = data['entityId'] as String?;
      final groupId = data['groupId'] as String?;

      // Handle group chat messages
      if (type == 'group_message' || groupId != null) {
        // Navigate to group chat
        if (groupId != null) {
          Get.toNamed('/chat/group/$groupId');
        }
      }
      // Handle regular notifications
      else if (notificationType != null) {
        // Navigate based on notification type
        if (entityType == 'product' && entityId != null) {
          // Navigate to product details or product notifications
          Get.toNamed('/notifications/product');
        } else if (entityType == 'service' && entityId != null) {
          // Navigate to service details or service notifications
          Get.toNamed('/notifications/service');
        } else if (entityType == 'connection_request' && entityId != null) {
          // Navigate to connection request
          Get.toNamed('/connection-request/$entityId');
        } else {
          // Navigate to general notifications
          Get.toNamed('/notifications');
        }
      }
    } catch (e) {
      debugPrint('Error handling notification data: $e');
    }
  }

  /// Update token on server when it refreshes
  static Future<void> _updateTokenOnServer(String newToken) async {
    try {
      // Check if user is logged in (has token)
      final token = myPref.getToken();
      if (token.isEmpty) {
        debugPrint('User not logged in, skipping token update');
        return;
      }

      debugPrint('Token refreshed, updating on server: $newToken');

      // Import API manager and update token
      final apiManager = ApiManager();
      await apiManager.postObject(
        url: 'fcm-token/register',
        body: {'fcmToken': newToken, 'deviceType': getDeviceType()},
      );

      debugPrint('FCM token updated on server successfully');
    } catch (e) {
      debugPrint('Error updating token on server: $e');
      // Don't throw - token update failure shouldn't break the app
    }
  }

  /// Get FCM token
  static Future<String?> getFCMToken() async {
    try {
      _fcmToken = await _firebaseMessaging.getToken();
      debugPrint('FCM Token: $_fcmToken');
      return _fcmToken;
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
      return null;
    }
  }

  /// Get current FCM token (cached)
  static String? get currentToken => _fcmToken;

  /// Get device type (ios or android)
  static String getDeviceType() {
    if (Platform.isIOS) {
      return 'ios';
    } else if (Platform.isAndroid) {
      return 'android';
    } else {
      return 'web';
    }
  }

  /// Delete FCM token (on logout)
  static Future<void> deleteToken() async {
    try {
      await _firebaseMessaging.deleteToken();
      _fcmToken = null;
      debugPrint('FCM Token deleted');
    } catch (e) {
      debugPrint('Error deleting FCM token: $e');
    }
  }
}
