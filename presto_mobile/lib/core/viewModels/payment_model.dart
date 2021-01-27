import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:presto_mobile/core/models/transaction_model.dart';
import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/core/services/shared_preferences_service.dart';
import 'package:presto_mobile/locator.dart';
import 'package:stacked/stacked.dart';

class PaymentModel extends BaseViewModel {
  final DialogService _dialogService = locator<DialogService>();
  final FireStoreService _fireStoreService = FireStoreService();
  final SharedPreferencesService _sharedPreferencesService =
      locator<SharedPreferencesService>();
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  double _amount;

  double get amount => _amount;
  UserModel _user;

  UserModel get user => _user;

  void onReady(double sum) {
    _amount = sum;
    _sharedPreferencesService.getUserCode().then((code) async {
      await _fireStoreService.getUser(code).then((user) async {
        _user = user;
      });
    });
    notifyListeners();
  }

  void initiatePaymentRequest(List<int> optionsSelected) async {
    setBusy(true);
    if (optionsSelected.isNotEmpty &&
        _user != null &&
        _user.emailVerified &&
        _user.contactVerified) {
      String transactionId =
          _user.name + (Random().nextInt(9999999) + 100000).toString();
      await _fireStoreService
          .createNewTransaction(
        TransactionModel(
          borrowerName: _user.name,
          borrowerReferralCode: _user.referralCode,
          transactionId: transactionId,
          lenderRecievedMoney: false,
          lenderSentMoney: false,
          borrowerRecievedMoney: false,
          borrowerSentMoney: false,
          approvedStatus: false,
          amount: _amount.toInt().toString(),
          initiationDate: Timestamp.now(),
          transactionMethods: optionsSelected,
          interestRate: 0.0,
          isBorrowerPenalised: false,
        ),
      )
          .whenComplete(
        () async {
          print("hello Transaction initiated");
          _navigationService.pop();
          // http.Response response = await http.post(
          //   "http://192.168.29.70:3000/firebase/notification/",
          //   headers: {"Content-Type": "application/json"},
          //   body: Notification(
          //     amount: _amount.toInt().toString(),
          //     borrowerContact: _user.contact,
          //     borrowerName: _user.name,
          //     paymentOptions: optionsSelected,
          //     transactionId: transactionId,
          //     score: ((double.parse(_user.communityScore) +
          //                 double.parse(_user.personalScore)) /
          //             2)
          //         .toString(),
          //   ).toJson(),
          // );
        },
      );
    } else if (_user == null) {
      _dialogService.showDialog(
        title: "Error",
        description: "Some technical Error !!",
      );
    } else if (!_user.emailVerified || !_user.contactVerified) {
      _dialogService.showDialog(
        title: "Error",
        description: "Please Verify Your Email First!!",
      );
    } else
      _dialogService.showDialog(
        title: "Error",
        description: "Please Select an Payment Option first !!",
      );
    setBusy(false);
  }

  void returnTap(){
    _navigationService.navigateTo("HomeView", true);
    _navigationService.pop();
  }

}
