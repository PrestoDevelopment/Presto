import 'package:firebase_auth/firebase_auth.dart';
import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/models/dialog_model.dart';
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

  Future popUpForRedeemButton() async {
    try {
      if (user.prestoCoins >= 1000) {
        DialogResponse response = await _dialogService.showConfirmationDialog(
          title: "Are You Sure",
          description:
              "1000 Presto Coins will be deducted from your profile! Do You want to proceed?",
          confirmationTitle: "Proceed!",
          cancelTitle: "Save",
        );
        if (response.confirmed) {
          await _fireStoreService.redeemCode().then((redeemCode) async {
            if (redeemCode != "") {
              user.prestoCoins = user.prestoCoins - 1000;
              await _fireStoreService.userDocUpdate(user);
              _dialogService.showDialog(
                title: "Code Redeemed",
                description:
                    "Your Code is : $redeemCode\n Please Take a screenshot and show the code to vendor",
              );
            } else if (redeemCode == "error") {
              _dialogService.showDialog(
                  title: "501 Error",
                  description:
                      "Seems like there is some problem on our side. Don't worry! we will fix it soon");
            }
          });
        }
      } else {
        return _dialogService.showDialog(
          title: "Not Enough Coins",
          description: "You do not have enough Presto Coins to redeem",
        );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future navigateToRefereesListView() async {
    try {
      await _navigationService.navigateTo(
        RefereesListViewRoute,
        false,
        arguments: user,
      );
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Stream get stream => _fireStoreService
      .listenToUserDocumentRealTime(_authenticationService.retrieveCode());
}
