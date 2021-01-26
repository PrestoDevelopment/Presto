import 'package:stacked/stacked.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/locator.dart';
import '../services/authentication_service.dart';
import '../services/firestore_service.dart';

class ListNotificationModel extends StreamViewModel{
  final AuthenticationService _authenticationService = AuthenticationService();
  final NavigationService _navigationService = locator<NavigationService>();
  final FireStoreService _fireStoreService = FireStoreService();
  final DialogService _dialogService = locator<DialogService>();

  bool get hasUserData => dataReady;

  @override
  // TODO: implement stream
  Stream get stream => throw UnimplementedError();
}