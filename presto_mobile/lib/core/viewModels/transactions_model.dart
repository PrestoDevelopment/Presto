import 'package:cloud_firestore/cloud_firestore.dart';
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
  int duration;
  UserModel _user;

  get user => _user;

  void onReady(var height, var width) async {
    print("Getting user in Transactions view !!!!!!!!!!!!!");
    setBusy(true);
    duration = await _fireStoreService.getLimitsOnTransactionPage();
    String code = await _preferencesService.getUserCode();
    print("Got User Code");
    await _fireStoreService.getUser(code).then((userData) async {
      _user = userData;
      print("Got User data");
      notifyListeners();
      fillLists();
    });
    _height = height;
    _width = width;
  }

  List<Widget> recentTransactions = [];
  List<Widget> allTransactions = [];

  void fillLists() async {
    print("getting transactions");
    await _user.transactionIds.forEach(
      (transactionId) async {
        print(transactionId + "\n");
        var transaction = await _fireStoreService.getTransaction(transactionId);
        String status;
        if (transaction != null && transaction is TransactionModel) {
          //Fill the transaction in both all transactions list as well as if not completed in recent transactions list
          if (transaction.lenderRecievedMoney) {
            status = "Transaction Finished";
          } else if (!transaction.borrowerRecievedMoney &&
              !transaction.lenderSentMoney) {
            status = "Send Money";
          } else if (transaction.borrowerSentMoney) {
            status = "Borrower sent money";
          } else if (transaction.borrowerRecievedMoney) {
            status = "Borrower Received money";
          } else if (transaction.lenderSentMoney) {
            status = "Lender Sent Money";
          } else if (!transaction.borrowerRecievedMoney &&
              !transaction.lenderSentMoney &&
              transaction.approvedStatus) {
            status = "Send Money";
          } else {
            status = "Lender Not Found";
          }
          Timestamp now = Timestamp.now();
          DateTime today = now.toDate();
          today = today.subtract(Duration(
            days: 5,
          ));
          // Add
          if (transaction.initiationDate.toDate().isAfter(today)) {
            // i.e. is within 5 days
            recentTransactions.add(
              mixedCard(
                transaction: transaction,
                isBorrowed: _user.name == transaction.borrowerName ?? "",
                height: _height,
                width: _width,
                status: status,
                duration: 10,
              ),
            );
          }
          allTransactions.add(
            mixedCard(
              transaction: transaction,
              isBorrowed: _user.name == transaction.borrowerName ?? "",
              height: _height,
              width: _width,
              status: status,
              duration: 10,
            ),
          );
          //done filling the list
          print("Done initialising transactions model");
          setBusy(false);
        }
      },
    );
  }
}
