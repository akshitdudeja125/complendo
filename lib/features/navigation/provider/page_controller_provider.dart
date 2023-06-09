import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Index extends StateNotifier<int> {
  Index() : super(0);
  set value(int index) => state = index;
}

final indexProvider = StateNotifierProvider.autoDispose((ref) => Index());

final pageControllerProvider = Provider.autoDispose((ref) => PageController(
      keepPage: true,
      initialPage: 0,
    ));

final onPageChangeProvider = Provider.autoDispose((ref) => (int index) {
      ref.read(indexProvider.notifier).value = index;
      ref.read(pageControllerProvider).animateToPage(
            index,
            duration: const Duration(
              milliseconds: 200,
            ),
            curve: Curves.ease,
          );
    });
