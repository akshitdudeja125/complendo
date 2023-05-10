// ignore_for_file: unused_local_variable, unused_field, avoid_print

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:complaint_portal/common/widgets/bottom_navbar.dart';
import 'package:complaint_portal/features/complaint/screens/compose/compose_complaint_screen.dart';

import 'package:complaint_portal/features/home/home_screen.dart';
import 'package:complaint_portal/features/settings/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'provider/page_controller_provider.dart';

class PageNavigator extends ConsumerStatefulWidget {
  const PageNavigator({super.key});

  @override
  ConsumerState<PageNavigator> createState() => _PageNavigatorState();
}

class _PageNavigatorState extends ConsumerState<PageNavigator> {
  @override
  Widget build(BuildContext context) {
    final pageController = ref.watch(pageControllerProvider);
    final int currentIndex = ref.watch(indexProvider) as int;
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: pageController,
          onPageChanged: (index) {
            ref.watch(indexProvider.notifier).value = index;
          },
          children: const [
            HomePage(),
            ComposeComplaint(),
            SettingsPage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(
        currentIndex: ref.watch(indexProvider) as int,
        items: bottomBarItems,
        onTap: (index) {
          ref.read(onPageChangeProvider).call(index);
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

List<BottomNavyBarItem> bottomBarItems = [
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
