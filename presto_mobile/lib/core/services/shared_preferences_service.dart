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
}
