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
      fillLists(userData);
    });
    _height = height;
    _width = width;
  }

  List<Widget> recentTransactions = [];
  List<Widget> allTransactions = [];

  void fillLists(UserModel user) async {
    print("Initiate loop for transactions");
    user.transactionIds.forEach(
      (transactionId) async {
        print(transactionId + "\n");
        await _fireStoreService
            .getTransaction(transactionId)
            .then((transaction) {
          String status;
          if (transaction != null && transaction is TransactionModel) {
            print("Confirming transaction fetch");
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
              print("Adding in Recent Transaction List");
              recentTransactions.add(
                mixedCard(
                  transaction: transaction,
                  isBorrowed: user.name == transaction.borrowerName ?? "",
                  height: _height,
                  width: _width,
                  status: status,
                  duration: 10,
                ),
              );
            }
            print("Adding in All Transaction List");
            allTransactions.add(
              mixedCard(
                transaction: transaction,
                isBorrowed: user.name == transaction.borrowerName ?? "",
                height: _height,
                width: _width,
                status: status,
                duration: 10,
              ),
            );
            print(
                "Transactions LIst : \n ${recentTransactions.length} \n ${allTransactions.length} \n-------------------------------------");
            notifyListeners();
          }
        });

        //done filling the list
      },
    );
    print("Done initialising transactions model");
    setBusy(false);
  }
}
