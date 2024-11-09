import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:memos_app/utilities/nofication_manager.dart';
import 'Widgets/rounded_button.dart';

class NotificationTest extends StatefulWidget {
  const NotificationTest({super.key});

  @override
  State<StatefulWidget> createState() => _NotificationTestState();
}

class _NotificationTestState extends State<NotificationTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedButton(
            onPressed: () {
              NotificationManager().simpleNotificationShow();
            },
            title: 'Simple Notification',
          ),
          const SizedBox(
            height: 20,
          ),
          RoundedButton(
            onPressed: () {
              NotificationManager().bigPictureNotificationShow();
            },
            title: 'Big Pic Notification',
          ),
          const SizedBox(
            height: 20,
          ),
          RoundedButton(
            onPressed: () {
              NotificationManager().multipleNotificationShow();
            },
            title: 'Multiple Notification',
          ),
          const SizedBox(
            height: 20,
          ),
          RoundedButton(
            onPressed: () {
              NotificationManager().scheduledNotificationShow();
            },
            title: 'Scheduled Notification',
          ),
        ],
      ),
    ));
  }
}
