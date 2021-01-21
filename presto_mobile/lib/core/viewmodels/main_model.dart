import 'package:stacked/stacked.dart';

class MainPageModel extends BaseViewModel {
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
