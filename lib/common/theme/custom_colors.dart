import 'package:flutter/material.dart';

class ThemeColors {
  static final homePageFontColor = {
    Brightness.light: const Color.fromARGB(255, 6, 56, 97).withOpacity(0.8),
    Brightness.dark: const Color.fromARGB(255, 101, 185, 253).withOpacity(0.8),
  };

  //bottom bar color
  static final bottomBarColor = {
    //  Color(0xFF181D3D),
    Brightness.light: const Color(0xFF181D3D),
    Brightness.dark: const Color(0xFF181D3D),
    // Brightness.light: Colors.white,
    // Brightness.dark: Colors.black,
  };

  //bottom bar item active color
//  Color(0xFF181D3D),
  // bottomNavBarIconColor
  static Map<Brightness, Color> bottomNavBarIconColor = {
    // Brightness.light: const Color(0xff065f9e),
    // Brightness.dark: const Color(0xff065f9e),
    Brightness.light: Colors.orange,
    Brightness.dark: Colors.cyan,
  };

  static const bottomBarActiveColor = {
    Brightness.light: Colors.white,
    Brightness.dark: Colors.white,
  };

  //bottom bar item inactive color
  static final bottomBarInactiveColor = {
    Brightness.light: Colors.white.withOpacity(0.6),
    Brightness.dark: Colors.white.withOpacity(0.6),
  };

  //filter
  static final selectedFilterChipColor = {
    // Brightness.light: Color.fromARGB(255, 6, 56, 97),
    Brightness.dark: Colors.grey.shade400,
    Brightness.light: const Color.fromARGB(255, 6, 56, 97),
  };
//chip background color
  static final filterDialogBackgroundColor = {
    Brightness.light: Colors.white,
    Brightness.dark: Colors.black,
  };
  static const chipBackgroundColor = {
    Brightness.light: Color.fromARGB(255, 6, 56, 97),
    Brightness.dark: Color.fromARGB(255, 101, 185, 253),
  };

//selected filter chip text color
  static final selectedFilterChipTextColor = {
    Brightness.light: Colors.white,
    Brightness.dark: Colors.black,
  };

// unselected filter chip text color
  // unselectedFilterChipTextColor
  static final unselectedFilterChipTextColor = {
    Brightness.light: const Color.fromARGB(255, 6, 56, 97),
    Brightness.dark: Colors.white,
  };

  // filter done button color
  static final filterDoneButtonColor = {
    Brightness.light: Colors.white,
    Brightness.dark: Colors.black,
  };

//

  static const elevatedButtonTextColor = {
    Brightness.light: Colors.white,
    Brightness.dark: Colors.black,
  };

  // elevatedButtonColor
  static const elevatedButtonColor = {
    Brightness.light: Colors.black,
    Brightness.dark: Colors.white,
  };

  static const submitButtonLoadingBgColor = {
    Brightness.light: Colors.grey,
    Brightness.dark: Colors.grey,
  };
  // submitButtonNotLoadingBgColor
  static const submitButtonNotLoadingBgColor = {
    Brightness.light: Colors.black,
    Brightness.dark: Colors.white,
  };

  static const submitButtonLoadingIconColor = {
    Brightness.light: Colors.white,
    Brightness.dark: Colors.black,
  };

  static const submitButtonNotLoadingIconColor = {
    Brightness.light: Colors.white,
    Brightness.dark: Colors.black,
  };

  static const submitButtonTextColor = {
    Brightness.light: Colors.white,
    Brightness.dark: Colors.black,
  };

  static const dropDownIconColor = {
    Brightness.light: Colors.black,
    Brightness.dark: Colors.white,
  };
  static const iconColor = {
    Brightness.light: Colors.black,
    Brightness.dark: Colors.white,
  };
  static final iconColorLight = {
    Brightness.light: Colors.black.withOpacity(0.2),
    Brightness.dark: Colors.white.withOpacity(0.8),
  };

  static const detailsTextColor = {
    Brightness.light: Colors.black,
    Brightness.dark: Colors.white,
  };

  //borderColor
  static const borderColorL1 = {
    Brightness.light: Colors.grey, //changes required
    Brightness.dark: Colors.grey, //changes required
  };
  static const borderColorL2 = {
    Brightness.light: Colors.grey, //changes required
    Brightness.dark: Colors.grey, //changes required
  };
  static const borderColorL3 = {
    Brightness.light: Colors.grey, //changes required
    Brightness.dark: Colors.grey, //changes required
  };

  // appBarColor
  static const appBarColor = {
    // Brightness.light: Colors.white,
    // Brightness.dark: Colors.black,
  };

  //settings

  // settingsIconColor
  static Map<Brightness, Color> settingsIconColor = {
    Brightness.light: Colors.black.withOpacity(0.8),
    Brightness.dark: Colors.white.withOpacity(0.8),
  };

//problem in editImageBlock.dart
  static final containerBorderColor = {
    Brightness.light: Colors.grey.shade400,
    Brightness.dark: const Color.fromARGB(255, 6, 56, 97),
    // Brightness.dark: Colors.red,
  };

  // Color get containerBorderColor => Colors.grey.shade400;
}

class TextStyles {
  final Brightness brightness;

  TextStyles(this.brightness);

  TextStyle get detailsTextStyle => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: ThemeColors.detailsTextColor[brightness],
      );

  //appbarTextStyle
  TextStyle get appbarTextStyle => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: ThemeColors.detailsTextColor[brightness],
      );

  //settings
  // settingsTitleTextStyle
  TextStyle get settingsTitleTextStyle => TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: ThemeColors.detailsTextColor[brightness],
      );

  // settingsSubtitleTextStyle
  TextStyle get settingsSubtitleTextStyle => TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.bold,
        color: ThemeColors.detailsTextColor[brightness]!.withOpacity(0.7),
      );

  TextStyle get settingsTitleTextStyle2 => TextStyle(
      fontSize: 23,
      fontWeight: FontWeight.bold,
      color: ThemeColors.detailsTextColor[brightness]);
  TextStyle get settingsSubtitleTextStyle2 => TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      color: ThemeColors.detailsTextColor[brightness]);
  TextStyle get complaintTextMedium => TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: ThemeColors.detailsTextColor[brightness]);

  //filter header text
  TextStyle get filterHeaderTextStyle => const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        // color: ThemeColors.detailsTextColor[brightness]
      );
  TextStyle get filtersubHeaderTextStyle => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        // color: ThemeColors.detailsTextColor[brightness]
      );

  //elevated button text style
  TextStyle get elevatedButtonTextStyle => TextStyle(
        fontSize: 0,
        fontWeight: FontWeight.bold,
        color: ThemeColors.elevatedButtonTextColor[brightness],
      );

  // bottomNavBarTextStyle
  TextStyle get bottomNavBarTextStyle => TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: ThemeColors.detailsTextColor[brightness],
      );

//
}

const kFormSpacing = 20.0;
