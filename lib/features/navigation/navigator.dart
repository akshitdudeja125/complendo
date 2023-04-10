import 'dart:convert';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:complaint_portal/common/widgets/bottom_navbar.dart';
import 'package:complaint_portal/common/widgets/clipper.dart';
import 'package:complaint_portal/features/complaint/screen/compose_complaint_screen.dart';
import 'package:complaint_portal/features/home/home_screen.dart';
import 'package:complaint_portal/features/profile/student_profile.dart';
import 'package:complaint_portal/features/settings/settings_page.dart';
import 'package:complaint_portal/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'provider/page_controller_provider.dart';

class PageNavigator extends ConsumerWidget {
  final UserModel user;
  const PageNavigator({super.key, required this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(pageControllerProvider);
    final int currentIndex = ref.watch(indexProvider) as int;
    final List<Widget> userPages = [
      HomePage(user: user),
      ComposeComplaint(
        user: user,
      ),
      SettingsPage(),
    ];
    final List<Widget> adminPages = [
      HomePage(user: user),
      ComposeComplaint(
        user: user,
      ),
      ComposeComplaint(
        user: user,
      ),
      SettingsPage(),
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
                  HomePage(
                    user: user,
                  ),
                  SettingsPage(),
                  ComposeComplaint(
                    user: user,
                  ),
                  SettingsPage(),
                ]
              : [
                  HomePage(
                    user: user,
                  ),
                  ComposeComplaint(
                    user: user,
                  ),
                  SettingsPage(),
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
  "Review Complaints",
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
  BottomNavyBarItem(
    icon: const Icon(Icons.reviews),
    title: const Text('Review'),
    textAlign: TextAlign.center,
    inactiveColor: Colors.white,
    activeColor: Colors.white,
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
// import 'dart:convert';
// import 'package:bottom_navy_bar/bottom_navy_bar.dart';
// import 'package:complaint_portal/common/widgets/bottom_navbar.dart';
// import 'package:complaint_portal/common/widgets/clipper.dart';
// import 'package:complaint_portal/features/complaint/screen/compose_complaint_screen.dart';
// import 'package:complaint_portal/features/home/home_screen.dart';
// import 'package:complaint_portal/features/settings/settings_page.dart';
// import 'package:complaint_portal/models/user_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'provider/page_controller_provider.dart';

// class PageNavigator extends ConsumerWidget {
//   final UserModel user;
//   const PageNavigator({super.key, required this.user});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final pageController = ref.watch(pageControllerProvider);
//     final int currentIndex = ref.watch(indexProvider) as int;
//     final List<Widget> userPages = [
//       HomePage(user: user),
//       ComposeComplaint(
//         user: user,
//       ),
//       SettingsPage(user: user),
//     ];//     final List<Widget> adminPages = [
//       HomePage(user: user),
//       ComposeComplaint(
//         user: user,
//       ),
//       ComposeComplaint(
//         user: user,
//       ),
//       SettingsPage(user: user),
//     ];
//     return Scaffold(
//       body: Stack(
//         children: [
//           Container(
//             color: Colors.transparent,
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height / 5,
//             child: ClipPath(
//               clipper: CurveClipper(),
//               child: Container(
//                 color: const Color(0xFF181D3D),
//                 child: Column(
//                   children: [
//                     SizedBox(height: MediaQuery.of(context).size.height / 16),
//                     Text(
//                       user.isAdmin ?? false
//                           ? adminPagesHeading[currentIndex]
//                           : userPagesHeading[currentIndex],
//                       style: Theme.of(context)
//                           .textTheme
//                           .headlineSmall
//                           ?.apply(color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           // if (user.isAdmin ?? false)
//           //   adminPages[currentIndex]
//           // else
//           //   userPages[currentIndex],
//           PageView(
//             controller: pageController,
//             onPageChanged: (index) {
//               ref.watch(indexProvider.notifier).value = index;
//             },
//             children: (user.isAdmin ?? false)
//                 ? [
//                     HomePage(user: user),
//                     ComposeComplaint(
//                       user: user,
//                     ),
//                     ComposeComplaint(
//                       user: user,
//                     ),
//                     SettingsPage(user: user),
//                   ]//                 : [
//                     HomePage(user: user),
//                     ComposeComplaint(
//                       user: user,
//                     ),
//                     SettingsPage(user: user),
//                   ],//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomBar(
//         currentIndex: ref.watch(indexProvider) as int,
//         items:
//             (user.isAdmin ?? false) ? adminBottomBarItems : userBottomBarItems,
//         onTap: (index) {
//           ref.read(onPageChangeProvider).call(index);
//           pageController.animateToPage(
//             index,
//             duration: const Duration(milliseconds: 500),
//             curve: Curves.ease,
//           );
//           ref.read(indexProvider.notifier).value = index;
//         },
//       ),
//     );
//   }
// }

// List<String> userPagesHeading = [
//   "Complaints",
//   "Register Complaint",
//   "Profile ",
// ];

// List<String> adminPagesHeading = [
//   "Complaints",
//   "Review Complaints",
//   "Register Complaint",
//   "Profile ",
// ];

// List<BottomNavyBarItem> adminBottomBarItems = [
//   BottomNavyBarItem(
//     icon: const Icon(Icons.home),
//     title: const Text('Home'),
//     inactiveColor: Colors.white,
//     activeColor: Colors.white,
//     textAlign: TextAlign.center,
//   ),
//   BottomNavyBarItem(
//     icon: const Icon(Icons.reviews),
//     title: const Text('Review'),
//     textAlign: TextAlign.center,
//     inactiveColor: Colors.white,
//     activeColor: Colors.white,
//   ),
//   BottomNavyBarItem(
//     icon: const Icon(Icons.add),
//     title: const Text('Compose'),
//     textAlign: TextAlign.center,
//     inactiveColor: Colors.white,
//     activeColor: Colors.white,
//   ),
//   BottomNavyBarItem(
//     icon: const Icon(Icons.person),
//     title: const Text('Profile'),
//     inactiveColor: Colors.white,
//     activeColor: Colors.white,
//     textAlign: TextAlign.center,
//   ),
// ];

// List<BottomNavyBarItem> userBottomBarItems = [
//   BottomNavyBarItem(
//     icon: const Icon(Icons.home),
//     title: const Text('Home'),
//     inactiveColor: Colors.white,
//     activeColor: Colors.white,
//     textAlign: TextAlign.center,
//   ),
//   BottomNavyBarItem(
//     icon: const Icon(Icons.add),
//     title: const Text('Compose'),
//     textAlign: TextAlign.center,
//     inactiveColor: Colors.white,
//     activeColor: Colors.white,
//   ),
//   BottomNavyBarItem(
//     icon: const Icon(Icons.person),
//     title: const Text('Profile'),
//     inactiveColor: Colors.white,
//     activeColor: Colors.white,
//     textAlign: TextAlign.center,
//   ),
// ];
