import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData lightThemeData = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  iconButtonTheme: IconButtonThemeData(
    style: ButtonStyle(
      overlayColor:
          MaterialStateProperty.all(const Color.fromARGB(255, 6, 56, 97)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.black),
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor: MaterialStateProperty.all(Colors.white),
    trackColor: MaterialStateProperty.all(Colors.grey),
  ),
  textTheme: GoogleFonts.loraTextTheme(
    ThemeData.light().textTheme,
  ),
  primaryIconTheme: const IconThemeData(
    color: Colors.grey,
  ),
  iconTheme: const IconThemeData(
    color: Colors.grey,
  ),
  inputDecorationTheme: InputDecorationTheme(
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(
        color: Colors.red,
      ),
    ),

    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.black,
      ),
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.grey,
      ),
    ),
    labelStyle: const TextStyle(
        // color: Color.fromRGBO(155, 145, 150, 2),
        color: Colors.black54),
    disabledBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(Radius.circular(20)),
      borderSide: BorderSide(
        color: Colors.grey.shade400,
      ),
    ),
    // labelText: labelText,
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(
          20,
        ),
      ),
      borderSide: BorderSide(
          // color: Colors.black,
          ),
    ),
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
    iconTheme: IconThemeData(
      color: Colors.grey.shade400,
    ),
    textTheme: GoogleFonts.loraTextTheme(
      ThemeData.dark().textTheme,
    ),
// //set textFormField data

    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        color: Color.fromRGBO(155, 145, 150, 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.grey.shade400,
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.grey.shade700,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.grey.shade50,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.red.shade400,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Colors.red.shade700,
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.grey.shade700),
      ),
    ),
    colorScheme: const ColorScheme(
      background: Color.fromRGBO(36, 36, 36, 2),
      brightness: Brightness.dark,
      primary: Colors.white,
      onPrimary: Colors.black,
      secondary: Colors.white,
      onSecondary: Colors.black,
      error: Colors.red,
      onError: Colors.red,
      onBackground: Colors.white,
      surface: Colors.transparent,
      onSurface: Colors.black,
    ));

// class ColorSchema {
//   static const Color primaryColor = Color.fromRGBO(36, 36, 36, 2);
//   static const Color secondaryColor = Color.fromRGBO(155, 145, 150, 2);
//   static const Color errorColor = Colors.red;
//   static const Color successColor = Colors.green;
//   static const Color warningColor = Colors.yellow;
//   static const Color infoColor = Colors.blue;
//   static const Color surfaceColor = Colors.white;
//   static const Color backgroundColor = Colors.white;
//   static const Color onPrimaryColor = Colors.black;
//   static const Color onSecondaryColor = Colors.black;
//   static const Color onErrorColor = Colors.red;
//   static const Color onSurfaceColor = Colors.black;
//   static const Color onBackgroundColor = Colors.black;
//   static const ColorScheme darkColorSchema = ColorScheme(
//     primary: primaryColor,
//     secondary: secondaryColor,
//     surface: surfaceColor,
//     background: backgroundColor,
//     error: errorColor,
//     onPrimary: onPrimaryColor,
//     onSecondary: onSecondaryColor,
//     onSurface: onSurfaceColor,
//     onBackground: onBackgroundColor,
//     onError: onErrorColor,
//     brightness: Brightness.light,
//   );
// }
