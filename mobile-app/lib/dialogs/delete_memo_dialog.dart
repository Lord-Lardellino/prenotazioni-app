import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memos_app/utilities/dependencies.dart' as dependencies;

class DeleteMemoDialog extends StatefulWidget {
  final Function scrollToBottom;
  final int index;

  const DeleteMemoDialog(
      {required this.scrollToBottom, required this.index, super.key});

  @override
  State<StatefulWidget> createState() => _DeleteMemoDialogState();
}

class _DeleteMemoDialogState extends State<DeleteMemoDialog> {
  RxString status = 'delete-memo'.obs;
  var memoController = TextEditingController();

  Widget deleteMemoWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Delete this memo?'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    status.value = 'deleting-memo';
                  },
                  child: const Text('Delete')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
            ],
          ),
        ],
      ),
    );
  }

  Widget deletingMemoWidget() {
    return FutureBuilder(
        future:
            Get.find<dependencies.AuthController>().deleteMemo(widget.index),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Deleting memo'),
                  SizedBox(height: 20),
                  CircularProgressIndicator()
                ],
              ),
            );
          } else if (snapshot.data == 'success') {
            Future.delayed(const Duration(seconds: 1), () {
              if (Get.find<dependencies.AuthController>().memos.isNotEmpty) {
                widget.scrollToBottom();
              }
              Navigator.pop(context);
            });
            return const Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text('Memo deleted'),
                  SizedBox(height: 20),
                  CircularProgressIndicator()
                ]));
          } else {
            return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text(snapshot.data!),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Close'))
                ]));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => status.value == 'delete-memo'
          ? deleteMemoWidget()
          : status.value == 'deleting-memo'
              ? deletingMemoWidget()
              : const SizedBox()),
    );
  }
}
