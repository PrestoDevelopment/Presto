import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:presto_mobile/core/models/transaction_model.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';

class TransCardManager {
  String _status;
  String _targetUser;
  TransactionModel _transaction;
  FireStoreService _fireStoreService = FireStoreService();

  void setTransaction(TransactionModel transactionModel) {
    _transaction = transactionModel;
  }

  void setStatus(String status) {
    _status = status;
  }

  void setTargetUser(String userTargeted) {
    _targetUser = userTargeted;
  }

  String getRefinedStatus() {
    if (_targetUser == 'Lender') {
      if (_status == 'Phase 1') {
        return "Upload Transcript";
      } else if (_status == 'Phase 2') {
        return "Money Sent";
      } else if (_status == 'Phase 3') {
        return "Money Sent";
      } else if (_status == 'Phase 4') {
        return "Confirm Payback";
      } else if (_status == 'Phase 5') {
        return "Transaction Done";
      } else {
        return "Please Refresh";
      }
    } else if (_targetUser == 'Borrower') {
      if (_status == 'Phase 1')
        return "In Progress";
      else if (_status == 'Phase 2')
        return "Confirm";
      else if (_status == 'Phase 3')
        return "Payback";
      else if (_status == 'Phase 4')
        return "Transaction Done";
      else if (_status == 'Phase 5')
        return "Transaction Done";
      else
        return "Please Refresh";
    } else {
      return "Please Refresh";
    }
  }

  Function onTap() {
    if (_targetUser == 'Lender') {
      if (_status == 'Phase 1') {
        ///Lender uploads payment receipt
        return () async {
          try {
            FilePickerResult result = await FilePicker.platform.pickFiles();
            if (result != null) {
              PlatformFile file = result.files.first;
              print(file.name);
              print(file.bytes);
              print(file.size);
              print(file.extension);
              print(file.path);
              Reference _reference = FirebaseStorage.instance.ref().child(
                  '${_transaction.lenderReferralCode}/${_transaction.transactionId}');
              await _reference.putFile(File(file.path)).then((result) async {
                if (result.bytesTransferred == result.totalBytes) {
                  await _fireStoreService.changeBoolPaymentSent(
                    _transaction,
                    true,
                  );
                }
              });
            } else {
              // User canceled the picker
              DialogService().showDialog(
                title: "Error",
                description: "Please Select an image to upload the receipt",
              );
            }
          } catch (e) {
            print("Error in Uploading transcript");
            print(e.toString());
          }
        };
      } else if (_status == 'Phase 4') {
        ///Lender confirms payment received
        return () async {
          try {
            await _fireStoreService.changeBoolPaymentReceived(
                _transaction, false);
          } catch (e) {
            print("Error in Changing the bool");
            print(e.toString());
          }
        };
      }
    } else if (_targetUser == 'Borrower') {
      if (_status == 'Phase 2') {
        ///Borrower confirms payment Received
        return () async {
          try {
            await _fireStoreService.changeBoolPaymentReceived(
                _transaction, true);
          } catch (e) {
            print("Error in Changing the bool");
            print(e.toString());
          }
        };
      } else if (_status == 'Phase 3') {
        ///Borrower uploads payment receipt
        return () async {
          try {
            FilePickerResult result = await FilePicker.platform.pickFiles();
            if (result != null) {
              PlatformFile file = result.files.first;
              print(file.name);
              print(file.bytes);
              print(file.size);
              print(file.extension);
              print(file.path);
              Reference _reference = FirebaseStorage.instance.ref().child(
                  '${_transaction.borrowerReferralCode}/${_transaction.transactionId}');
              await _reference.putFile(File(file.path)).then((result) async {
                if (result.bytesTransferred == result.totalBytes) {
                  await _fireStoreService.changeBoolPaymentSent(
                    _transaction,
                    true,
                  );
                }
              });
            } else {
              // User canceled the picker
              DialogService().showDialog(
                title: "Error",
                description: "Please Select an image to upload the receipt",
              );
            }
          } catch (e) {
            print("Error in Uploading transcript");
            print(e.toString());
          }
        };
      }
    }
  }
}
