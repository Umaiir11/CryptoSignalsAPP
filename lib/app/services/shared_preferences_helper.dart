import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:souq_ai/app/mvvm/model/response_model/user_model.dart';

class SharedPreferencesService {
  static const String _keyDataModel = 'data_model';
  static const String _keyUserData = 'user_data';
  static const String _deviceToken = 'deviceToken';
  static const String _apiToken = 'deviceToken';

  static final logger = Logger();

  Future<void> saveDeviceToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_deviceToken, token);
  }

  Future<String?> readDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_deviceToken);
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_apiToken, token);
  }

  Future<String?> readToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_apiToken);
  }


   Future<void> saveUserData(User userData) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = json.encode(userData.toJson());
    await prefs.setString(_keyUserData, data);
  }

   Future<User?> readUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(_keyUserData);
    if (data != null) {
      Map<String, dynamic> jsonData = json.decode(data);
      return User.fromJson(jsonData);
    }
    return null;
  }

  Future<void> clearAllPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool result = await prefs.clear();
    if (result) {
      logger.i('All SharedPreferences data cleared successfully.');
    } else {
      logger.e('Failed to clear SharedPreferences data.');
    }
  }}
