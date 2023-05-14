import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedSegmentIndexProvider =
    StateNotifierProvider.autoDispose((ref) => SelectedSegmentIndexNotifier());

class SelectedSegmentIndexNotifier extends StateNotifier<int> {
  SelectedSegmentIndexNotifier() : super(0);

  void setSelectedSegmentIndex(int index) {
    state = index;
  }
}
