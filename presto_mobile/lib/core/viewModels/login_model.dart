import 'package:firebase_auth/firebase_auth.dart';
import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/locator.dart';
import 'package:stacked/stacked.dart';

import '../../constants/route_names.dart';

class LoginModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future login(String email, String pass) async {
    // var success = await;
    setBusy(true);
    // Validate the fields
    var result = await _authenticationService.login(email, pass);
    setBusy(false);
    //Complete LogIn by showing error or doing to different page;

    if (result is bool) {
      if (result)
        _navigationService.navigateTo(MainPageViewRoute, true);
      else {
        await _dialogService.showDialog(
          title: "Error",
          description: "General SignUp Failure",
        );
      }
    } else {
      print("error");
      print(result);
      if (result is FirebaseAuthException) {
        print("exceeptiom");
        await _dialogService.showDialog(
          title: "Error",
          description: result.message.toString(),
        );
      } else {
        await _dialogService.showDialog(
          title: "Error",
          description: result.toString(),
        );
      }
    }
    // Invoke authenticcation service
  }

  Future navigateToSignUp() async {
    await _navigationService.navigateTo(SignupViewRoute, true);
  }
}
