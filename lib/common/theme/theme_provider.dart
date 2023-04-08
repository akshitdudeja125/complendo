// state provider for isDark

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:shared_preferences/shared_preferences.dart';

final isDarkProvider = StateProvider<bool>((ref) {
  return false;
});



// class ThemeController extends ChangeNotifier {
//   static const themePrefKey = 'theme';

//   // ThemeController(this._prefs) {
//   //   _currentTheme = _prefs.getString(themePrefKey) ?? 'light';

//   // }

//   final SharedPreferences _prefs;

//   late String _currentTheme;
//   ThemeController(this._prefs) {
//     _currentTheme = _prefs.getString(themePrefKey) ?? 'light';
//   }

//   bool get isDark => _currentTheme == 'dark';

//   /// get the current theme
//   String get currentTheme => _currentTheme;

//   void setTheme(String theme) {
//     _currentTheme = theme;

//     // notify the app that the theme was changed

//     // store updated theme on disk
//     print(_prefs.getString(ThemeController.themePrefKey));
//     _prefs.setString(themePrefKey, theme);
//     notifyListeners();
//     print(_prefs.getString(ThemeController.themePrefKey));
//   }

//   void toggleTheme() {
//     if (_currentTheme == 'dark') {
//       setTheme('light');
//     } else {
//       setTheme('dark');
//     }
//     notifyListeners();
//   }

//   /// get the controller from any page of your app
//   static ThemeController of(BuildContext context) {
//     final provider =
//         context.dependOnInheritedWidgetOfExactType<ThemeControllerProvider>()
//             as ThemeControllerProvider;
//     return provider.controller;
//   }
// }

// /// provides the theme controller to any page of your app
// class ThemeControllerProvider extends InheritedWidget {
//   const ThemeControllerProvider({
//     Key? key,
//     required this.controller,
//     required Widget child,
//   }) : super(key: key, child: child);

//   final ThemeController controller;

//   @override
//   bool updateShouldNotify(ThemeControllerProvider oldWidget) =>
//       controller != oldWidget.controller;
// }
