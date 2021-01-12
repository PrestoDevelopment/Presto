import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/core/viewmodels/base_model.dart';
import 'package:presto_mobile/locator.dart';

class ProfileModel extends BaseModel {
  final AuthenticationService _authenticationService = AuthenticationService();
  final NavigationService _navigationService = locator<NavigationService>();

  UserModel _user;
  get user => _user;

  void onReady() async {
    setBusy(true);
    _authenticationService.userController.stream.listen((value) async {
      _user = value;
    });
    setBusy(false);
    print("Done initialising profile model");
  }

  Future signOut() async {
    bool sure = await _authenticationService.signOut();
    if (sure) await _navigateToLogin();
  }

  Future _navigateToLogin() async {
    await _navigationService.navigateTo(LoginViewRoute, true);
  }
}
