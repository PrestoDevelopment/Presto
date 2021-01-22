class Notification {
  final String borrowerName;
  final String amount;
  final List<int> paymentOptions;
  final String borrowerContact;
  final String transactionId;
  final String score;

  Notification({
    this.borrowerName,
    this.amount,
    this.paymentOptions,
    this.borrowerContact,
    this.transactionId,
    this.score,
  });

  Notification.fromJson(Map<String, dynamic> json)
      : transactionId = json['transactionId'],
        borrowerName = json['borrowerName'],
        amount = json['amount'],
        paymentOptions = json['paymentOptions'],
        score = json['score'],
        borrowerContact = json['borrowerContact'];

  Map<String, dynamic> toJson() => {
        'borrowerContact': borrowerContact,
        'paymentOptions': paymentOptions,
        'amount': amount,
        'borrowerName': borrowerName,
        'transactionId': transactionId,
        'score': score,
      };
}
