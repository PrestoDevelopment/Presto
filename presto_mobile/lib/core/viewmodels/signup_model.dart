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
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final NavigationService _navigationService = locator<NavigationService>();

  String newReferralCode;
  String errorMessage = "";
  String deviceId;
  bool gotDeviceId = false;
  //String fcmToken;
  //bool gotFcmToken = false;
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
    var emailValidation = emailValidator(email);
    var nameValidation = nameValidator(name);
    var contactValidation = contactValidator(contact);
    var passValidation = passValidator(pass);
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
      //TODO: write a random code generator
      var result = await _authenticationService.signup(
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
      //Complete SignUp by showing error or foing to different page;
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
          await _dialogService.showDialog(
            title: "Error",
            description: result.message.toString(),
          );
        } else {
          await _dialogService.showDialog(
            title: "Error",
            description: result.toString(),
          );
        }
      }
    }
    _dialogService.showDialog(title: 'Error', description: errorMessage);
    setBusy(false);
  }

  Future<void> getDeviceId() async {
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
      gotDeviceId = true;
      //var notificationToken = await _fcm.getToken();
    } catch (e) {
      if (e is PlatformException)
        errorMessage += e.message + '\n';
      else
        errorMessage +=
            'Failed to get deviceId. \nFailed to get notificationId.\n';
    }
  }

  bool emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value.trim())) {
      errorMessage += 'Enter Valid Email\n';
      return false;
    }
    return true;
  }

  bool passValidator(String value) {
    print("Pwd Validation started");
    if (value.length < 6) {
      errorMessage += 'Password must be longer than 6 characters';
      return false;
    }
    print("Pwd Validation Completed");
    return true;
  }

  bool contactValidator(String value) {
    print("Contact Validation started");
    if (value.isEmpty) {
      errorMessage += 'Contact can\'t be empty\n';
      return false;
    }
    if (value.length < 10 || value.length > 10) {
      errorMessage += 'Enter a valid contact number\n';
      return false;
    }
    print("Contact Validation Completed");
    return true;
  }

  bool nameValidator(String value) {
    print("Name Validation started");
    if (value.isEmpty) {
      errorMessage += 'Username can\'t be empty\n';
      return false;
    }
    if (value.length < 3) {
      errorMessage += 'Enter a valid username \n';
      return false;
    }

    print("Name Validation Completed");
    return true;
  }

  Future<bool> parentReferralCodeValidator(String value) async {
    if (value == null) {
      errorMessage += 'Referral code cannot be empty\n';
      return false;
    }
    var result = await _firestoreService.docExists(value);
    if ((result is bool && result) || value == 'CM01')
      return true;
    else {
      if (result is PlatformException)
        errorMessage = errorMessage + result.message.toString() + '\n';
      else
        errorMessage = errorMessage + result.toString() + '\n';
      return false;
    }
  }

  Future navigateToLogin() async {
    await _navigationService.navigateTo(LoginViewRoute, true);
  }
}
