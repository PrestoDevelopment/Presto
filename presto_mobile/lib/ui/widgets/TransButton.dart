import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:presto_mobile/core/models/transaction_model.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/ui/resources/Colors.dart';

class TransactionCardButton extends StatelessWidget {
  final String tranStatus;
  final double height;
  final double width;
  TransactionModel transaction;

  TransactionCardButton({
    this.tranStatus,
    this.height,
    this.width,
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

  FireStoreService _fireStoreService = FireStoreService();

  @override
  Widget build(BuildContext context) {
    String displayText;
    Function onTap;
    switch (tranStatus) {
      case "Transaction Finished":
        displayText = "Transaction Complete!";
        onTap = () {
          //Do Nothing
        };
        break;
      case "Lender Sent Money":
        displayText = "Confirm Receive";
        onTap = () async {
          //pop Confirmation dialog box and if yes change firebase bool value
          await _fireStoreService.changeBoolPaymentReceived(
            transaction,
            false,
          );
        };
        break;
      case "Borrower Received money":
        displayText = "Payback Now!";
        onTap = () async {
          await transactionButtonTap();
        };
        break;
      case "Send Money":
        displayText = "Confirm Transaction";
        onTap = () async {
          await transactionButtonTap();
        };
        break;
      case "Borrower sent money":
        displayText = "Confirm Payback";
        onTap = () async {
          //pop Confirmation dialog box and if yes change firebase bool value
          await _fireStoreService.changeBoolPaymentReceived(
            transaction,
            true,
          );
        };
        break;
      default:
        displayText = "Transaction Failed";
        onTap = () {};
        break;
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
