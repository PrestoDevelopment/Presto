import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/core/services/shared_preferences_service.dart';
import 'package:presto_mobile/locator.dart';

class PushNotificationService {
  FirebaseMessaging _fcm = FirebaseMessaging();
  final NavigationService _navigationService = locator<NavigationService>();
  final SharedPreferencesService _sharedPreferencesService =
      locator<SharedPreferencesService>();

  Future initialise() async {
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("hELOOOOOOOOOOOOOOOO");
        print('onMessage: $message');
        _navigationService.navigateTo(MainPageViewRoute, false);
      },
      // Called when the app has been closed completely and it's opened
      // from the push notification directly
      onLaunch: (Map<String, dynamic> message) async {
        print("hELOOOOOOOOOOOOOOOO");
        _navigationService.navigateTo(StartUpViewRoute, false);
      },
      // Called when the app is in background and it's opened
      // from the push notification
      onResume: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        print("hELOOOOOOOOOOOOOOOO");
        _navigationService.navigateTo(MainPageViewRoute, false);
      },
    );
  }
}
