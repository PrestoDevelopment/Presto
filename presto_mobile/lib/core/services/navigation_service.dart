import 'package:flutter/material.dart';

class NavigationService {
  GlobalKey<NavigatorState> _navigationKey = GlobalKey<NavigatorState>();

  GlobalKey<NavigatorState> get navigationKey => _navigationKey;

  void pop() {
    return _navigationKey.currentState.pop();
  }

  Future<dynamic> navigateTo(
    String routeName,
    bool isReplacement, {
    dynamic arguments,
  }) {
    return isReplacement
        ? _navigationKey.currentState
            .pushReplacementNamed(routeName, arguments: arguments)
        : _navigationKey.currentState
            .pushNamed(routeName, arguments: arguments);
  }
}
