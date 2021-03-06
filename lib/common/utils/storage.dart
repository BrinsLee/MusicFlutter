import 'dart:convert';

import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Created by lipeilin
/// on 2021/2/13
/// 本地存储
/// 单例 StorageUtil().getItem('key')
class StorageUtil {
  static final StorageUtil _singleton = new StorageUtil._internal();
   LocalStorage _storage;

  factory StorageUtil() => _singleton;
  static SharedPreferences _prefs;

  StorageUtil._internal();

  static Future<void> init() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
  }

  dynamic getJSON(String key) {
    String jsonString = _prefs.getString(key);
    return jsonString == null ? null : jsonDecode(jsonString);
  }

  Future<bool> setJSON(String key, dynamic value) {
    String jsonStr = jsonEncode(value);
    return _prefs.setString(key, jsonStr);
  }

  String getItem(String key) {
    return _storage.getItem(key);
  }

  Future<void> setItem(String key, String val) async {
    await _storage.setItem(key, val);
  }

  Future<bool> remove(String key) {
    return _prefs.remove(key);
  }

  Future<bool> setBool(String key, bool val) {
    return _prefs.setBool(key, val);
  }

  bool getBool(String key) {
    bool val = _prefs.getBool(key);
    return val == null ? false : val;
  }
}
