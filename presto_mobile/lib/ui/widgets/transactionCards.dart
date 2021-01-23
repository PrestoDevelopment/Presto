import 'package:flutter/material.dart';
import 'package:presto_mobile/core/models/transaction_model.dart';
import 'package:presto_mobile/ui/widgets/TransButton.dart';

Widget mixedCard({
  TransactionModel transaction,
  double height,
  double width,
  bool isBorrowed,
  status,
  int duration,
}) {
  String paymentModes = '';
  List<String> options = ['PayTm', 'GPay', 'UPI', 'PhonePay', 'PayPal'];
  transaction.transactionMethods.forEach((element) {
    paymentModes = paymentModes + options[element];
  });
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          title: Text(
            isBorrowed
                ? transaction.lenderName ?? "Failed"
                : transaction.borrowerName ?? "Failed",
            style: TextStyle(
              fontSize: 20,
              color: !isBorrowed ? Colors.green : Colors.red,
            ),
          ),
          subtitle: Text(
            "₹ " + transaction.amount,
            style: TextStyle(
              fontSize: 15,
              color: !isBorrowed ? Colors.green : Colors.red,
            ),
          ),
          trailing: TransactionCardButton(
            tranStatus: status,
          ),
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text("Transaction Date:"),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    transaction.initiationDate.toDate().toString(),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: 20,
                  ),
                  child: Text("Payment Mode:"),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(paymentModes),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text("Due Date:"),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    transaction.approvedStatus
                        ? transaction.initiationDate
                            .toDate()
                            .add(
                              Duration(
                                days: duration,
                              ),
                            )
                            .toString()
                        : "N/A",
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text("Interest Rate:"),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text("${transaction.interestRate.toString()} %"),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    ),
  );
}
