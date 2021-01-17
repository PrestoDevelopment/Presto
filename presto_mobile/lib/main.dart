import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:presto_mobile/core/services/analytics_service.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
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

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
