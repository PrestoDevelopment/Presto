import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class SharedPreferencesService {
  SharedPreferences _preferences;

  Future getUserData() async {
    _preferences = await SharedPreferences.getInstance();
    try {
      var jsonData = _preferences.getString('jsonData');
      if (jsonData != null) {
        return UserModel.fromJson(jsonDecode(jsonData));
      } else
        throw PlatformException(code: "Error", message: "No JsonData");
    } catch (e) {
      if (e is PlatformException) print(e.message);
      print(e.toString());
      return "error";
    }
  }

  Future synUserData(Map<String, dynamic> userModelFromDatabase) async {
    _preferences = await SharedPreferences.getInstance();
    try {
      _preferences.setString('jsonoData', jsonEncode(userModelFromDatabase));
      return UserModel.fromJson(userModelFromDatabase);
    } catch (e) {
      if (e is PlatformException) print(e.message);
      print(e.toString());
      return "error";
    }
  }

  Future synUserCode(String code) async {
    _preferences = await SharedPreferences.getInstance();
    try {
      _preferences.setString("code", code);
    } catch (e) {
      if (e is PlatformException) print(e.message);
      print(e.toString());
      return "error";
    }
  }

  Future getUserCode() async {
    _preferences = await SharedPreferences.getInstance();
    try {
      var code = _preferences.getString('code');
      if (code != null) {
        return code;
      } else
        throw PlatformException(code: "Error", message: "No Code");
    } catch (e) {
      if (e is PlatformException) print(e.message);
      print(e.toString());
      return "error";
    }
  }

  Future synUserEmailPass(String email, String pass) async {
    _preferences = await SharedPreferences.getInstance();
    try {
      _preferences.setString("email", email);
      _preferences.setString("pass", pass);
    } catch (e) {
      if (e is PlatformException) print(e.message);
      print(e.toString());
      return "error";
    }
  }

  Future getUserEmailPass() async {
    _preferences = await SharedPreferences.getInstance();
    try {
      var email = _preferences.getString('email');
      var pass = _preferences.getString('pass');
      if (pass != null && email != null) {
        return {
          'pass': pass,
          'email': email,
        };
      } else
        throw PlatformException(code: "Error", message: "No Email And PAss");
    } catch (e) {
      if (e is PlatformException) print(e.message);
      print(e.toString());
      return "error";
    }
  }

  Future synUserToken(String token) async {
    try {
      _preferences = await SharedPreferences.getInstance();
      _preferences.setString("token", token);
    } catch (e) {
      if (e is PlatformException) print(e.message);
      print(e.toString());
      return "error";
    }
  }

  Future getUserToken() async {
    try {
      _preferences = await SharedPreferences.getInstance();
      var token = _preferences.getString('token');
      if (token != null) {
        return token;
      } else
        throw PlatformException(code: "Error", message: "No Email And PAss");
    } catch (e) {
      if (e is PlatformException) print(e.message);
      print(e.toString());
      return "error";
    }
  }

  Future clearUserLoginData() async {
    _preferences = await SharedPreferences.getInstance();
    try {
      _preferences.remove('email');
      _preferences.remove('pass');
      _preferences.remove('token');
    } catch (e) {}
  }
}
