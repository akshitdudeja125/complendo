import 'package:complaint_portal/widgets/compose_complaint.dart';
import 'package:flutter/material.dart';

List<String> hostels = [
  "RHR",
  "BHR",
  "MHR",
  "GHR",
  "SHR",
];

List<String> complaintCategories = [
  'Electricity',
  'Water',
  'Internet',
  'Water Cooler',
];

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
double kFormSpacing = 20;
List<Widget> userPages = [
  const Text('Profile'),
  const ComposeComplaint(),
  const Text('Profile'),
];

List<BottomNavigationBarItem> userBottomBarItems = [
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
];
