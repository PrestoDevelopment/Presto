import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:presto_mobile/core/models/notificationModel.dart';
import 'package:stacked/stacked.dart';

class ListNotificationModel extends BaseViewModel {
  List<NotificationModel> _notifications;

  List<NotificationModel> get notifications => _notifications;

  void onModelReady(dynamic snaps) {
    if (snaps != null && snaps is QuerySnapshot) {
      snaps.docs.forEach((element) {
        _notifications.add(NotificationModel(
          borrowerName: element.data()['borrowerName'],
          amount: element.data()['amount'],
          paymentOptions: element.data()['paymentOptions'],
          borrowerContact: element.data()['borrowerContact'],
          transactionId: element.data()['transactionId'],
          score: element.data()['score'],
        ));
      });
      notifyListeners();
    }
  }
}
