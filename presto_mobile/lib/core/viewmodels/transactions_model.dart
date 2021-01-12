import 'package:flutter/material.dart';
import 'package:presto_mobile/core/models/transaction_model.dart';
import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/core/viewmodels/base_model.dart';
import 'package:presto_mobile/locator.dart';
import 'package:presto_mobile/ui/widgets/transactionCards.dart';

class TransactionsModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  var _height;
  var _width;
  UserModel _user;
  get user => _user;

  void onReady(var height, var width) {
    setBusy(true);
    _authenticationService.userController.stream.listen((value) {
      _user = value;
    });
    if (_user != null) {
      setBusy(false);
    }
    _height = height;
    _width = width;
    print("Done initialising transactions model");
  }

  List<String> name = [
    "Anubhav Ajmera",
    "Raghav",
    "Kush Gupta",
    "Shubham Jain",
    "Saurabh"
  ];
  List<TransactionModel> borrowed = [];
  List<TransactionModel> lent = [];
  List<Widget> recentTransactions = [];
  List<Widget> borrowList = [];
  List<Widget> lendList = [];

  void fillLists() {
    for (int i = 0; i < borrowed.length; i++) {
      recentTransactions.add(
          borrowCard(borrowed[i].lenderName, borrowed[i].amount, "Borrow"));
    }
    for (int i = 0; i < borrowed.length; i++) {
      borrowList.add(
        mixedCard(
          borrowed[i].lenderName,
          borrowed[i].amount,
          683,
          411,
          borrowed[i].borrowerRecievedMoney &&
              borrowed[i].borrowerSentMoney &&
              borrowed[i].lenderRecievedMoney &&
              borrowed[i].lenderSentMoney,
        ),
      );
    }
    for (int i = 0; i < lent.length; i++) {
      lendList.add(
        mixedCard(
          lent[i].borrowerName,
          lent[i].amount,
          683,
          411,
          borrowed[i].borrowerRecievedMoney &&
              borrowed[i].borrowerSentMoney &&
              borrowed[i].lenderRecievedMoney &&
              borrowed[i].lenderSentMoney,
        ),
      );
    }
  }
}
