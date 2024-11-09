import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memos_app/appointment_page.dart';
import 'package:memos_app/home_page.dart';
import 'package:memos_app/memo_page.dart';

class Routes {

  static String memoPage = '/memo_page';
  static String appointmentPage = '/appointment_page';
}

final getPages = [


  GetPage(name: Routes.memoPage, page: () => const MemoPage()),
  GetPage(name: Routes.appointmentPage, page: () => const AppointmentPage()),
];
