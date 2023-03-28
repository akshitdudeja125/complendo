// write code here

import 'package:complaint_portal/services/analytics_service.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerLazySingleton(() => FirebaseAnalyticsService());
}
