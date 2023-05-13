import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:complaint_portal/common/theme/custom_colors.dart';
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
      backgroundColor: ThemeColors.bottomBarColor[Theme.of(context).brightness],
      selectedIndex: currentIndex,
      showElevation: true,
      onItemSelected: onTap,
      items: items,
    );
  }
}
