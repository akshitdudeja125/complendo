import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final roomNoProvider = StateProvider<String?>((ref) => "");
final titleProvider = StateProvider<String?>((ref) => null);
final descriptionProvider = StateProvider<String?>((ref) => null);
final complaintTypeProvider = StateProvider<String?>((ref) => null);
final hostelProvider = StateProvider<String?>((ref) => null);
final complaintCategoryProvider = StateProvider<String?>((ref) => null);
final pickedImageProvider = StateProvider<File?>((ref) => null);
final isLoadingProvider = StateProvider((ref) => false);
final formKeyProvider = StateProvider((ref) => GlobalKey<FormState>());

void clearForm(ref) {
  ref.watch(titleProvider.notifier).state = null;
  ref.watch(descriptionProvider.notifier).state = null;
  ref.watch(roomNoProvider.notifier).state = null;
  ref.watch(complaintTypeProvider.notifier).state = null;
  ref.watch(hostelProvider.notifier).state = null;
  ref.watch(complaintCategoryProvider.notifier).state = null;
  ref.watch(pickedImageProvider.notifier).state = null;
  ref.watch(formKeyProvider.notifier).state.currentState!.reset();
  ref.watch(isLoadingProvider.notifier).state = false;
}
