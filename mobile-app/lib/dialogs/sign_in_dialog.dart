import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memos_app/utilities/dependencies.dart' as dependencies;

class SignInDialog extends StatefulWidget {
  const SignInDialog({super.key});

  @override
  State<StatefulWidget> createState() => _SignInDialogState();
}

class _SignInDialogState extends State<SignInDialog> {
  RxString status = 'credentials'.obs;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Widget credentialsWidget() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        const SizedBox(height: 50),
        const Text('Sign In'),
        const SizedBox(height: 30),
        SizedBox(
          width: 300,
          child: TextFormField(
            decoration: const InputDecoration(hintText: 'Email'),
            controller: emailController,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          child: TextFormField(
            decoration: const InputDecoration(hintText: 'Password'),
            controller: passwordController,
          ),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
                onPressed: () {
                  if (emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    status.value = 'signing-in';
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: const Text('Fill all fields',
                                textAlign: TextAlign.center),
                            actions: [
                              ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Close'))
                            ],
                          );
                        });
                  }
                },
                child: const Text('Sign In')),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'))
          ],
        ),
      ],
    );
  }

  Widget signInWidget() {
    return FutureBuilder(
        future: Get.find<dependencies.AuthController>().signIn(
          emailController.text,
          passwordController.text,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Logging'),
                  SizedBox(height: 20),
                  CircularProgressIndicator()
                ],
              ),
            );
          } else {
            if (snapshot.data == 'success') {
              Future.delayed(const Duration(seconds: 1), () {
                Get.offNamed('/home');
              });
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Successfully signed in'),
                    SizedBox(height: 20),
                    CircularProgressIndicator()
                  ],
                ),
              );
            } else {
              return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text(snapshot.data!),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          status.value = 'credentials';
                        },
                        child: const Text('Try Again')),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'))
                  ]));
            }
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => status.value == 'credentials'
          ? credentialsWidget()
          : status.value == 'signing-in'
              ? signInWidget()
              : const SizedBox()),
    );
  }
}
