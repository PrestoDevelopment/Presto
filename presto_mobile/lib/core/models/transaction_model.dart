import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String transactionId;
  final Timestamp initiationDate;
  final bool approvedStatus;
  final String lenderReferralCode;
  final String borrowerReferralCode;
  final Timestamp completionDate;
  final String lenderContact;
  final String borrowerName;
  bool lenderSentMoney;
  final String lenderName;
  final String amount;
  bool lenderRecievedMoney;
  bool borrowerSentMoney;
  bool borrowerRecievedMoney;
  final List<dynamic> transactionMethods;
  final double interestRate;
  bool isBorrowerPenalised;

  TransactionModel({
    this.isBorrowerPenalised,
    this.transactionMethods,
    this.transactionId,
    this.initiationDate,
    this.approvedStatus,
    this.lenderReferralCode,
    this.borrowerReferralCode,
    this.completionDate,
    this.lenderSentMoney,
    this.borrowerName,
    this.amount,
    this.borrowerRecievedMoney,
    this.borrowerSentMoney,
    this.lenderName,
    this.lenderRecievedMoney,
    this.interestRate,
    this.lenderContact,
  });
  TransactionModel.fromJson(Map<String, dynamic> json)
      : transactionId = json['transactionId'],
        initiationDate = json['initiationDate'],
        approvedStatus = json['approvedStatus'],
        transactionMethods = json['transactionMethods'],
        lenderReferralCode = json['lenderReferralCode'],
        borrowerReferralCode = json['borrowerReferralCode'],
        borrowerName = json['borrowerName'],
        lenderSentMoney = json['lenderSentMoney'],
        lenderName = json['lenderName'],
        amount = json['amount'],
        borrowerRecievedMoney = json['borrowerRecievedMoney'],
        borrowerSentMoney = json['borrowerSentMoney'],
        lenderRecievedMoney = json['lenderRecievedMoney'],
        interestRate = json['interestRate'],
        isBorrowerPenalised = json['isBorrowerPenalised'],
        lenderContact = json['lenderContact'],
        completionDate = json['completionDate'];

  Map<String, dynamic> toJson() => {
        'completionDate': completionDate,
        'interestRate': interestRate,
        'borrowerReferralCode': borrowerReferralCode,
        'lenderReferralCode': lenderReferralCode,
        'approvedStatus': approvedStatus,
        'initiationDate': initiationDate,
        'transactionId': transactionId,
        'lenderSentMoney': lenderSentMoney,
        'lenderName': lenderName,
        'amount': amount,
        'lenderContact': lenderContact,
        'isBorrowerPenalised': isBorrowerPenalised,
        'transactionMethods': transactionMethods,
        'borrowerRecievedMoney': borrowerRecievedMoney,
        'borrowerSentMoney': borrowerSentMoney,
        'lenderRecievedMoney': lenderRecievedMoney,
      };
}
