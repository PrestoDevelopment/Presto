import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/locator.dart';
import 'package:stacked/stacked.dart';

class PaymentModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  double _amount;

  double get amount => _amount;
  UserModel _user;

  UserModel get user => _user;

  void onReady(double sum) {
    _amount = sum;
    notifyListeners();
  }

  void initiatePaymentRequest(List<String> optionsSelected) {
    setBusy(true);
    if (optionsSelected.isNotEmpty)
      print("Payment Request Initiated");
    else
      _dialogService.showDialog(
        title: "Error",
        description: "Please Select an Payment Option first !!",
      );
    setBusy(false);
  }
}
