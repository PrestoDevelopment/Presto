import 'package:flutter/material.dart';
import 'package:presto_mobile/core/models/transaction_model.dart';
import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/core/services/shared_preferences_service.dart';
import 'package:presto_mobile/locator.dart';
import 'package:presto_mobile/ui/widgets/transactionCards.dart';
import 'package:stacked/stacked.dart';

class TransactionsViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  // final NavigationService _navigationService = locator<NavigationService>();
  final SharedPreferencesService _preferencesService =
      SharedPreferencesService();
  final FireStoreService _fireStoreService = FireStoreService();

  var _height;
  var _width;
  UserModel _user;

  get user => _user;

  void onReady(var height, var width) async {
    print("Getting user in Transactions view !!!!!!!!!!!!!");
    setBusy(true);

    // listenToDatabase();
    _height = height;
    _width = width;
    print("Done initialising transactions model");
  }

  void listenToDatabase() {
    setBusy(true);
    _fireStoreService
        .listenToUserDocumentRealTime(_authenticationService.retrieveCode())
        .listen((updateUser) {
      if (updateUser != null) {
        _user = updateUser;
        notifyListeners();
      }
    });
    setBusy(false);
  }

  List<String> name = [
    "Anubhav Ajmera",
    "Raghav",
    "Kush Gupta",
    "Shubham Jain",
    "Saurabh"
  ];

  List<Widget> recentTransactions = [];
  List<Widget> allTransactions = [];

  void fillLists() {
    _user.transactionIds.forEach((transactionId) async {
      var transaction = await _fireStoreService.getTransaction(transactionId);
      String status;
      if (transaction != null && transaction is TransactionModel) {
        //Fill the transaction in both all transactions list as well as if not completed in recent transactions list
        if (transaction.lenderRecievedMoney) {
          status = "Transaction Finished";
        } else if (transaction.borrowerSentMoney) {
          status = "Borrower sent money";
        } else if (transaction.borrowerRecievedMoney) {
          status = "Borrower Received money";
        } else if (transaction.lenderSentMoney) {
          status = "Lender Sent Money";
        } else {
          status = "No Transaction";
        }
        // Add

      }
    });
    for (int i = 0; i < borrowed.length; i++) {
      borrowList.add(
        mixedCard(
          borrowed[i].lenderName,
          borrowed[i].amount,
          _height,
          _width,
          borrowed[i].borrowerRecievedMoney &&
              borrowed[i].borrowerSentMoney &&
              borrowed[i].lenderRecievedMoney &&
              borrowed[i].lenderSentMoney,
          status,
        ),
      );
    }
  }
}
