import 'package:presto_mobile/core/viewmodels/base_model.dart';

class MainPageModel extends BaseModel {
  var _pageID = [
    'ProfilePage',
    'HomePage',
    'TransactionsPage',
  ];
  int _selectedIndex = 0;

  get pageID => _pageID;

  get selectedIndex => _selectedIndex;

  void onTappedBar(int value) {
    // FirebaseAnalytics analytics = FirebaseAnalytics();
    // analytics.setCurrentScreen(screenName: _pageID[value]);
    _selectedIndex = value;
    notifyListeners();
  }
}
