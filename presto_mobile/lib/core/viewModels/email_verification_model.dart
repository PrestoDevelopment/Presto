import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/locator.dart';
import 'package:stacked/stacked.dart';

class EmailVerificationModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  void onModelReady() async {
    await _authenticationService
        .verifyEmail(_authenticationService.currentUser);
  }

  void proceed() {
    _navigationService.navigateTo(InfoSliderViewRoute, true);
  }
}
