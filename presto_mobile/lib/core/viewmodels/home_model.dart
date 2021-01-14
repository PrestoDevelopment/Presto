import 'package:flutter/cupertino.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/core/viewmodels/base_model.dart';
import 'package:presto_mobile/locator.dart';

import '../models/user_model.dart';

class HomeModel extends BaseModel {
  final AuthenticationService _authenticationService = AuthenticationService();
  final DialogService _dialogService = locator<DialogService>();

  // final NavigationService _navigationService = locator<NavigationService>();
  final FireStoreService _fireStoreService = locator<FireStoreService>();

  // final SharedPreferencesService _preferencesService =
  //     SharedPreferencesService();
  double _amount;
  Map _borrowingLimits;

  get amount => _amount;

  get borrowingLimits => _borrowingLimits;
  UserModel _user;

  get user => _user;

  void onReady(BuildContext context) async {
    setBusy(true);
    var temp =
        await _fireStoreService.getUser(_authenticationService.retrieveCode());
    if (temp is UserModel) {
      _user = temp;
    }
    await _fireStoreService.getBorrowingLimit().then((value) {
      _borrowingLimits = value;
      _amount = _borrowingLimits["borrowLowerLimit"];
    });
    setBusy(false);
  }

  void increaseAmount(double value) {
    print(_borrowingLimits);
    setBusy(true);
    if (_amount + value <= _borrowingLimits["borrowUpperLimit"]) {
      _amount = _amount + value;
      setBusy(false);
    } else {
      setBusy(false);
      _dialogService.showDialog(
        title: 'To Much Greedy',
        description: 'You have exceeded maximum limit to borrow',
      );
    }
  }

  void decreaseAmount(double value) {
    setBusy(true);
    if (_amount - value >= _borrowingLimits["borrowLowerLimit"]) {
      _amount = _amount - value;
      setBusy(false);
    } else {
      setBusy(false);
      _dialogService.showDialog(
        title: 'Have Some Dignity',
        description: 'You have exceeded minimum limit to borrow',
      );
    }
  }

  void setAmount(double value) {
    setBusy(true);
    _amount = value;
    setBusy(false);
  }
}
