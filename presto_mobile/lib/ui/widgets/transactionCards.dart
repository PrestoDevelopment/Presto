import 'package:flutter/material.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;
import 'package:presto_mobile/ui/widgets/TransButton.dart';

Widget borrowCard(n, a, b) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          title: Text(
            n,
            style: TextStyle(
                fontSize: 20, color: b == "lend" ? Colors.green : Colors.red),
          ),
          subtitle: Row(
            children: [
              Text("₹ " + a,
                  style: TextStyle(
                      fontSize: 15,
                      color: b == "lend" ? Colors.green : Colors.red)),
              SizedBox(
                width: 10.0,
              ),
              Text(
                b,
                style: TextStyle(
                    fontSize: 15.0,
                    color: b == "lend" ? Colors.green : Colors.red),
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
                    child: Text("Transaction Date:")),
                Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text("13/07/2020"))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Payment Mode:")),
                Padding(
                    padding: EdgeInsets.only(right: 20), child: Text("Paytm"))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Due Date:")),
                Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text("20/11/2020"))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Interest Rate:")),
                Padding(padding: EdgeInsets.only(right: 20), child: Text("5%"))
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

Widget mixedCard(n, a, height, width, boolean, status) {
  bool lend = boolean;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.only(top: 6.0, left: 6.0, right: 6.0, bottom: 6.0),
        child: ExpansionTile(
          title: Text(n,
              style: TextStyle(
                  fontSize: 20, color: lend ? Colors.green : Colors.red)),
          subtitle: Text("₹ " + a,
              style: TextStyle(
                  fontSize: 15, color: lend ? Colors.green : Colors.red)),
          trailing: TransButton(
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
                    child: Text("Transaction Date:")),
                Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text("13/07/2020"))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Payment Mode:")),
                Padding(
                    padding: EdgeInsets.only(right: 20), child: Text("Paytm"))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Due Date:")),
                Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Text("20/11/2020"))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Interest Rate:")),
                Padding(padding: EdgeInsets.only(right: 20), child: Text("5%"))
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
