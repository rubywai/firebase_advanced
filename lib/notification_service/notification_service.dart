import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
GlobalKey<NavigatorState> scaffoldKey = GlobalKey();
final messagingInstance = FirebaseMessaging.instance;
const _androidChannel = AndroidNotificationChannel(
  'high_important_channel',
  'High important notification',
  importance: Importance.high,
);
final _localNotification = FlutterLocalNotificationsPlugin();

Future<void> init() async {
  // Requesting permission for notifications
  String? token = await messagingInstance.getToken();
  messagingInstance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  messagingInstance.subscribeToTopic("all").then((value){
  });
  await _localNotification.initialize(const InitializationSettings(
    android: AndroidInitializationSettings("@mipmap/ic_launcher"),
  ));
  FirebaseMessaging.onMessage.listen((message) {
    final notification = message.notification;
    _localNotification.show(
      notification.hashCode,
      notification?.title,
      notification?.body,
      NotificationDetails(
          android: AndroidNotificationDetails(
        _androidChannel.id,
        _androidChannel.name,
      )),
    );
  });
  FirebaseMessaging.onBackgroundMessage(onBackgroundMessage);
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
   scaffoldKey.currentState?.pushNamed(event.data['screen']);
  });

}

void requestPermission() {
  messagingInstance.requestPermission();
}

void showDialog() {}
@pragma('vm:entry-point')
Future<void> onBackgroundMessage(RemoteMessage message) async{
  print(message.notification?.title);
  print(message.notification?.body);
  print(message.data);

}
