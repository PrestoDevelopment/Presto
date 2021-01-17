import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/locator.dart';
import 'package:stacked/stacked.dart';

class ProfileModel extends StreamViewModel {
  final AuthenticationService _authenticationService = AuthenticationService();
  final NavigationService _navigationService = locator<NavigationService>();
  final FireStoreService _fireStoreService = FireStoreService();

  // final SharedPreferencesService _preferencesService =
  //     SharedPreferencesService();

  bool get hasUserData => dataReady;

  UserModel get user => data;
  String _creditWorthyScore;

  get creditWorthyScore => _creditWorthyScore;

  void onReady() async {
    print("Getting user in Profile view !!!!!!!!!!!!!");
    // setBusy(true);
    // getUserDataForModel();
    // setBusy(false);
    // print("Done initialising profile model");
    // listenToDatabase();
  }

  // void listenToDatabase() {
  //   setBusy(true);
  //   _fireStoreService
  //       .listenToUserDocumentRealTime(_authenticationService.retrieveCode())
  //       .listen((updateUser) {
  //     if (updateUser != null) {
  //       _creditWorthyScore = ((double.parse(user.communityScore) +
  //                   double.parse(user.personalScore)) /
  //               2)
  //           .toString();
  //       notifyListeners();
  //     }
  //   });
  //   setBusy(false);
  // }

  // void getUserDataForModel() async {
  //   var temp =
  //       await _fireStoreService.getUser(_authenticationService.retrieveCode());
  //   if (temp is UserModel) {
  //     _user = temp;
  //     _creditWorthyScore = ((double.parse(_user.communityScore) +
  //                 double.parse(_user.personalScore)) /
  //             2)
  //         .toString();
  //     notifyListeners();
  //     print("Got user in profile View!!");
  //   }
  // }

  Future signOut() async {
    bool sure = await _authenticationService.signOut();
    if (sure) await _navigateToLogin();
  }

  Future _navigateToLogin() async {
    await _navigationService.navigateTo(LoginViewRoute, true);
  }

  @override
  Stream get stream => _fireStoreService
      .listenToUserDocumentRealTime(_authenticationService.retrieveCode());
}
