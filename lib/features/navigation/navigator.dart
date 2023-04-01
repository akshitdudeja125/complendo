import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:complaint_portal/common/widgets/bottom_navbar.dart';
import 'package:complaint_portal/common/widgets/clipper.dart';
import 'package:complaint_portal/features/auth/providers/user_provider.dart';
import 'package:complaint_portal/features/complaint/screen/compose_complaint_screen.dart';
import 'package:complaint_portal/features/error/error_screen.dart';
import 'package:complaint_portal/features/home/home_screen.dart';
import 'package:complaint_portal/features/loading/loading_screen.dart';
import 'package:complaint_portal/features/profile/student_profile.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'provider/page_controller_provider.dart';

class PageNavigator extends ConsumerWidget {
  const PageNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(pageControllerProvider);
    final int currentIndex = ref.watch(indexProvider) as int;
    final data = ref.watch(userDataProvider);
    return data.when(
        error: (e, trace) => ErrorScreen(e, trace),
        loading: () => const LoadingScreen(),
        data: (data) {
          final Map<String, dynamic> value =
              data.data() as Map<String, dynamic>;

          final UserModel user = UserModel.fromMap(value);
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  color: Colors.transparent,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 5,
                  child: ClipPath(
                    clipper: CurveClipper(),
                    child: Container(
                      color: const Color(0xFF181D3D),
                      child: Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 16),
                          Text(
                            userPagesHeading[currentIndex],
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.apply(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                PageView(
                  controller: pageController,
                  onPageChanged: (index) {
                    ref.watch(indexProvider.notifier).value = index;
                  },
                  children: <Widget>[
                    HomePage(user: user),
                    ComposeComplaint(
                      user: user,
                    ),
                    StudentProfile(user: user),
                  ],
                ),
              ],
            ),
            bottomNavigationBar: BottomBar(
                currentIndex: ref.watch(indexProvider) as int,
                items:
                    value['isAdmin'] ? adminBottomBarItems : userBottomBarItems,
                onTap: (index) {
                  // ref.read(onPageChangeProvider).call(index);
                  pageController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                  ref.read(indexProvider.notifier).value = index;
                }),
          );
        });
  }
}

List<String> userPagesHeading = [
  "Complaints",
  "Register Complaint",
  "Profile ",
];

List<Widget> adminPages = [
  const Text('Home'),
  const Text('Notifications'),
  const Text('Profile'),
  const Text('Compose'),
];

List<BottomNavyBarItem> adminBottomBarItems = [
  BottomNavyBarItem(
    icon: const Icon(Icons.home),
    title: const Text('Home'),
    inactiveColor: Colors.white,
    activeColor: Colors.white,
    textAlign: TextAlign.center,
  ),
  BottomNavyBarItem(
    icon: const Icon(Icons.notifications),
    title: const Text('Notifications'),
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
  BottomNavyBarItem(
    icon: const Icon(Icons.add),
    title: const Text('Compose'),
    textAlign: TextAlign.center,
    inactiveColor: Colors.white,
    activeColor: Colors.white,
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
