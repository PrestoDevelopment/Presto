import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:presto_mobile/core/models/user_model.dart';

class FirestoreService {
  final CollectionReference _userCollectionReference =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _limitCollectionReference =
      FirebaseFirestore.instance.collection('limits');

  Future createUser(UserModel userModel) async {
    try {
      print("creating User document in database");
      await _userCollectionReference
          .doc(userModel.referralCode)
          .set(userModel.toJson());
    } catch (e) {
      return e.message;
    }
  }

  //this validdates the parent referral code;
  Future docExists(String code) async {
    try {
      var result = await _userCollectionReference.doc(code).get();
      var limits = await _limitCollectionReference.doc('limits').get();
      if (result == null) {
        return false;
      } else {
        //implement changes here
        UserModel parent = UserModel.fromJson(result?.data());
        if (parent.referredTo.length > limits.data()['refereeLimit'])
          return "Referee limit reached";
        return true;
      }
    } catch (e) {
      print(e.toString());
      return e;
    }
  }

  Future parentDocUpdate(String code, String child) async {
    var result = await _userCollectionReference.doc(code).get();
    UserModel parent = UserModel.fromJson(result?.data());
    parent.referredTo.add(child);
    _userCollectionReference.doc(code).update(parent.toJson());
  }

  Future getUser(String code) async {
    try {
      print("getting Data about user");
      var data = await _userCollectionReference.doc(code).get();
      if (data.exists) return UserModel.fromJson(data.data());
      return PlatformException(
        message: "User Dont Exist",
        code: null,
      );
    } catch (e) {
      if (e is PlatformException) return e.message;
      return e.toString();
    }
  }
}
