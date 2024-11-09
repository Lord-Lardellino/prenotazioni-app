import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:memos_app/dialogs/add_memo_dialog.dart';
import 'package:memos_app/dialogs/delete_memo_dialog.dart';
import 'package:memos_app/dialogs/sign_out_dialog.dart';
import 'utilities/dependencies.dart' as dependencies;

class MemoCard extends StatelessWidget {
  final String timeStamp;
  final String content;
  final int index;
  final Function scrollToBottom;

  const MemoCard(
      {required this.timeStamp,
      required this.content,
      required this.index,
      required this.scrollToBottom,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      color: Colors.white,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(DateFormat.d().add_M().add_y().format(
                    DateTime.parse(timeStamp).add(const Duration(hours: 3)))),
                const SizedBox(width: 30),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return DeleteMemoDialog(
                                scrollToBottom: scrollToBottom, index: index);
                          });
                    },
                    icon: const Icon(Icons.delete))
              ],
            ),
            const Divider(),
            Text(content),
          ],
        ),
      ),
    );
  }
}

class MemoPage extends StatefulWidget {
  const MemoPage({super.key});

  @override
  State<StatefulWidget> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  var memoController = TextEditingController();
  var scrollController = ScrollController();
  RxString status = 'type-memo'.obs;

  void scrollToBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!Get.find<dependencies.AuthController>().isSignedIn.value) {
        Get.toNamed('/home_page');
      }
      if (Get.find<dependencies.AuthController>().memos.isNotEmpty) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        leading: const SizedBox.shrink(),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              child: const Row(
                children: [
                  Text('Sign Out'),
                  SizedBox(width: 10),
                  Icon(Icons.logout),
                ],
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const SignOutDialog();
                    });
              },
            ),
          ),
        ],
        title: Center(
          child:
              Text(Get.find<dependencies.AuthController>().signedInEmail.value),
        ),
      ),
      body: Stack(
        children: [
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                  gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1,
                colors: [Colors.white, Colors.blueAccent],
              ))),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 500),
              child: Obx(
                  () => Get.find<dependencies.AuthController>().memos.isEmpty
                      ? const Center(child: Text('No memos yet'))
                      : ListView.builder(
                          controller: scrollController,
                          padding: const EdgeInsets.only(top: 20, bottom: 130),
                          itemCount: Get.find<dependencies.AuthController>()
                              .memos
                              .length,
                          itemBuilder: (context, index) {
                            return MemoCard(
                                timeStamp:
                                    Get.find<dependencies.AuthController>()
                                        .memos[index]['timestamp'],
                                content: Get.find<dependencies.AuthController>()
                                    .memos[index]['content'],
                                index: index,
                                scrollToBottom: scrollToBottom);
                          },
                        )),
            ),
          )
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(
          top: 5,
          left: 5,
          right: 5,
          bottom: 20,
        ),
        child: IconButton(
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            foregroundColor: WidgetStatePropertyAll(Colors.black),
          ),
          icon: const Icon(Icons.add, size: 50),
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AddMemoDialog(scrollToBottom: scrollToBottom);
                });
          },
        ),
      ),
    );
  }
}
