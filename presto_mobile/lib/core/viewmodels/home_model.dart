import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
// import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/viewmodels/base_model.dart';
import 'package:presto_mobile/locator.dart';

class HomeModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  // final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future signOut() async {
    bool sure = await _authenticationService.signOut();
    if (sure) await _navigateToLogin();
  }

  void onReady() {
    _authenticationService.userController.stream.listen((event) {
      if (event is UserModel) {
        print("-------------------------------------------------");
        print(event.name);
      }
    });
  }

  Future _navigateToLogin() async {
    await _navigationService.navigateTo(LoginViewRoute, true);
  }
}
