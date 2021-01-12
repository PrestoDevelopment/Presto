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
import 'package:presto_mobile/core/viewmodels/base_model.dart';
import 'package:presto_mobile/locator.dart';

class SignUpModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final DialogService _dialogService = locator<DialogService>();
  final FireStoreService _firestoreService = locator<FireStoreService>();
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

  Future signup(
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

      setBusy(false);
      //Complete SignUp by showing error or going to different page;
      if (result is bool) {
        if (result)
          _navigationService.navigateTo(HomeViewRoute, true);
        else {
          print(result);
          await _dialogService.showDialog(
            title: "Error",
            description: "General SignUp Failure",
          );
        }
      } else {
        print("error");
        if (result is FirebaseAuthException) {
          print("exceeptiom");
          generalError = result.message;
        } else {
          generalError = result.toString();
        }
      }
    }
    setBusy(false);
    _dialogService.showDialog(
        title: 'Error',
        description: emailError +
            "\n" +
            passError +
            "\n" +
            nameError +
            "\n" +
            contactError +
            "\n" +
            referralCodeError +
            "\n" +
            deviceIdError +
            "\n" +
            generalError);
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
    }
  }

  Future<bool> emailValidator(String value) async {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value.trim())) {
      emailError = 'Enter Valid Email';
      return false;
    }
    return true;
  }

  Future<bool> passValidator(String value) async {
    print("Pwd Validation started");
    if (value.length < 6) {
      passError = 'Password must be longer than 6 characters';
      return false;
    }
    print("Pwd Validation Completed");
    return true;
  }

  Future<bool> contactValidator(String value) async {
    print("Contact Validation started");
    if (value.isEmpty) {
      contactError = 'Contact can\'t be empty';
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
      return false;
    }
    if (value.length < 3) {
      nameError = 'Enter a valid username ';
      return false;
    }

    print("Name Validation Completed");
    return true;
  }

  Future<bool> parentReferralCodeValidator(String value) async {
    if (value == null) {
      referralCodeError = 'Referral code cannot be empty';
      return false;
    }
    if (value == "CM01")
      return true;
    else {
      var result = await _firestoreService.docExists(value);
      if ((result is bool && result) || value == 'CM01')
        return true;
      else {
        if (result is PlatformException)
          referralCodeError = result.message.toString();
        else
          referralCodeError = result.toString();
        return false;
      }
    }
  }

  Future navigateToLogin() async {
    await _navigationService.navigateTo(LoginViewRoute, true);
  }
}
