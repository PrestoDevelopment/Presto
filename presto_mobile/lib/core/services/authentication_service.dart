import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:presto_mobile/core/models/dialog_model.dart';
import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/locator.dart';

import '../models/user_model.dart';

class AuthenticationService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Connectivity connectivity = Connectivity();

  // final AnalyticsService _analyticsService = locator<AnalyticsService>();
  final DialogService _dialogService = locator<DialogService>();
  final FireStoreService _fireStoreService = FireStoreService();

  UserModel _currentUser;

  UserModel get currentUser => _currentUser;

  //LogIn  Part

  String retrieveCode() {
    return _auth.currentUser.displayName;
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
      else if (authResult is UserCredential)
        result = await _populateCurrentUser(authResult, true);
      return result;
    } catch (e) {
      print("Theres an error in logging In");
      return e;
    }
  }

  Future signUp(UserModel user, String pass) async {
    try {
      _currentUser = user;
      print("Signing in");
      var authResult = await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: pass,
      );
      if (user.referredBy == "CM01") {
        print("signing a community manager underling");
        return await _populateCurrentUser(authResult, false);
      } else
        await _fireStoreService.parentDocUpdate(
            user.referredBy, user.referralCode);
      return await _populateCurrentUser(authResult, false);
    } catch (e) {
      return e;
    }
  }

  Future _populateCurrentUser(var cred, bool isLogIn) async {
    print("populating user");
    print(cred.runtimeType);
    print(isLogIn);
    if (cred is FirebaseAuthException) return cred.message;
    if (cred is String) return cred;
    if (cred != null) {
      //return true after setting up user in database
      if (isLogIn) {
        try {
          _currentUser = await _fireStoreService.getUser(cred.user.displayName);
          // userController.add(_currentUser);
          print("Completed populating user");
          return true;
        } catch (e) {
          print("theres an error here");
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
      await _auth.signOut();
      return true;
    }
    return false;
  }
}
