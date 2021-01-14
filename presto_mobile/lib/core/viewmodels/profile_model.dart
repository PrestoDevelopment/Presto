import 'package:flutter/cupertino.dart';
import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/core/viewmodels/base_model.dart';
import 'package:presto_mobile/locator.dart';

class ProfileModel extends BaseModel {
  final AuthenticationService _authenticationService = AuthenticationService();
  final NavigationService _navigationService = locator<NavigationService>();
  final FireStoreService _fireStoreService = locator<FireStoreService>();

  // final SharedPreferencesService _preferencesService =
  //     SharedPreferencesService();
  UserModel _user;

  get user => _user;
  String _creditWorthyScore;

  get creditWorthyScore => _creditWorthyScore;

  void onReady(BuildContext context) async {
    setBusy(true);
    var temp =
        await _fireStoreService.getUser(_authenticationService.retrieveCode());
    if (temp is UserModel) {
      _user = temp;
      _creditWorthyScore = ((double.parse(_user.communityScore) +
                  double.parse(_user.personalScore)) /
              2)
          .toString();
    }
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
