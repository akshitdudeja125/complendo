import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  switchTheme: SwitchThemeData(
// for light theme
    thumbColor: MaterialStateProperty.all(Colors.white),
    trackColor: MaterialStateProperty.all(Colors.grey),
  ),
  textTheme: GoogleFonts.loraTextTheme(
    ThemeData.light().textTheme,
  ),
);

final ThemeData darkThemeData = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.white),
      trackColor: MaterialStateProperty.all(Colors.grey),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
    ),
    textTheme: GoogleFonts.loraTextTheme(
      ThemeData.dark().textTheme,
    ));
