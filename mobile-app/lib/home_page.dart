import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memos_app/utilities/dependencies.dart' as dependencies;
import 'package:memos_app/utilities/routes.dart';
import 'package:memos_app/widgets/input_field.dart';
import 'package:memos_app/widgets/rounded_button.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var emailController = TextEditingController();
  var passController = TextEditingController();

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text('Home')],
        ),
      ),
    );
  }
}
