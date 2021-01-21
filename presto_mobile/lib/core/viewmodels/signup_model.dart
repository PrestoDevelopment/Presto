import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:presto_mobile/constants/route_names.dart';
import 'package:presto_mobile/core/models/user_model.dart';
import 'package:presto_mobile/core/services/authentication_service.dart';
import 'package:presto_mobile/core/services/dialog_service.dart';
import 'package:presto_mobile/core/services/firestore_service.dart';
import 'package:presto_mobile/core/services/navigation_service.dart';
import 'package:presto_mobile/locator.dart';
import 'package:stacked/stacked.dart';

class SignUpModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final FireStoreService _firestoreService = FireStoreService();
  final NavigationService _navigationService = locator<NavigationService>();

  String newReferralCode;
  String deviceId;
  bool gotDeviceId = false;

  //String fcmToken;
  //bool gotFcmToken = false;
  //Errors
  String emailError;
  String nameError;
  String contactError;
  String passError;
  String referralCodeError;
  String generalError;
  String deviceIdError;
  String netError = "These Are the errors \n";

  Future signUp(
    String email,
    String pass,
    String name,
    String contact,
    String parentReferralCode,
  ) async {
    setBusy(true);
    // Validate all the fields

    newReferralCode =
        name.substring(0, 3) + Random().nextInt(999999).toString();
    var emailValidation = await emailValidator(email);
    var nameValidation = await nameValidator(name);
    var contactValidation = await contactValidator(contact);
    var passValidation = await passValidator(pass);
    var referralCodeValidation =
        await parentReferralCodeValidator(parentReferralCode);
    print("Validated Data");
    await getDeviceId();
    if (emailValidation &&
        nameValidation &&
        passValidation &&
        referralCodeValidation &&
        contactValidation &&
        gotDeviceId) {
      //Begin SignUp
      var result = await _authenticationService.signUp(
        UserModel(
          contact: contact,
          email: email,
          name: name,
          referredBy: parentReferralCode,
          referralCode: newReferralCode,
          referredTo: [],
          communityScore: '0',
          personalScore: '0',
          contactVerified: false,
          emailVerified: false,
          deviceId: deviceId,
        ),
        pass,
      );
      //Complete SignUp by showing error or going to different page;
      if (result is bool) {
        if (result) {
          _navigationService.navigateTo(MainPageViewRoute, true);
          setBusy(false);
        } else {
          print(result);
          await _dialogService.showDialog(
            title: "Error",
            description: "General SignUp Failure",
          );
        }
      } else {
        print("error");
        if (result is FirebaseAuthException) {
          print("exception");
          generalError = result.message;
        } else {
          generalError = result.toString();
        }
        _dialogService.showDialog(title: 'Error', description: netError);
      }
      setBusy(false);
    }
  }

  Future<void> getDeviceId() async {
    try {
      print("Getting Device Id");
      deviceId = await PlatformDeviceId.getDeviceId;
      gotDeviceId = true;
      //var notificationToken = await _fcm.getToken();
      print("Got Device Id");
    } catch (e) {
      if (e is PlatformException)
        deviceIdError = e.message;
      else
        deviceIdError =
            'Failed to get deviceId. \nFailed to get notificationId.\n';
      try {
        netError = netError + deviceIdError + "\n";
      } catch (e) {
        print(e);
      }
    }
  }

  Future<bool> emailValidator(String value) async {
    print("Validating email");
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value.trim())) {
      emailError = 'Enter Valid Email';
      print("Error in validating email");
      try {
        netError = netError + emailError + "\n";
      } catch (e) {
        print(e);
      }
      return false;
    }
    print("Validation complete");
    return true;
  }

  Future<bool> passValidator(String value) async {
    print("Pwd Validation started");
    if (value.length < 6) {
      passError = 'Password must be longer than 6 characters';
      try {
        netError = netError + passError + "\n";
      } catch (e) {
        print(e);
      }
      return false;
    }
    print("Pwd Validation Completed");
    return true;
  }

  Future<bool> contactValidator(String value) async {
    print("Contact Validation started");
    if (value.isEmpty) {
      contactError = 'Contact can\'t be empty';
      try {
        netError = netError + contactError + "\n";
      } catch (e) {
        print(e);
      }
      return false;
    }
    if (value.length < 10 || value.length > 10) {
      contactError = 'Enter a valid contact number';
      return false;
    }
    print("Contact Validation Completed");
    return true;
  }

  Future<bool> nameValidator(String value) async {
    print("Name Validation started");
    if (value.isEmpty) {
      nameError = 'Username can\'t be empty';
      try {
        netError = netError + nameError + "\n";
      } catch (e) {
        print(e);
      }
      return false;
    }
    if (value.length < 3) {
      nameError = 'Enter a valid username ';
      try {
        netError = netError + nameError + "\n";
      } catch (e) {
        print(e);
      }
      return false;
    }

    print("Name Validation Completed");
    return true;
  }

  Future<bool> parentReferralCodeValidator(String value) async {
    print("Parent Referral COde validation Start");
    if (value == null) {
      referralCodeError = 'Referral code cannot be empty';
      try {
        netError = netError + referralCodeError + "\n";
      } catch (e) {
        print(e);
      }
      print("Parent Referral COde validation End 1");
      return false;
    }
    if (value == "CM01")
      return true;
    else {
      var result = await _firestoreService.docExists(value);
      if (value == 'CM01') {
        print("Parent Referral COde validation End 2");
        return true;
      } else if (result is bool) {
        if (result) {
          print("Parent Referral COde validation End 2*");
          return true;
        }
      } else {
        if (result is PlatformException)
          referralCodeError = result.message.toString();
        else
          referralCodeError = result.toString();
        try {
          netError = netError + referralCodeError + "\n";
        } catch (e) {
          print(e);
        }
        print("Parent Referral COde validation End 3");
        return false;
      }
    }
  }

  Future navigateToLogin() async {
    await _navigationService.navigateTo(LoginViewRoute, true);
  }
}
