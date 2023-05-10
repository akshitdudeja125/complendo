import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isNetworkAvailableProvider = StreamProvider<bool>((ref) {
  return Connectivity().onConnectivityChanged.map((event) {
    if (event == ConnectivityResult.none) {
      return false;
    } else {
      return true;
    }
  });
});
