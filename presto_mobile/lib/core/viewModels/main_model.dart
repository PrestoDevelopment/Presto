import 'package:presto_mobile/core/services/push_notification_service.dart';
import 'package:stacked/stacked.dart';

class MainPageModel extends BaseViewModel {
  // final PushNotificationService _pushNotificationService =
  //     PushNotificationService();
  var _pageID = [
    'ProfilePage',
    'HomePage',
    'TransactionsPage',
  ];
  int _selectedIndex = 1;

  get pageID => _pageID;

  // void onModelReady() async {
  //   // initialised Push notifications
  //   // await _pushNotificationService.initialise();
  //   // TODO: push InfoSlider if SignUp
  // }

  get selectedIndex => _selectedIndex;

  void onTappedBar(int value) {
    // FirebaseAnalytics analytics = FirebaseAnalytics();
    // analytics.setCurrentScreen(screenName: _pageID[value]);
    _selectedIndex = value;
    notifyListeners();
  }
}
