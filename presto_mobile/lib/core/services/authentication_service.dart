import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:presto_mobile/core/models/dialog_model.dart';
import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/services/analytics_service.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/locator.dart';
import 'package:connectivity/connectivity.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Connectivity connectivity = Connectivity();
  final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final DialogService _dialogService = locator<DialogService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  StreamController<UserModel> userController =
      StreamController<UserModel>.broadcast();
  UserModel _currentUser;
  UserModel get currentUser => _currentUser;
  //LogIn  Part

  Future login(String email, String pass) async {
    print("Logging in");
    try {
      var authResult = await _auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      if (authResult is String) return authResult;
      return true;
    } catch (e) {
      return e;
    }
  }

  Future signup(UserModel user, String pass) async {
    try {
      _currentUser = user;
      print("Signing in");
      var authResult = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: pass,
      );
      await _firestoreService.parentDocUpdate(
          user.referralCode, user.referredBy);
      return await _populateCurrentUser(authResult, false);
    } catch (e) {
      return e;
    }
  }

  Future _populateCurrentUser(var cred, bool isLogIn) async {
    print("populationg user");
    if (cred is FirebaseAuthException) return cred.message;
    if (cred is String) return cred;
    if (cred != null && isLogIn) {
      //return true after setting up user in database
      if (isLogIn) {
        try {
          _currentUser = await _firestoreService.getUser(cred.user.displayName);
          userController.add(_currentUser);
        } catch (e) {
          if (e is PlatformException)
            return _dialogService.showDialog(
                title: "error", description: e.message);
          return _dialogService.showDialog(
              title: "error", description: e.toString());
        }
        await _analyticsService.setUserProperties(
          userId: cred.user.displayName,
        );
        return true;
      } else {
        //Set display name to referral code
        _auth.currentUser.updateProfile(displayName: _currentUser.referralCode);
        userController.add(_currentUser);
        await _firestoreService.createUser(_currentUser);
      }
    } else
      return false;
  }

  Future<bool> isUserLoggedIn() async {
    print("Checking whether user is logged in");
    var user = _auth.currentUser;
    return user != null;
  }

  Future signOut() async {
    DialogResponse response = await _dialogService.showConfirmationDialog(
      title: "Sign Out",
      description: "Are you sure you want to sign out?",
      confirmationTitle: "Yes :(",
      cancelTitle: "No :)",
    );
    if (response.confirmed) await _auth.signOut();
  }
}
