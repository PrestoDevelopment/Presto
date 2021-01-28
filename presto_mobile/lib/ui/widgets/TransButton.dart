import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:presto_mobile/core/models/dialog_model.dart';
import 'package:presto_mobile/core/models/transaction_model.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/managers/trans_card_manager.dart';
import 'package:presto_mobile/locator.dart';
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

  Future transactionButtonTap() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
    } else {
      // User canceled the picker
    }
  }


  TransCardManager _cardManager = TransCardManager();

  @override
  Widget build(BuildContext context) {
    String displayText;
    Function onTap;

    if(tranStatus!="Lender Not Found"){
      _cardManager.setTargetUser(userTargeted);
      _cardManager.setStatus(tranStatus);
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
        onTap: onTap,
      );
    } else {
      return null;
    }
  }
}
