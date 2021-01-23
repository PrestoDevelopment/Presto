import 'package:flutter/material.dart';
import 'package:presto_mobile/core/viewModels/transactions_model.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:stacked/stacked.dart';

class TransactionsView extends StatefulWidget {
  @override
  _TransactionsViewState createState() => _TransactionsViewState();
}

class _TransactionsViewState extends State<TransactionsView> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return ViewModelBuilder<TransactionsViewModel>.reactive(
      viewModelBuilder: () => TransactionsViewModel(),
      onModelReady: (model) => model.onReady(height, width),
      builder: (context, model, child) => model.isBusy
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
                            fontFamily: "Oswald",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Column(
                        children: model.recentTransactions.length > 0
                            ? model.recentTransactions
                            : [
                                Container(
                                  child: Text("No Transactions to Display"),
                                ),
                              ],
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
                        children: model.allTransactions.length > 0
                            ? model.allTransactions
                            : [
                                Container(
                                  child: Text("No Transactions to Display"),
                                ),
                              ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
