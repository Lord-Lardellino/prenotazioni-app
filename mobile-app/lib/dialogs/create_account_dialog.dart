import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memos_app/utilities/dependencies.dart' as dependencies;

class CreateAccountDialog extends StatefulWidget {
  const CreateAccountDialog({super.key});

  @override
  State<StatefulWidget> createState() => _CreateAccountDialogState();
}

class _CreateAccountDialogState extends State<CreateAccountDialog> {
  RxString status = 'enter-details'.obs;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  Widget detailsWidget() {
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
        const Text('Create Account'),
        const SizedBox(height: 30),
        SizedBox(
          width: 300,
          child: TextFormField(
            decoration: const InputDecoration(hintText: 'First Name'),
            controller: firstNameController,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          child: TextFormField(
            decoration: const InputDecoration(hintText: 'Last Name'),
            controller: lastNameController,
          ),
        ),
        const SizedBox(height: 20),
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
                  if (firstNameController.text.isNotEmpty &&
                      lastNameController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    status.value = 'creating-account';
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
                child: const Text('Create')),
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

  Widget createAccountWidget() {
    return FutureBuilder(
        future: Get.find<dependencies.AuthController>().createAccount(
          firstNameController.text,
          lastNameController.text,
          emailController.text,
          passwordController.text,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Creating account'),
                  SizedBox(height: 20),
                  CircularProgressIndicator()
                ],
              ),
            );
          } else {
            if (snapshot.data == 'success') {
              return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    const Text('Account created!'),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Close'))
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
                          status.value = 'enter-details';
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
      body: Obx(() => status.value == 'enter-details'
          ? detailsWidget()
          : status.value == 'creating-account'
              ? createAccountWidget()
              : const SizedBox()),
    );
  }
}
