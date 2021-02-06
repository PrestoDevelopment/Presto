import 'package:flutter/material.dart';
import 'package:presto_mobile/core/models/notificationModel.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';

Widget notificationListCard(
  NotificationModel notification,
  var height,
  var width,
) {
  FireStoreService _fireStoreService = FireStoreService();
  String paymentModes = '';
  List<String> options = ['PayTm', 'GPay', 'UPI', 'PhonePay', 'PayPal'];

  for (int i = 0; i < notification.paymentOptions.length; i++) {
    i == paymentModes.length - 1
        ? paymentModes = paymentModes + options[i]
        : paymentModes = paymentModes + options[i] + ', ';
  }

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
    child: Card(
      elevation: 5.0,
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: ExpansionTile(
          title: Text(
            '₹ ${notification.amount}',
            style: TextStyle(
              fontSize: 25.0,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '12/1/2021',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              Text(
                'Credit Score: ${notification.score}',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              Text(
                'Mode of Payment: $paymentModes',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              )
            ],
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
                  child: Text("Name:"),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text(
                    '${notification.borrowerName}',
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
                  child: Text("Contact No.:"),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text('${notification.borrowerContact}'),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: <Widget>[
            //     Padding(
            //       padding: EdgeInsets.only(left: 20),
            //       child: Text("Due Date:"),
            //     ),
            //     Padding(
            //         padding: EdgeInsets.only(right: 20),
            //         child: Text('12/2/2021')),
            //   ],
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 20),
                  child: Text("Interest Rate:"),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text("1%"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text('Do You Want To Lend?'),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Row(
                    children: [
                      GestureDetector(
                        child: Container(
                          width: width / 10,
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        onTap: () async {
                          var result = await _fireStoreService
                              .approveHandshake(notification.transactionId);

                          if (result is bool && result) {
                            DialogService().showDialog(
                                title: "Success",
                                description:
                                    "Handshake Success!!\n Now Please Complete the Transaction.");
                          }
                        },
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      // GestureDetector(
                      //   child: Container(
                      //     width: width / 10,
                      //     color: Colors.red,
                      //     child: Center(
                      //       child: Text(
                      //         'No',
                      //         style: TextStyle(
                      //             fontSize: 20.0, color: Colors.white),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                )
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
