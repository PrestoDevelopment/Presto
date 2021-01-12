import 'package:flutter/material.dart';
import 'package:presto_mobile/core/viewmodels/transactions_model.dart';
import 'package:stacked/stacked.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;

class TransactionsView extends StatefulWidget {
  @override
  _TransactionsViewState createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return ViewModelBuilder<TransactionsModel>.reactive(
      viewModelBuilder: () => TransactionsModel(),
      onModelReady: (model) => model.onReady(height, width),
      builder: (context, model, child) => model.busy
          ? Center(
              child: Container(
                color: Colors.amber,
                child: FadingText(
                  'Loading transactions...',
                ),
              ),
            )
          : SafeArea(
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "Recent Transactions",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.black,
                                fontFamily: "Oswald"),
                          )),
                      SizedBox(
                        height: 20.0,
                      ),
                      Column(
                        children: model.recentTransactions,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "All Transactions",
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: model.lendList,
                      ),
                      Column(
                        children: model.borrowList,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
