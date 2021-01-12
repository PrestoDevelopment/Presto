import 'package:flutter/material.dart';
import 'package:presto_mobile/core/viewmodels/base_model.dart';
import 'package:presto_mobile/ui/views/home_view.dart';
import 'package:presto_mobile/ui/views/profile_view.dart';
import 'package:presto_mobile/ui/views/transactions_view.dart';

class MainPageModel extends BaseModel {
  var _pageOptions = [
    ProfileView(),
    HomeView(),
    TransactionsView(),
  ];
  var _pageID = [
    'ProfilePage',
    'HomePage',
    'TransactionsPage',
  ];
  int _selectedIndex = 1;

  get pageOptions => _pageOptions;
  get pageID => _pageID;
  get selectedIndex => _selectedIndex;

  void onReady() {}
  void onTappedBar(int value) {
    // FirebaseAnalytics analytics = FirebaseAnalytics();
    // analytics.setCurrentScreen(screenName: _pageID[value]);
    _selectedIndex = value;
    notifyListeners();
  }
}
