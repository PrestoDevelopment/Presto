import 'package:connectivity/connectivity.dart';
import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/core/viewmodels/base_model.dart';
import 'package:presto_mobile/locator.dart';

class StartUpModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();
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
    // await _pushNotificationService.initialise();

    var hasLoggedInUser = await _authenticationService.isUserLoggedIn();

    if (hasLoggedInUser) {
      print("going home");
      _navigationService.navigateTo(HomeViewRoute, true);
    } else {
      print("going Login");
      _navigationService.navigateTo(LoginViewRoute, true);
    }
  }
}
