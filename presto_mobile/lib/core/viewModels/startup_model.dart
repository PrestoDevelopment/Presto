import 'package:connectivity/connectivity.dart';
import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/core/services/shared_preferences_service.dart';
import 'package:presto_mobile/locator.dart';
import 'package:stacked/stacked.dart';

class StartUpModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final SharedPreferencesService _sharedPreferencesService =
      locator<SharedPreferencesService>();
  final Connectivity connectivity = Connectivity();

  void checkConnectivity() async {
    var connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      _navigationService.navigateTo(
        'Error',
        false,
        arguments: {
          'message': "No Internet Connection",
        },
      );
    }
  }
  // final PushNotificationService _pushNotificationService =
  //     locator<PushNotificationService>();

  Future handleStartUpLogic() async {
    // Register for push notifications
    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();
    var initialCode = await _sharedPreferencesService.getUserCode();
    if (hasLoggedInUser) {
      print("going home 1");
      _navigationService.navigateTo(MainPageViewRoute, true);
    } else {
      var userLoginData = await _sharedPreferencesService.getUserEmailPass();
      if (userLoginData != null) {
        _authenticationService.login(
            userLoginData['email'], userLoginData['pass']);
        print("going home 2");
        _navigationService.navigateTo(MainPageViewRoute, true);
      } else {
        print("going Login");
        _navigationService.navigateTo(LoginViewRoute, true, arguments: true);
      }
    }
  }
}
