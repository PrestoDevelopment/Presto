import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:presto_mobile/core/models/user_model.dart';

import '../models/user_model.dart';

// ignore: camel_case_types
class FireStoreService {
  final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _limitCollectionReference =
      FirebaseFirestore.instance.collection('limits');

  // final SharedPreferencesService _sharedPreferencesService =
  //     SharedPreferencesService();
  Future createUser(UserModel userModel) async {
    try {
      print("creating User document in database");
      print(userModel.toJson());
      await _userCollectionReference
          .doc(userModel.referralCode)
          .set(userModel.toJson());

      // await _sharedPreferencesService.synUserData(userModel.toJson());
      print(
          "New User Document created in Database and saved in Shared Preferences");
    } catch (e) {
      print("Getting error here!!!!!!!!!! plsss someone watch");
      print(e.toString());
      if (e is PlatformException)
        return e.message;
      else
        return e.toString();
    }
  }

  //this validdates the parent referral code;
  Future docExists(String code) async {
    try {
      var result = await _userCollectionReference.doc(code).get();
      var limits = await _limitCollectionReference.doc('limits').get();
      if (result == null || limits == null) {
        return false;
      } else {
        //implement changes here
        UserModel parent = UserModel.fromJson(result?.data());
        var parentDoc = parent.referredTo?.length;
        int limitOfReferee = limits.data()['refereeLimit'];
        if (parentDoc is int && parentDoc > limitOfReferee) {
          print("error in checking limit");
          return "Referee limit reached";
        }
        return true;
      }
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  Future parentDocUpdate(String code, String child) async {
    var result = await _userCollectionReference.doc(code).get();
    print("Getting parent Document");
    try {
      if (result.exists) {
        UserModel parent = UserModel.fromJson(result.data());
        print("Got parent Document : Parent Name : ${parent?.name}");
        parent.referredTo.add(child);
        _userCollectionReference.doc(code).update(parent.toJson());
        return true;
      }
    } catch (e) {
      if (e is PlatformException) {
        print("@@@@@@@@@@@@@@@@@@@");
        print(e.message);
        return e.message;
      } else {
        print("--------------------------");
        print(e.toString());
        return e.toString();
      }
    }
  }

  Future userDocUpdate(UserModel user) async {
    var result = await _userCollectionReference.doc(user.referralCode).get();
    print("Getting parent Document");
    try {
      if (result.exists) {
        _userCollectionReference.doc(user.referralCode).update(user.toJson());
        return true;
      }
    } catch (e) {
      if (e is PlatformException) {
        print("@@@@@@@@@@@@@@@@@@@");
        print(e.message);
        return e.message;
      } else {
        print("--------------------------");
        print(e.toString());
        return e.toString();
      }
    }
  }

  Future getUser(String code) async {
    try {
      print("getting Data about user");
      var data = await _userCollectionReference.doc(code).get();
      if (data.exists) {
        return UserModel.fromJson(data.data());
      } else
        return PlatformException(
          message: "User d\'ont Exist",
          code: null,
        );
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }

  Future<Map<String, dynamic>> getBorrowingLimit() async {
    try {
      print("Getting borrowing Limits");
      var limit = await _limitCollectionReference.doc('limits').get();
      print("got borrowing limits");
      return {
        "borrowUpperLimit": limit?.data()["borrowUpperLimit"].toDouble(),
        "borrowLowerLimit": limit?.data()["borrowLowerLimit"].toDouble(),
      };
    } catch (e) {
      print(e.toString());
      return {
        "borrowUpperLimit": 1000.0,
        "borrowLowerLimit": 100.0,
      };
    }
  }

  StreamController<UserModel> _userStream =
      StreamController<UserModel>.broadcast();
  StreamController _userLimits = StreamController.broadcast();

  //Streams getter functions
  Stream listenToUserDocumentRealTime(String code) {
    _userCollectionReference.doc(code).snapshots().listen((snap) {
      if (snap.exists) {
        _userStream.add(UserModel.fromJson(snap.data()));
      }
    });
    return _userStream.stream;
  }

  Stream listenToUserLimitsRealTime() {
    _limitCollectionReference.doc('limits').snapshots().listen((snap) {
      if (snap.exists) {
        _userLimits.add(snap.data());
      }
      return _userLimits.stream;
    });
  }
}
