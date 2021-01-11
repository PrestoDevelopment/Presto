import 'package:flutter/material.dart';
import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/viewmodels/base_model.dart';
import 'package:presto_mobile/locator.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';

class HomeModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signOut() async {
    await _authenticationService.signOut();
  }

  Future _navigateToLogin() async {
    await _navigationService.navigateTo(LoginViewRoute, true);
  }
}
