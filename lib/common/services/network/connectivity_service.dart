import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

// connectivityProvider is used to check the internet connection
final connectivityProvider = Provider<Connectivity>((ref) {
  return Connectivity();
});

// checkConnectivity is used to check the internet connection
Future<bool> checkConnectivity(ref) async {
  if (await ref.read(connectivityProvider).checkConnectivity() ==
      ConnectivityResult.none) {
    Get.snackbar(
      'Error',
      'No Internet Connection',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white,
    );
    return false;
  }
  return true;
}

