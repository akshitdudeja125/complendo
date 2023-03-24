import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  final List<BottomNavyBarItem> items;
  final Function(int) onTap;
  const BottomBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavyBar(
      containerHeight: 60,
      animationDuration: const Duration(
        milliseconds: 300,
      ),
      backgroundColor: const Color(0xFF181D3D),
      selectedIndex: currentIndex,
      showElevation: true,
      onItemSelected: onTap,
      items: items,
    );
  }
}
