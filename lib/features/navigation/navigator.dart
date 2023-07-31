import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:complaint_portal/common/theme/custom_colors.dart';
import 'package:complaint_portal/common/widgets/bottom_navbar.dart';
import 'package:complaint_portal/features/complaint/screens/compose/compose_complaint_screen.dart';

import 'package:complaint_portal/features/home/home_screen.dart';
import 'package:complaint_portal/features/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/page_controller_provider.dart';

class PageNavigator extends ConsumerStatefulWidget {
  final SharedPreferences prefs;
  const PageNavigator({super.key, required this.prefs});

  @override
  ConsumerState<PageNavigator> createState() => _PageNavigatorState();
}

// class _MyAppState extends ConsumerState<MyApp> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       ref.read(isDarkProvider.notifier).state =
//           widget.prefs.getBool('isDark') ?? false;

//     });
//   }
//   // final prefs =
//   //                                 await SharedPreferences.getInstance();
//   //                             prefs.setBool('isDark', value);
// //                             ref.watch(isDarkProvider.notifier).state = value;
class _PageNavigatorState extends ConsumerState<PageNavigator> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.watch(indexProvider.notifier).value =
          widget.prefs.getInt('page') ?? 0;

      // ref.read()
      // ref.read(isDarkProvider.notifier).state =
      //     widget.prefs.getBool('isDark') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageController = ref.watch(pageControllerProvider);
    return Scaffold(
      // body: SafeArea(
      //   child: PageView(
      //     controller: pageController,
      //     onPageChanged: (index) {
      //       ref.watch(indexProvider.notifier).value = index;
      //     },
      //     children: const [
      //       HomePage(),
      //       ComposeComplaint(),
      //       SettingsPage(),
      //     ],
      //   ),
      // ),
      body: SafeArea(
        child: [
          const HomePage(),
          const ComposeComplaint(),
          const SettingsPage(),
        ][ref.watch(indexProvider) as int],
      ),
      bottomNavigationBar: BottomBar(
        currentIndex: ref.watch(indexProvider) as int,
        items: bottomBarItems(context),
        onTap: (index) {
          ref.read(onPageChangeProvider).call(index, widget.prefs);
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        },
      ),
    );
  }
}

List<BottomNavyBarItem> bottomBarItems(context) {
  return [
    BottomNavyBarItem(
      icon: const Icon(Icons.home),
      title: const Text('Home'),
      inactiveColor:
          ThemeColors.bottomBarInactiveColor[Theme.of(context).brightness],
      activeColor:
          ThemeColors.bottomBarActiveColor[Theme.of(context).brightness]!,
      textAlign: TextAlign.center,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.add),
      title: const Text('Compose'),
      textAlign: TextAlign.center,
      inactiveColor:
          ThemeColors.bottomBarInactiveColor[Theme.of(context).brightness],
      activeColor:
          ThemeColors.bottomBarActiveColor[Theme.of(context).brightness]!,
    ),
    BottomNavyBarItem(
      icon: const Icon(Icons.person),
      title: const Text('Profile'),
      inactiveColor:
          ThemeColors.bottomBarInactiveColor[Theme.of(context).brightness],
      activeColor:
          ThemeColors.bottomBarActiveColor[Theme.of(context).brightness]!,
      textAlign: TextAlign.center,
    ),
  ];
}
