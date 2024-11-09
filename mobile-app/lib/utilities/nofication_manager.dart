import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationManager {
  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    AndroidInitializationSettings initAndroidSettings =
        const AndroidInitializationSettings('ic_launcher');

    DarwinInitializationSettings initIosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );

    InitializationSettings initSettings = InitializationSettings(
        android: initAndroidSettings, iOS: initIosSettings);

    await notificationPlugin.initialize(initSettings,
        onDidReceiveNotificationResponse: (details) {});
  }

  Future<void> simpleNotificationShow() async {
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails(
            "channelId",
            "channelName",
            priority: Priority.high,
            importance: Importance.max,
            icon: 'ic_launcher',
            channelShowBadge: true,
            largeIcon: DrawableResourceAndroidBitmap('ic_launcher'));

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await notificationPlugin.show(
        0, 'Simple Notification', 'Hello', notificationDetails);
  }

  Future<void> scheduledNotificationShow() async {
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails("scheduledChannelId", "scheduledChannelName",
            priority: Priority.high,
            importance: Importance.max,
            icon: 'ic_launcher',
            channelShowBadge: true,
            largeIcon: DrawableResourceAndroidBitmap('ic_launcher'));

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await notificationPlugin.zonedSchedule(
        0,
        'Scheduled Notification',
        'Hello',
        tz.TZDateTime.from(
            DateTime.now().add(const Duration(seconds: 5)), tz.local),
        notificationDetails,
        matchDateTimeComponents: DateTimeComponents.dateAndTime,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> bigPictureNotificationShow() async {
    BigPictureStyleInformation bigPicDetails = const BigPictureStyleInformation(
        DrawableResourceAndroidBitmap('ic_launcher'),
        contentTitle: 'Code Compilee',
        largeIcon: DrawableResourceAndroidBitmap('ic_launcher'));

    AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        "bigPicId", "bigPicName",
        priority: Priority.high,
        importance: Importance.max,
        styleInformation: bigPicDetails);

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await notificationPlugin.show(
        0, 'Simple Notification', 'Hello', notificationDetails);
  }

  Future<void> multipleNotificationShow() async {
    AndroidNotificationDetails androidDetails =
        const AndroidNotificationDetails("channelId", "channelName",
            priority: Priority.high,
            importance: Importance.max,
            icon: 'ic_launcher',
            groupKey: 'commonMessage');

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidDetails);

    await notificationPlugin.show(
        0, 'New Notification', 'User 1', notificationDetails);

    Future.delayed(const Duration(microseconds: 1000), () {
      notificationPlugin.show(
          1, 'New Notification', 'User 2', notificationDetails);
    });
    Future.delayed(const Duration(microseconds: 1500), () {
      notificationPlugin.show(
          2, 'New Notification', 'User 3', notificationDetails);
    });

    List<String> lines = ['user1', 'user2', 'user3'];

    InboxStyleInformation inboxStyleInf =
        InboxStyleInformation(lines, contentTitle: '${lines.length} messages');

    AndroidNotificationDetails androidDetailsSpecifics =
        AndroidNotificationDetails("groupChannelId", "groupChannelName",
            styleInformation: inboxStyleInf,
            groupKey: 'commonMessage',
            setAsGroupSummary: true);

    NotificationDetails pltChannelSpec =
        NotificationDetails(android: androidDetailsSpecifics);

    await notificationPlugin.show(
        3, 'More messages', '${lines.length} messages', notificationDetails);
  }
}
