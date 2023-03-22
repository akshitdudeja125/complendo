import 'package:complaint_portal/utils/constants.dart';
import 'package:flutter/material.dart';

import '../screens/student_profile.dart';
import 'compose_complaint.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    super.key,
    required this.currentIndex,
    required this.data,
    required this.onTap,
  });

  final int currentIndex;
  final Map<dynamic, dynamic> data;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.grey.shade800,
      unselectedItemColor: const Color(0xFF181D3D),
      selectedLabelStyle: const TextStyle(color: Colors.blue),
      currentIndex: currentIndex,
      onTap: onTap,
      items: data['isAdmin'] ? adminBottomBarItems : userBottomBarItems,
    );
  }
}

List<Widget> adminPages = [
  const Text('Home'),
  const Text('Notifications'),
  const Text('Profile'),
  const Text('Compose'),
];

List<BottomNavigationBarItem> adminBottomBarItems = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.notifications),
    label: 'Notifications',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'Profile',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.add),
    label: 'Compose',
  ),
];
List<Widget> userPages = [
  const Text('Profile'),
  const ComposeComplaint(),
  const StudentProfile(),
];

List<BottomNavigationBarItem> userBottomBarItems = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.home),
    label: 'Home',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.app_registration_rounded),
    label: 'Register Complaint',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'Profile',
  ),
];
