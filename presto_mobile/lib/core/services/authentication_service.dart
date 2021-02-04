import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:presto_mobile/core/models/dialog_model.dart';
import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/core/services/shared_preferences_service.dart';
import 'package:presto_mobile/locator.dart';

import '../models/user_model.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Connectivity connectivity = Connectivity();
  // final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final DialogService _dialogService = locator<DialogService>();
  final FireStoreService _fireStoreService = FireStoreService();
  final SharedPreferencesService _sharedPreferencesService =
      locator<SharedPreferencesService>();
  final NavigationService _navigationService = NavigationService();
  UserModel _currentUser;

  UserModel get currentUser => _currentUser;

  //LogIn  Part

  String retrieveCode() {
    return _auth.currentUser.displayName;
  }

  void verifyEmail(UserModel user) async {
    try {
      await _auth.currentUser.sendEmailVerification();
    } catch (e) {
      print(e.toString());
    }
  }

  Future login(String email, String pass) async {
    print("Logging in");
    try {
      var authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );

      var result;
      if (authResult is String)
        return authResult;
      else if (authResult is UserCredential) {
        result = await _populateCurrentUser(
          authResult,
          true,
          email,
          pass,
          authResult.user.displayName,
        );
      }
      return result;
    } catch (e) {
      print("There's an error in logging In");
      return e;
    }
  }

  Future signUp(UserModel user, String pass) async {
    try {
      FirebaseMessaging _fcm = FirebaseMessaging();
      await _fcm.getToken().then((token) async {
        await _sharedPreferencesService.synUserToken(token);
        user.notificationToken = token;
      });
      _currentUser = user;
      print("Now verifying OTP");
      var authResult = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: pass,
      );
      if (user.referredBy == "CM01") {
        print("signing a community manager underling");
        return await _populateCurrentUser(
          authResult,
          false,
          user.email,
          pass,
          user.referralCode,
        );
      } else
        await _fireStoreService.parentDocUpdate(
            user.referredBy, user.referralCode);
      return await _populateCurrentUser(
        authResult,
        false,
        user.email,
        pass,
        user.referralCode,
      );
    } catch (e) {
      return e;
    }
  }

  Future _populateCurrentUser(
    var cred,
    bool isLogIn,
    String pass,
    String email,
    String code,
  ) async {
    if (cred is FirebaseAuthException) return cred.message;
    if (cred is String) return cred;
    if (cred != null) {
      //return true after setting up user in database
      await _sharedPreferencesService.synUserEmailPass(email, pass);
      await _sharedPreferencesService.synUserCode(code);

      if (isLogIn) {
        try {
          var userToken;
          FirebaseMessaging _fcm = FirebaseMessaging();
          await _fcm.getToken().then((token) async {
            await _sharedPreferencesService.synUserToken(token);
            userToken = token;
          });
          _currentUser = await _fireStoreService.getUser(cred.user.displayName);
          // userController.add(_currentUser);
          _currentUser.notificationToken = userToken;
          print("Completed populating user");
          _fireStoreService.userDocUpdate(_currentUser);
          return true;
        } catch (e) {
          print("there's an error here");
          print(e.toString());
          if (e is PlatformException) return e.message;
          return e.toString();
        }
        // await _analyticsService.setUserProperties(
        //   userId: cred.user.displayName,
        // );
        // return true;
      } else {
        //Set display name to referral code
        try {
          print(
              "Updating user display name and then creating user database entry");
          _auth.currentUser
              .updateProfile(displayName: _currentUser.referralCode);
          //userController.add(_currentUser);
          await _fireStoreService.createUser(_currentUser);
          return true;
        } catch (e) {
          if (e is PlatformException) return e.message;
          return e.toString();
        }
      }
    } else
      return false;
  }

  Future<bool> isUserLoggedIn() async {
    print("Checking whether user is logged in");
    var user = _auth.currentUser;
    if (user != null) {
      var temp = await _fireStoreService.getUser(user.displayName);
      if (temp is UserModel) {
        // userController.add(temp);
        _currentUser = temp;
      }
    }
    return user != null;
  }

  Future<bool> signOut() async {
    DialogResponse response = await _dialogService.showConfirmationDialog(
      title: "Sign Out",
      description: "Are you sure you want to sign out?",
      confirmationTitle: "Yes :(",
      cancelTitle: "No :)",
    );
    if (response.confirmed) {
      _sharedPreferencesService.clearUserLoginData();
      await _auth.signOut();
      return true;
    }
    return false;
  }
}
