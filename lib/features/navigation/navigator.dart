// ignore_for_file: unused_local_variable, unused_field, avoid_print

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:complaint_portal/common/widgets/bottom_navbar.dart';
import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/complaint/screens/compose/compose_complaint_screen.dart';

import 'package:complaint_portal/features/home/home_screen.dart';
import 'package:complaint_portal/features/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/services/ads/ad_service.dart';
import 'provider/page_controller_provider.dart';

class PageNavigator extends ConsumerStatefulWidget {
  const PageNavigator({super.key});

  @override
  ConsumerState<PageNavigator> createState() => _PageNavigatorState();
}

class _PageNavigatorState extends ConsumerState<PageNavigator> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final pageController = ref.watch(pageControllerProvider);
    final int currentIndex = ref.watch(indexProvider) as int;
    final List<Widget> userPages = [
      const HomePage(
          // user: user,
          ),
      const ComposeComplaint(),
      const SettingsPage(),
    ];
    final List<Widget> adminPages = [
      const HomePage(
          // user: user,
          ),
      // const ComposeComplaint(),
      const ComposeComplaint(),
      const SettingsPage(),
    ];
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            ref.watch(indexProvider.notifier).value = index;
          },
          children: (user.isAdmin ?? false)
              ? [
                  const HomePage(),
                  // const RandomPage(),
                  const ComposeComplaint(),
                  const SettingsPage(),
                ]
              : [
                  const HomePage(),
                  const ComposeComplaint(),
                  const SettingsPage(),
                ],
        ),
      ),
      bottomNavigationBar: BottomBar(
        currentIndex: ref.watch(indexProvider) as int,
        items:
            (user.isAdmin ?? false) ? adminBottomBarItems : userBottomBarItems,
        onTap: (index) {
          ref.read(onPageChangeProvider).call(index);
          pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
          );
          ref.read(indexProvider.notifier).value = index;
        },
      ),
    );
  }
}

List<String> userPagesHeading = [
  "Complaints",
  "Register Complaint",
  "Profile ",
];

List<String> adminPagesHeading = [
  "Complaints",
  // "Review Complaints",
  "Register Complaint",
  "Profile ",
];

List<BottomNavyBarItem> adminBottomBarItems = [
  BottomNavyBarItem(
    icon: const Icon(Icons.home),
    title: const Text('Home'),
    inactiveColor: Colors.white,
    activeColor: Colors.white,
    textAlign: TextAlign.center,
  ),
  // BottomNavyBarItem(
  //   icon: const Icon(Icons.reviews),
  //   title: const Text('Review'),
  //   textAlign: TextAlign.center,
  //   inactiveColor: Colors.white,
  //   activeColor: Colors.white,
  // ),
  BottomNavyBarItem(
    icon: const Icon(Icons.add),
    title: const Text('Compose'),
    textAlign: TextAlign.center,
    inactiveColor: Colors.white,
    activeColor: Colors.white,
  ),
  BottomNavyBarItem(
    icon: const Icon(Icons.person),
    title: const Text('Profile'),
    inactiveColor: Colors.white,
    activeColor: Colors.white,
    textAlign: TextAlign.center,
  ),
];

List<BottomNavyBarItem> userBottomBarItems = [
  BottomNavyBarItem(
    icon: const Icon(Icons.home),
    title: const Text('Home'),
    inactiveColor: Colors.white,
    activeColor: Colors.white,
    textAlign: TextAlign.center,
  ),
  BottomNavyBarItem(
    icon: const Icon(Icons.add),
    title: const Text('Compose'),
    textAlign: TextAlign.center,
    inactiveColor: Colors.white,
    activeColor: Colors.white,
  ),
  BottomNavyBarItem(
    icon: const Icon(Icons.person),
    title: const Text('Profile'),
    inactiveColor: Colors.white,
    activeColor: Colors.white,
    textAlign: TextAlign.center,
  ),
];

class RandomPage extends StatefulWidget {
  const RandomPage({super.key});

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  @override
  void initState() {
    super.initState();
    AdService().loadInterstitialAd();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Random Page"),
      ),
    );
  }
}
