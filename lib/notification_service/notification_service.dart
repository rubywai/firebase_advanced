import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey();
final _messagingInstance = FirebaseMessaging.instance;
final _localNotification = FlutterLocalNotificationsPlugin();
const _androidNotiChannel = AndroidNotificationChannel(
  'high_important_channel',
  'High important notification',
);

Future<void> initMessaging() async {
  String? token = await _messagingInstance.getToken();
  _messagingInstance.requestPermission();
  _messagingInstance.subscribeToTopic("all").then((value) {
    print('subscribe success to all');
  });

  _messagingInstance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  await _localNotification.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    ),
  );

  FirebaseMessaging.onMessage.listen(
    (event) {
      final notification = event.notification;
      _localNotification.show(
        notification.hashCode,
        notification?.title,
        notification?.body,
        NotificationDetails(
            android: AndroidNotificationDetails(
          _androidNotiChannel.id,
          _androidNotiChannel.name,
        )),
      );
    },
  );
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    if (event.data['screen'] != null) {
      navigatorKey.currentState?.pushNamed(
        event.data['screen'],
        arguments: event.data['data'],
      );
    }
  });
}
