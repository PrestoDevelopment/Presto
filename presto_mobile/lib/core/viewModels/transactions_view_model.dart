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
  Map<String, dynamic> durationsMap;
  UserModel _user;

  get user => _user;

  void onReady(var height, var width) async {
    print("Getting user in Transactions view !!!!!!!!!!!!!");
    setBusy(true);
    durationsMap = await _fireStoreService.getLimitsOnTransactionPage();
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
            .then((transaction) async {
          String status;
          if (transaction != null && transaction is TransactionModel) {
            print("Confirming transaction fetch");
            //Fill the transaction in both all transactions list as well as if not completed in recent transactions list
            if(transaction.approvedStatus){
              if (transaction.lenderRecievedMoney) {
                status = "Phase 5";
              } else if (transaction.borrowerSentMoney) {
                status = "Phase 4";
              } else if (transaction.borrowerRecievedMoney) {
                status = "Phase 3";
              } else if (transaction.lenderSentMoney) {
                status = "Phase 2";
              } else if(!transaction.lenderSentMoney){
                status = "Phase 1";
              } else {
                status = "Lender Not Found";
              }
            }else{
              status = "Lender Not Found";
            }


            Timestamp now = Timestamp.now();
            DateTime today = now.toDate();
            DateTime defaultCase;
            DateTime recentCase;
            recentCase = today.subtract(Duration(
              days: durationsMap["recentDurationLimit"],
            ));
            defaultCase = today.subtract(Duration(
              days: durationsMap["defaultLimit"],
            ));
            // Add
            if (transaction.initiationDate.toDate().isAfter(recentCase)) {
              // i.e. is within 5 days
              print("Adding in Recent Transaction List");
              recentTransactions.add(
                mixedCard(
                  transaction: transaction,
                  isBorrowed:
                      user.name == transaction.borrowerName ? true : false,
                  height: _height,
                  width: _width,
                  status: status,
                  duration: 10,
                ),
              );
              if (transaction.initiationDate.toDate().isAfter(defaultCase)) {
                if (!transaction.isBorrowerPenalised) {
                  transaction.isBorrowerPenalised = true;
                  _fireStoreService.updateTransaction(transaction);
                  try {
                    user.personalScore = (double.parse(user.personalScore) -
                            durationsMap['decrementCreditScore'])
                        .toString();
                    await _fireStoreService
                        .userDocUpdate(user)
                        .then((val) async {
                      await _fireStoreService
                          .syncCommunityScore(user.referredBy);
                    });
                  } catch (e) {
                    print(
                      e.toString(),
                    );
                  }
                }
              }
            }
            print("Adding in All Transaction List");
            allTransactions.add(
              mixedCard(
                transaction: transaction,
                isBorrowed:
                    user.name == transaction.borrowerName ? true : false,
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
