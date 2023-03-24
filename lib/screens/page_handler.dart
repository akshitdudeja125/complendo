import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:complaint_portal/providers/database_provider.dart';
import 'package:complaint_portal/providers/page_provider.dart';
import 'package:complaint_portal/screens/student_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../widgets/bottom_navbar.dart';
import '../widgets/clipper.dart';
import 'compose_complaint_screen.dart';
import 'home_screen.dart';

class PageNavigator extends ConsumerWidget {
  const PageNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PageController pageController = PageController();
    final int currentIndex = ref.watch(indexProvider) as int;
    final data = ref.watch(userDataProvider);
    return data.when(
      data: (data) {
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
                  ref.read(indexProvider.notifier).value = index;
                },
                children: data!['isAdmin'] ? adminPages : userPages,
              ),
            ],
          ),
          bottomNavigationBar: BottomBar(
            currentIndex: currentIndex,
            items: data['isAdmin'] ? adminBottomBarItems : userBottomBarItems,
            onTap: (i) {
              ref.read(indexProvider.notifier).value = i;
              pageController.animateToPage(i,
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut);
            },
          ),
        );
      },
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) => const Center(
        child: Text('Something went wrong'),
      ),
    );
  }
}
// final indexProvider = StateNotifierProvider((ref) => Index());

// class PageNavigator extends ConsumerStatefulWidget {
//   const PageNavigator({Key? key}) : super(key: key);

//   @override
//   ConsumerState<PageNavigator> createState() => _PageNavigatorState();
// }

// class _PageNavigatorState extends ConsumerState<PageNavigator> {
//   // int currentIndex = 0;
//   int _currentIndex = 0;
//   late PageController _pageController;
//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final data = ref.watch(dataProvider);
//     return data.when(
//       data: (data) {
//         return Scaffold(
//           body: Stack(
//             children: [
//               Container(
//                 color: Colors.transparent,
//                 width: MediaQuery.of(context).size.width,
//                 height: MediaQuery.of(context).size.height / 5,
//                 child: ClipPath(
//                   clipper: CurveClipper(),
//                   child: Container(
//                     color: const Color(0xFF181D3D),
//                     child: Column(
//                       children: [
//                         SizedBox(
//                             height: MediaQuery.of(context).size.height / 16),
//                         Text(
//                           userPagesHeading[_currentIndex],
//                           style: Theme.of(context)
//                               .textTheme
//                               .headlineSmall
//                               ?.apply(color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               PageView(
//                 controller: _pageController,
//                 onPageChanged: (index) {
//                   setState(
//                     () {
//                       _currentIndex = index;
//                       _pageController.animateToPage(index,
//                           duration: const Duration(milliseconds: 300),
//                           curve: Curves.slowMiddle);
//                     },
//                   );
//                 },
//                 children: data!['isAdmin'] ? adminPages : userPages,
//               ),
//             ],
//           ),
//           bottomNavigationBar: BottomBar(
//             currentIndex: _currentIndex,
//             items: data['isAdmin'] ? adminBottomBarItems : userBottomBarItems,
//             onTap: (index) {
//               setState(() {
//                 _currentIndex = index;
//                 _pageController.animateToPage(index,
//                     duration: const Duration(milliseconds: 300),
//                     curve: Curves.ease);
//               });
//             },
//           ),
//         );
//       },
//       loading: () => const Center(
//         child: CircularProgressIndicator(),
//       ),
//       error: (error, stack) => const Center(
//         child: Text('Something went wrong'),
//       ),
//     );
//   }
// }

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

List<Widget> userPages = [
  const HomePage(),
  const ComposeComplaint(),
  const StudentProfile(),
];

List<String> userPagesHeading = [
  "Complaints",
  "Register Complaint",
  "Profile ",
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
