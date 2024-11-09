import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

Color prymary_color = Colors.green[300]!;
Color secondary_color = Colors.green[400]!;
Color dark_prymary_color = Colors.green[600]!;
Color dark_secondary_color = Colors.green[700]!;
Color dark_scaffold_color = Colors.grey[700]!;

class ThemesList {
  static final light = ThemeData(
      primaryColor: prymary_color,
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white);

  static final dark = ThemeData(
      primaryColor: dark_prymary_color,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: dark_scaffold_color);
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[400]));
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold));
}
