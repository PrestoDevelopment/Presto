import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/locator.dart';

class PushNotificationService {
  FirebaseMessaging _fcm = FirebaseMessaging();
  final NavigationService _navigationService = locator<NavigationService>();

  Future initialise() async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("hELOOOOOOOOOOOOOOOO");
        print('onMessage: $message');
      },
      // Called when the app has been closed completely and it's opened
      // from the push notification directly
      onLaunch: (Map<String, dynamic> message) async {
        print("hELOOOOOOOOOOOOOOOO");
        _navigationService.navigateTo(NotificationViewRoute, false,
            arguments: message);
      },
      // Called when the app is in background and it's opened
      // from the push notification
      onResume: (Map<String, dynamic> message) async {
        _navigationService.navigateTo(NotificationViewRoute, false,
            arguments: message);
        print('onMessage: $message');
        print("hELOOOOOOOOOOOOOOOO");
      },
    );
  }
}
