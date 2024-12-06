import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract class NotificationUtil {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static bool isFlutterLocalNotificationsInitialized = false;

  static const AndroidNotificationDetails
      _androidPlatformRemoteChannelSpecifics = AndroidNotificationDetails(
    'wooahan_remote_channel_id',
    '우아한',
    channelDescription: 'Wooahan Local Channel',
    importance: Importance.high,
    priority: Priority.high,
    showWhen: false,
  );

  static const NotificationDetails _platformRemoteChannelSpecifics =
      NotificationDetails(
    android: _androidPlatformRemoteChannelSpecifics,
    iOS: DarwinNotificationDetails(),
  );

  static Future<void> initialize() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    DarwinInitializationSettings initializationSettingsIOS =
        const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _plugin.initialize(initializationSettings);
  }

  static Future<void> setupRemoteNotification() async {
    if (isFlutterLocalNotificationsInitialized) return;

    AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'wooahan_remote_channel_id',
      '우아한',
      description: 'Wooahan Remote Channel',
      importance: Importance.high,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // iOS foreground notification 권한
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // IOS background 권한 체킹 , 요청
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    isFlutterLocalNotificationsInitialized = true;
  }

  @pragma('vm:entry-point')
  static Future<void> onBackgroundHandler(
    RemoteMessage message,
  ) async {}

  static void onForegroundHandler(
    RemoteMessage message,
  ) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;

    if (notification != null && android != null) {
      _plugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        _platformRemoteChannelSpecifics,
      );
    }
  }
}
