import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:presto_mobile/core/services/analytics_service.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:stacked/stacked.dart';

class MainPageModel extends StreamViewModel {
  final AnalyticsService _analyticsService = AnalyticsService();
  var _pageID = [
    'ProfilePage',
    'HomePage',
    'TransactionsPage',
    'ListNotificationPage'
  ];
  int _selectedIndex = 1;

  bool get hasData => hasData;

  get snapshots => data;

  get pageID => _pageID;

  get selectedIndex => _selectedIndex;

  void onTappedBar(int value) {
    _analyticsService.setScreen(_pageID[value]);
    _selectedIndex = value;
    notifyListeners();
  }

  @override
  Stream get stream => Firestore.instance
      .collection('notifications')
      .where('referees', arrayContains: AuthenticationService().retrieveCode())
      .snapshots();
}
