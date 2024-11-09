import 'package:flutter/material.dart';
import 'package:memos_app/utilities/app_navigaton.dart';
import 'package:memos_app/widgets/main_wrapper.dart';
import 'package:memos_app/widgets/rounded_button.dart';
import 'package:memos_app/home_page.dart';
import 'package:memos_app/utilities/nofication_manager.dart';
import 'package:get/get.dart';
import 'package:memos_app/utilities/theme.dart';
import 'utilities/dependencies.dart' as dependencies;
import 'utilities/routes.dart' as routes;
import 'package:timezone/data/latest.dart' as tz;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  NotificationManager().initNotifications();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp.router(
      title: 'Appointments App',
      theme: ThemesList.light,
      darkTheme: ThemesList.dark,
      debugShowCheckedModeBanner: false,
      routeInformationProvider: AppNavigation.router.routeInformationProvider,
      routerDelegate: AppNavigation.router.routerDelegate,
      routeInformationParser: AppNavigation.router.routeInformationParser,
    );
  }
}

//HomePage(
//themeMode: themeMode,
//changeTheme: () {
//setState(() {
//themeMode =
//themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
//NotificationManager().simpleNotificationShow();
//});
//},
//),
