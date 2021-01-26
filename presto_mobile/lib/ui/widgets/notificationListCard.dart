import 'package:flutter/material.dart';
import 'package:presto_mobile/core/models/transaction_model.dart';
import 'package:presto_mobile/ui/widgets/TransButton.dart';

import '../resources/Colors.dart';

Widget notificationListCard(){
  return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
    child: Card(
      elevation: 5.0,
      child: Padding(
        padding: EdgeInsets.all(6.0),
        child: ExpansionTile(
          title: Text(
              '₹ 500',
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
                'Credit Score: 4.5',
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
              Text(
                'Mode of Payment: PayTm, Gpay',
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
                    'Sushrut Patwardhan',
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
                  child: Text('9322799919'),
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
                  child: Text('12/2/2021')
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
                          //width: MediaQuery.of(context).size.width/20,
                          color: Colors.green,
                          child: Center(
                            child: Text(
                                'Yes',
                              style: TextStyle(
                                fontSize: 20.0,
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      GestureDetector(
                        child: Container(
                          color: Colors.red,
                          child: Center(
                            child: Text(
                                'No',
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      )
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