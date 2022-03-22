import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';


class PreferenceHelper {
  static const String TOKEN = 'token';
  static const String FIRST_NAME = 'firstname';
  static const String LAST_NAME = 'lastname';
  static const String PASSWORD = 'password';
  static const String MOBILE = 'mobile';
  static const String LOCATION_ON = 'locationOn';
  static const String EMAIL = 'email';

  static Future<SharedPreferences> getInstance() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static Future<String?> getPreferenceData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static Future<Future<bool>> setPreferenceData(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<Future<bool>> setPreferenceBoolData(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future<bool?> getBoolPreferenceData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<void> clearPreferenceData(key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove(key);
  }
}
