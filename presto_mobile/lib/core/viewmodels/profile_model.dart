import 'package:firebase_auth/firebase_auth.dart';
import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/locator.dart';
import 'package:stacked/stacked.dart';

class ProfileModel extends StreamViewModel {
  final AuthenticationService _authenticationService = AuthenticationService();
  final NavigationService _navigationService = locator<NavigationService>();
  final FireStoreService _fireStoreService = FireStoreService();
  final DialogService _dialogService = locator<DialogService>();

  // final SharedPreferencesService _preferencesService =
  //     SharedPreferencesService();

  bool get hasUserData => dataReady;

  UserModel get user => data;
  String _creditWorthyScore;

  get creditWorthyScore => _creditWorthyScore;

  void onReady() async {
    print("Getting user in Profile view !!!!!!!!!!!!!");
    FirebaseAuth _auth = FirebaseAuth.instance;
    if (_auth.currentUser.emailVerified) {
      user.emailVerified = true;
      var result = await _fireStoreService.userDocUpdate(user);
      if (result is String) {
        print(result);
        _dialogService.showDialog(
          title: "Error",
          description: result,
        );
        throw FirebaseException(plugin: null, message: result);
      }
    }
  }

  void emailVeriPop() {
    // _authenticationService.;
    if (user.emailVerified)
      _dialogService.showDialog(
        title: "Email Verification",
        description: "Your Email Is Verified",
      );
    else {
      _dialogService.showDialog(
        title: "Email Verification",
        description:
            "A verification email has been sent to registered Email, Please verify",
      );
      _authenticationService.verifyEmail(user);
    }
  }

  Future signOut() async {
    bool sure = await _authenticationService.signOut();
    if (sure) await _navigateToLogin();
  }

  Future _navigateToLogin() async {
    await _navigationService.navigateTo(LoginViewRoute, true);
  }

  Future navigateToOtp() async {
    await _navigationService.navigateTo(OtpViewRoute, false, arguments: user);
  }

  @override
  Stream get stream => _fireStoreService
      .listenToUserDocumentRealTime(_authenticationService.retrieveCode());
}
