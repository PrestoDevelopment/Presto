import 'package:get_it/get_it.dart';
import 'package:presto_mobile/core/services/analytics_service.dart';
import 'package:presto_mobile/core/services/api_service.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/core/viewmodels/login_model.dart';
import 'package:presto_mobile/core/viewmodels/signup_model.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //View Models
  // locator.registerLazySingleton(() => BaseModel());
  locator.registerLazySingleton(() => LoginModel());
  locator.registerLazySingleton(() => SignUpModel());
  // locator.registerLazySingleton(() => HomeModel());
  //Services
  locator.registerLazySingleton(() => Api());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => AnalyticsService());
  locator.registerLazySingleton(() => FireStoreService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
}
