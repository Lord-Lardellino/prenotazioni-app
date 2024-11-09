import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:memos_app/Controllers/theme_controller.dart';
import 'package:memos_app/utilities/dependencies.dart' as dependencies;
import 'package:memos_app/utilities/routes.dart';
import 'package:memos_app/widgets/input_field.dart';
import 'package:memos_app/widgets/rounded_button.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';

class MainWrapper extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainWrapper({super.key, required this.navigationShell});

  @override
  State<StatefulWidget> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int selectedIndex = 0;

  ThemeController themeController = Get.put(ThemeController());

  void _goToBranch(int index) {
    widget.navigationShell.goBranch(index,
        initialLocation: index == widget.navigationShell.currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: widget.navigationShell,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: SlidingClippedNavBar(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          activeColor: context.theme.primaryColor,
          onButtonPressed: (index) {
            setState(() {
              selectedIndex = index;
            });
            _goToBranch(selectedIndex);
          },
          fontSize: 16,
          iconSize: 30,
          selectedIndex: selectedIndex,
          barItems: [
            BarItem(
              icon: Icons.home,
              title: 'Home',
            ),
            BarItem(
              icon: Icons.note_add,
              title: 'Appointments',
            ),
            BarItem(
              icon: Icons.manage_accounts,
              title: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  appBar() {
    return AppBar(
      title: const Text('App'),
      centerTitle: true,
      backgroundColor: context.theme.primaryColor,
      actions: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
              iconSize: 30,
              icon: const Icon(
                Icons.wb_sunny,
                color: Colors.white,
              ),
              onPressed: () {
                themeController.changeTheme();
              }),
        )
      ],
    );
  }
}
