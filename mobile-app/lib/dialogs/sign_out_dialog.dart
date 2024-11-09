import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memos_app/utilities/dependencies.dart' as dependencies;

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: const Text('Sign Out?', textAlign: TextAlign.center),
      actions: [
        ElevatedButton(
            onPressed: () {
              Get.find<dependencies.AuthController>().signOut();
            },
            child: const Text('Yes')),
        ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'))
      ],
    );
  }
}
