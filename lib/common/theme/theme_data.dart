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
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
//set textFormField data
  inputDecorationTheme: InputDecorationTheme(
    // border: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(10),
    // ),
    // enabledBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(10),
    //   borderSide: const BorderSide(
    //     color: Colors.black,
    //   ),
    // ),
    // focusedBorder: OutlineInputBorder(
    //   borderRadius: BorderRadius.circular(10),
    //   borderSide: const BorderSide(
    //     color: Colors.black,
    //   ),
    // ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.red,
      ),
    ),
    //   focusedErrorBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(10),
    //     borderSide: const BorderSide(
    //       color: Colors.red,
    //     ),
    //   ),
    //   errorStyle: TextStyle(
    //     color: Colors.red,
    //   ),
    // ),
    // textButtonTheme: TextButtonThemeData(
    //   style: ButtonStyle(
    //     foregroundColor: MaterialStateProperty.all(Colors.black),
    // ),
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
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  textTheme: GoogleFonts.loraTextTheme(
    ThemeData.dark().textTheme,
  ),
//set textFormField data

  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.white,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.white,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.red,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.red,
      ),
    ),
  ),
);
