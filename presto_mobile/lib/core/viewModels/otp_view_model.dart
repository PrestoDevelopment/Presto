import 'package:firebase_auth/firebase_auth.dart';
import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:stacked/stacked.dart';

import '../../locator.dart';

class OtpViewModel extends BaseViewModel {
  UserModel _user;

  UserModel get user => _user;
  final FireStoreService _fireStoreService = FireStoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DialogService _dialogService = locator<DialogService>();
  NavigationService _navigationService = locator<NavigationService>();
  String verificationID; // Contains the verification ID
  AuthCredential userCredential;
  String status;
  String otp;

  void onReady(UserModel dummyUser) async {
    setBusy(true);
    _user = dummyUser;
    notifyListeners();
    verifyPhone();
  }

  void setOtp(String dummyOtp) {
    otp = dummyOtp;
    notifyListeners();
  }

  Future verifyPhone() async {
    //Defining few methods first
    final PhoneCodeSent phoneCodeSent =
        (String verID, [int forceResendingToken]) {
      //this method is called when otp is sent to user
      print("--------");
      print("Phone Code Sent");
      print("--------");
      status = "Phone Code Sent";
      verificationID = verID;
      //verification ID is set to actual ID that is provided when Phone Code is Sent
      notifyListeners();
    };

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verID) {
      //this method is called when auto retrieval timeout is over
      verificationID = verID;
      //verification ID is set to actual ID that is provided when Phone Code is Sent
      status = "Phone code auto retrieval time out";
      setBusy(false);
      notifyListeners();
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) async {
      print(e.message);
      status = "Verification fail";
      try {
        await _fireStoreService.deleteUser(_user.referralCode);
        await _auth.currentUser.delete();
        _navigationService.navigateTo(
          SignupViewRoute,
          true,
        );
        _dialogService.showDialog(
          title: "Error",
          description: "Failed To verify phone number",
        );
      } catch (e) {
        print(e.toString());
      }
    };

    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential credential) async {
      userCredential = credential;
      print(credential.providerId.toLowerCase());
      status = "verification completed";
      try {
        //In-case Auto retrieve works
        _user.contactVerified = true;
        var result = await _fireStoreService.userDocUpdate(_user);
        if (result is bool) {
          if (result) {
            await _auth.currentUser.sendEmailVerification();
            _navigationService.navigateTo(
              InfoSliderViewRoute,
              true,
            );
          } else
            print("Error 2");
        } else
          print("Error 1");
      } catch (e) {
        print(e.toString());
      }
      notifyListeners();
    };
    //Method to start verification process
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+91' + _user.contact,
      //phone-number is supplied
      timeout: Duration(seconds: 10),
      //timeout duration
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: autoRetrievalTimeout,
    );
  }

  Future<bool> signIn() async {
    if (userCredential == null) {
      //In-case Auto retrieve doesn't work
      print("Manual");
      try {
        // var userCred = PhoneAuthProvider.credential(
        //   verificationId: verificationID,
        //   smsCode: otp,
        // );
        // if (userCred is AuthCredential) {
        //   print("Phone Updated");
        // }
        // _user.contactVerified = true;
        // status = "manual sign in";
        // notifyListeners();
        var result = await _fireStoreService.userDocUpdate(_user);
        if (result is bool) {
          if (result) {
            print("Going to InfoSlider");
            //await _auth.currentUser.sendEmailVerification();
            print(InfoSliderViewRoute);
            _navigationService.navigateTo(
              InfoSliderViewRoute,
              true,
            );
            return true;
          } else
            print("Error 2");
        } else
          print("Error 1");
        return false;
      } catch (e) {
        print(e.toString());
        return false;
      }
    } else {
      try {
        //In-case Auto retrieve works
        _user.contactVerified = true;
        var result = await _fireStoreService.userDocUpdate(_user);
        if (result is bool) {
          if (result) {
            await _auth.currentUser.sendEmailVerification();
            _navigationService.navigateTo(
              InfoSliderViewRoute,
              true,
            );
          } else
            print("Error 2");
        } else
          print("Error 1");
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
