import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:memos_app/appointment_page.dart';
import 'package:memos_app/home_page.dart';
import 'package:memos_app/widgets/main_wrapper.dart';

class AppNavigation {
  AppNavigation._();

  static String home = '/home_page';
  static String appointment = '/appointment_page';

  static final _rootNavKey = GlobalKey<NavigatorState>();
  static final _rootNavHome =
      GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _rootNavAppointment =
      GlobalKey<NavigatorState>(debugLabel: 'shellAppointment');

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: <RouteBase>[
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(
            navigationShell: navigationShell,
          );
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(navigatorKey: _rootNavHome, routes: [
            GoRoute(
                path: home,
                name: 'Home',
                builder: (context, state) {
                  return HomePage(
                    key: state.pageKey,
                  );
                })
          ]),
          StatefulShellBranch(navigatorKey: _rootNavAppointment, routes: [
            GoRoute(
                path: appointment,
                name: 'Appointment',
                builder: (context, state) {
                  return AppointmentPage(
                    key: state.pageKey,
                  );
                }),
          ])
        ],
      )
    ],
  );
}
