import 'package:stacked/stacked.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/locator.dart';

class EmailVerificationModel extends BaseViewModel{
  final AuthenticationService _authenticationService =
  locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final FireStoreService _firestoreService = FireStoreService();
  final NavigationService _navigationService = locator<NavigationService>();

}