import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:memos_app/dialogs/create_account_dialog.dart';
import 'package:memos_app/dialogs/sign_in_dialog.dart';
import 'package:memos_app/utilities/dependencies.dart' as dependencies;
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () async {
                    var tok = await Get.find<dependencies.AuthController>()
                        .getToken();
                    Map<String, dynamic> decodedToken = JwtDecoder.decode(tok!);

                    var res = await http.get(
                        Uri.parse('https://www.web-by.it/api/Admin'),
                        headers: <String, String>{
                          'Content-Type': 'application/json; charset=UTF-8',
                          HttpHeaders.authorizationHeader: 'Bearer $tok'
                        });

                    print(res.body);
                  },
                  child: const Text('Create')),
              Text('Memo App', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const SignInDialog();
                        });
                  },
                  child: const Text('Sign In')),
              const SizedBox(width: 20),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const CreateAccountDialog();
                        });
                  },
                  child: const Text('Sign Up')),
            ],
          ),
        )
      ],
    );
  }
}
