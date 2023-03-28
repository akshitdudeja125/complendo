import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class FirebaseAnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsObserver appAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);
  // Future setUserId({@required String? id}) async {
  //   await _analytics.setUserId(id: id);
  // }
}



// await Future.delayed(Duration(milliseconds: 3000));

// await _analyticsService.setUserId(id: ‘101’);