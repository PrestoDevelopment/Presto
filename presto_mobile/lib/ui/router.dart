import 'package:flutter/material.dart';
import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/ui/views/home_view.dart';
import 'package:presto_mobile/ui/views/login_view.dart';
import 'package:presto_mobile/ui/views/main_view.dart';
import 'package:presto_mobile/ui/views/signup_view.dart';

Route<dynamic> customRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    case MainPageViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: MainPageView(),
      );
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
      );

    //For passing arguements

    case SignupViewRoute:
      // var abc = settings.arguements
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    default:
      var message = settings.arguments;
      print(message.runtimeType);
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Text(
              "OOps! ${settings.name} \n $message",
            ),
          ),
        ),
      );
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
