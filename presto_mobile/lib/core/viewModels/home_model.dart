import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/locator.dart';
import 'package:stacked/stacked.dart';

class HomeModel extends BaseViewModel {
  // final AuthenticationService _authenticationService = AuthenticationService();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FireStoreService _fireStoreService = FireStoreService();

  double _amount = 100.0;

  double get amount => _amount;
  Map<String, dynamic> _borrowingLimits;

  Map<String, dynamic> get borrowingLimits => _borrowingLimits;

  // bool get hasUserData => dataReady(_UserDataStreamKey);
  // UserModel get user => dataMap[_UserDataStreamKey];

  void goToPaymentPage() async {
    setBusy(true);
    await _navigationService.navigateTo(
      PaymentViewRoute,
      false,
      arguments: _amount,
    );
    setBusy(false);
  }

  void onReady() async {
    print("Getting limits in Home view !!!!!!!!!!!!!");

    setBusy(true);
    await _fireStoreService.getBorrowingLimit().then((value) {
      _borrowingLimits = value;
      _amount = _borrowingLimits["borrowLowerLimit"];
      setBusy(false);
    });
  }

  void increaseAmount(double value) {
    if (_borrowingLimits.isNotEmpty) {
      setBusy(true);
      if (_amount + value <= _borrowingLimits["borrowUpperLimit"]) {
        _amount = _amount + value;
        notifyListeners();
        setBusy(false);
      } else {
        setBusy(false);
        _dialogService.showDialog(
          title: 'To Much Greedy',
          description: 'You have exceeded maximum limit to borrow',
        );
      }
    }
  }

  void decreaseAmount(double value) {
    setBusy(true);
    if (_borrowingLimits.isNotEmpty) {
      if (_amount - value >= _borrowingLimits["borrowLowerLimit"]) {
        _amount = _amount - value;
        notifyListeners();
        setBusy(false);
      } else {
        setBusy(false);
        _dialogService.showDialog(
          title: 'Have Some Dignity',
          description: 'You have exceeded minimum limit to borrow',
        );
      }
    }
  }

  void setAmount(double value) {
    setBusy(true);
    _amount = value;
    notifyListeners();
    setBusy(false);
  }
}
