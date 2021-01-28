import 'package:flutter/material.dart';
import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/models/notificationModel.dart';
import 'package:presto_mobile/ui/views/email_verification_view.dart';
import 'package:presto_mobile/ui/views/home_view.dart';
import 'package:presto_mobile/ui/views/list_notification_view.dart';
import 'package:presto_mobile/ui/views/login_view.dart';
import 'package:presto_mobile/ui/views/main_view.dart';
import 'package:presto_mobile/ui/views/notification_view.dart';
import 'package:presto_mobile/ui/views/otp_view.dart';
import 'package:presto_mobile/ui/views/payment_view.dart';
import 'package:presto_mobile/ui/views/signup_view.dart';

import '../constants/route_names.dart';
import 'views/startup_view.dart';

Route<dynamic> customRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    case StartUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: StartUpView(),
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
    case ListNotificationViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: ListNotificationView(),
      );
    case OtpViewRoute:
      var user = settings.arguments;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: OtpVerificationView(
          user: user,
        ),
      );
    case EmailVerificationRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: EmailVerificationView(),
      );
    //For passing arguements
    case SignupViewRoute:
      // var abc = settings.arguements
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
      );
    case NotificationViewRoute:
      NotificationModel notification = settings.arguments;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: NotificationView(
          notification: notification,
        ),
      );
    case PaymentViewRoute:
      var data = settings.arguments;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: PaymentView(
          amount: data,
        ),
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
