import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:presto_mobile/core/services/analytics_service.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/core/services/push_notification_service.dart';
import 'package:presto_mobile/locator.dart';
import 'package:presto_mobile/managers/dialog_manager.dart';
import 'package:presto_mobile/ui/router.dart';
import 'package:presto_mobile/ui/views/startup_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseMessaging _fcm = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("hELOOOOOOOOOOOOOOOO");
        print('onMessage: $message');
        // NotificationModel notification = NotificationModel.fromJson(message);
        // _navigationService.navigateTo(NotificationViewRoute, false,
        //     arguments: notification);
      },
      // Called when the app has been closed completely and it's opened
      // from the push notification directly
      onLaunch: (Map<String, dynamic> message) async {
        print("hELOOOOOOOOOOOOOOOO");
        // NotificationModel notification = NotificationModel.fromJson(message);
        // _navigationService.navigateTo(NotificationViewRoute, false,
        //     arguments: notification);
      },
      // Called when the app is in background and it's opened
      // from the push notification
      onResume: (Map<String, dynamic> message) async {
        print('onMessage: $message');
        print("hELOOOOOOOOOOOOOOOO");
        // NotificationModel notification = NotificationModel.fromJson(message);
        // _navigationService.navigateTo(NotificationViewRoute, false,
        //     arguments: notification);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Presto 2.0",
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      navigatorObservers: [locator<AnalyticsService>().getAnalyticsObserver()],
      theme: ThemeData(
        primaryColor: Color(0xff19c7c1),
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Oswald',
            ),
      ),
      home: StartUpView(),
      onGenerateRoute: customRoute,
    );
  }
}
