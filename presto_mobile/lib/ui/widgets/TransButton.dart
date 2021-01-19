import 'package:flutter/material.dart';
import 'package:presto_mobile/ui/resources/Colors.dart';
class TransButton extends StatelessWidget {
  final String tranStatus;

  TransButton(this.tranStatus);

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    String displayText;

    switch(tranStatus){
      case "No Transaction" : displayText = "Confirm Sent!";
      break;
      case "Lender Sent Money" : displayText = "Confirm Receive";
      break;
      case "Borrower Recieved money" : displayText = "Payback Now!";
      break;
      case "Borrower sent money" : displayText = "Confirm Payback";
      break;
      default : displayText = null;

    }

    if(displayText!=null){
      return GestureDetector(
        child: Container(
          height: height / 17,
          width: width / 4,
          color: color1,
          child: Center(
            child: Text(
              displayText,
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ),
        ),
      );
    }else{
      return null;
    }

  }
}
