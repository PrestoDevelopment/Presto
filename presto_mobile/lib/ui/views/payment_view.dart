import 'package:flutter/material.dart';
import 'package:presto_mobile/core/viewModels/payment_model.dart';
import 'package:presto_mobile/ui/resources/Colors.dart' as color;
import 'package:presto_mobile/ui/widgets/busybutton.dart';
import 'package:presto_mobile/ui/widgets/paymentCard.dart';
import 'package:stacked/stacked.dart';

import '../resources/Colors.dart';

class PaymentView extends StatefulWidget {
  final double amount;

  PaymentView({
    this.amount,
  });

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  List<int> paymentOptions = [];

  void addToList(int i) {
    paymentOptions.add(i);
    print("Options Selected: ${paymentOptions.toString()}");
  }

  void removeFromList(int i) {
    paymentOptions.remove(i);
    print("Options Selected: ${paymentOptions.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PaymentModel>.reactive(
      viewModelBuilder: () => PaymentModel(),
      onModelReady: (model) {
        model.onReady(
          widget.amount,
        );
      },
      builder: (context, model, child) {
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: CustomPaint(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: height / 45,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: GestureDetector(
                            onTap: (){model.returnTap();},
                            child: Icon(
                              Icons.arrow_back,
                              size: 40.0,
                              color: color1,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height / 45,
                      ),
                      Container(
                        height: height / 7,
                        width: width / 1.2,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: color.color1,
                          ),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            '₹ ${widget.amount.toInt().toString()}',
                            style: TextStyle(
                              color: color.color1,
                              fontSize: 30.0,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      Text(
                        'Choose Your Mode Of Payment',
                        style: TextStyle(color: Colors.black, fontSize: 20.0),
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      PaymentCard(
                        imagePath: 'assets/images/paytm.png',
                        callBackToAddInTheOptionInTheList: addToList,
                        index: 0,
                        callBackToRemoveInTheOptionInTheList: removeFromList,
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      PaymentCard(
                        imagePath: 'assets/images/gpaylogo.png',
                        callBackToAddInTheOptionInTheList: addToList,
                        callBackToRemoveInTheOptionInTheList: removeFromList,
                        index: 1,
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      PaymentCard(
                        imagePath: 'assets/images/upi.png',
                        callBackToAddInTheOptionInTheList: addToList,
                        callBackToRemoveInTheOptionInTheList: removeFromList,
                        index: 2,
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      PaymentCard(
                        imagePath: 'assets/images/phonepelogo.png',
                        callBackToAddInTheOptionInTheList: addToList,
                        callBackToRemoveInTheOptionInTheList: removeFromList,
                        index: 3,
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      PaymentCard(
                        imagePath: 'assets/images/paypal.png',
                        callBackToAddInTheOptionInTheList: addToList,
                        callBackToRemoveInTheOptionInTheList: removeFromList,
                        index: 4,
                      ),
                      SizedBox(
                        height: height / 50,
                      ),
                      BusyButton(
                        title: "Request Money",
                        busy: model.isBusy,
                        onPressed: () =>
                            model.initiatePaymentRequest(paymentOptions),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
