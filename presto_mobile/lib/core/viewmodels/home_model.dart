import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/viewmodels/base_model.dart';
import 'package:presto_mobile/locator.dart';

class HomeModel extends BaseModel {
  final AuthenticationService _authenticationService = AuthenticationService();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final FireStoreService _fireStoreService = locator<FireStoreService>();

  double amount;
  Map borrowingLimits;

  void onReady() async {
    setBusy(true);
    _authenticationService.userController.stream.listen((event) {
      if (event is UserModel) {
        print("-------------------------------------------------");
        print(event.name);
      }
    });
    await _fireStoreService.getBorrowingLimit().then((value) {
      borrowingLimits = value;
      amount = borrowingLimits["borrowLowerLimit"];
    });

    setBusy(false);
  }

  void increaseAmount(double value) {
    print(borrowingLimits);
    setBusy(true);
    if (amount + value <= borrowingLimits["borrowUpperLimit"]) {
      amount = amount + value;
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
    if (amount - value >= borrowingLimits["borrowLowerLimit"]) {
      amount = amount - value;
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
    amount = value;
    setBusy(false);
  }
}
