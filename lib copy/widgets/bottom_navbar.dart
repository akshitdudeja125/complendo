import 'package:complaint_portal/constants.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar(
      {super.key,
      required this.currentIndex,
      required this.data,
      required this.onTap});

  final int currentIndex;
  final Map<String, dynamic> data;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.grey.shade800,
      unselectedItemColor: const Color(0xFFF49F1C),
      selectedLabelStyle: const TextStyle(color: Colors.blue),
      currentIndex: currentIndex,
      onTap: onTap,
      items: data['isAdmin'] ? adminBottomBarItems : userBottomBarItems,
    );
  }
}
