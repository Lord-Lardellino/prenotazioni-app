import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memos_app/utilities/dependencies.dart' as dependencies;

class AddMemoDialog extends StatefulWidget {
  final Function scrollToBottom;

  const AddMemoDialog({required this.scrollToBottom, super.key});

  @override
  State<StatefulWidget> createState() => _AddMemoDialogState();
}

class _AddMemoDialogState extends State<AddMemoDialog> {
  RxString status = 'type-memo'.obs;
  var memoController = TextEditingController();

  Widget typeMemoWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 400,
            child: TextFormField(
              controller: memoController,
              decoration: const InputDecoration(
                hintText: 'Type...',
              ),
              maxLines: null,
            ),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    status.value = 'adding-memo';
                  },
                  child: const Text('Save')),
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

  Widget addingMemoWidget() {
    return FutureBuilder(
        future: Get.find<dependencies.AuthController>()
            .addMemo(memoController.text),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Adding memo'),
                  SizedBox(height: 20),
                  CircularProgressIndicator()
                ],
              ),
            );
          } else if (snapshot.data == 'success') {
            Future.delayed(const Duration(seconds: 1), () {
              widget.scrollToBottom();
              Navigator.pop(context);
            });
            return const Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text('Memo added'),
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
      body: Obx(() => status.value == 'type-memo'
          ? typeMemoWidget()
          : status.value == 'adding-memo'
              ? addingMemoWidget()
              : const SizedBox()),
    );
  }
}
