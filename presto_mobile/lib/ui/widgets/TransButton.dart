import 'package:flutter/material.dart';
import 'package:presto_mobile/core/models/transaction_model.dart';
import 'package:presto_mobile/managers/trans_card_manager.dart';
import 'package:presto_mobile/ui/resources/Colors.dart';

// ignore: must_be_immutable
class TransactionCardButton extends StatelessWidget {
  final String tranStatus;
  final double height;
  final double width;
  final String userTargeted;
  TransactionModel transaction;

  TransactionCardButton({
    this.tranStatus,
    this.height,
    this.width,
    this.userTargeted,
    this.transaction,
  });

  TransCardManager _cardManager = TransCardManager();

  @override
  Widget build(BuildContext context) {
    String displayText;
    if (tranStatus != "Lender Not Found") {
      _cardManager.setTargetUser(userTargeted);
      _cardManager.setStatus(tranStatus);
      _cardManager.setTransaction(transaction);
      displayText = _cardManager.getRefinedStatus();
    }

    if (displayText != null) {
      return GestureDetector(
        child: Container(
          height: height / 17,
          width: width / 4,
          color: color1,
          child: Center(
            child: Text(
              displayText,
              style: TextStyle(fontSize: 12.0, color: Colors.white),
            ),
          ),
        ),
        onTap: _cardManager.onTap(),
      );
    } else {
      return Icon(
        Icons.arrow_drop_down,
        color: Colors.black,
      );
    }
  }
}
