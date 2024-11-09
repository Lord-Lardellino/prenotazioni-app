import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:memos_app/utilities/theme.dart';

class AppointmentPage extends StatefulWidget {
  const AppointmentPage({super.key});

  @override
  State<StatefulWidget> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime selectedData = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          taskBar(),
          datePicker(),
        ],
      ),
    );
  }

  taskBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMMd().format(DateTime.now()),
                style: subHeadingStyle,
              ),
              Text(
                "Today",
                style: headingStyle,
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 30),
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              shape: const WidgetStatePropertyAll<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
              backgroundColor:
                  WidgetStatePropertyAll(context.theme.primaryColor),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                '+ Add Task',
                style: TextStyle(
                    fontSize: 18, color: context.theme.scaffoldBackgroundColor),
              ),
            ),
          ),
        ),
      ],
    );
  }

  datePicker() {
    return DatePicker(
      DateTime.now(),
      height: 100,
      width: 80,
      initialSelectedDate: DateTime.now(),
      selectionColor: context.theme.primaryColor,
      dateTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.w600, color: Colors.grey)),
      dayTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: Colors.grey)),
      monthTextStyle: GoogleFonts.lato(
          textStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
      onDateChange: (date) {
        selectedData = date;
        print(date.toString());
      },
    );
  }
}
