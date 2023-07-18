import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferencesHelper>((ref) => throw UnimplementedError());

class SharedPreferencesHelper {
  final SharedPreferences prefs;

  SharedPreferencesHelper({required this.prefs});

  // put object
  Future<bool> putObject(String key, Map<String, dynamic> value) {
    return prefs.setString(key, json.encode(value));
  }

  // put object
  Future<bool> putObjectNew(String key, String Function() toString) {
    return prefs.setString(key, toString());
  }

  // get obj
  T getObj<T>(String key, T Function(Map<String, dynamic> v) f,
      {required T defValue}) {
    Map<String, dynamic>? map = getObject(key);
    return map == null ? defValue : f(map);
  }

  // get not null obj
  T getNotNullObj<T>(String key, T Function(Map<String, dynamic> v) f) {
    Map<String, dynamic> map = getObject(key)!;
    return f(map);
  }

  // get object
  Map<String, dynamic>? getObject(String key) {
    String? data = prefs.getString(key);
    return (data == null || data.isEmpty)
        ? null
        : json.decode(data) as Map<String, dynamic>;
  }

  // put object list
  Future<bool> putObjectList(String key, List<Object> list) {
    List<String> dataList = list.map((value) {
      return json.encode(value);
    }).toList();
    return prefs.setStringList(key, dataList);
  }

  // get obj list
  List<T> getObjList<T>(String key, T Function(Map v) f,
      {List<T> defValue = const []}) {
    List<Map>? dataList = getObjectList(key);
    List<T>? list = dataList?.map((value) {
      return f(value);
    }).toList();
    return list ?? defValue;
  }

  // get object list
  List<Map>? getObjectList(String key) {
    List<String>? dataLis = prefs.getStringList(key);
    return dataLis?.map((value) {
      Map dataMap = json.decode(value);
      return dataMap;
    }).toList();
  }

  // get string
  String getString(String key, {String defValue = ''}) {
    return prefs.getString(key) ?? defValue;
  }

  // put string
  Future<bool> putString(String key, String value) {
    return prefs.setString(key, value);
  }

  // get bool
  bool getBool(String key, {bool defValue = false}) {
    return prefs.getBool(key) ?? defValue;
  }

  // put bool
  Future<bool> putBool(String key, bool value) {
    return prefs.setBool(key, value);
  }

  // get int
  int getInt(String key, {int defValue = -1}) {
    return prefs.getInt(key) ?? defValue;
  }

  // put int.
  Future<bool> putInt(String key, int value) {
    return prefs.setInt(key, value);
  }

  // get double
  double getDouble(String key, {double defValue = -1}) {
    return prefs.getDouble(key) ?? defValue;
  }

  // put double
  Future<bool> putDouble(String key, double value) {
    return prefs.setDouble(key, value);
  }

  // get string list
  List<String> getStringList(String key, {List<String> defValue = const []}) {
    return prefs.getStringList(key) ?? defValue;
  }

  // put string list
  Future<bool> putStringList(String key, List<String> value) {
    return prefs.setStringList(key, value);
  }

  // get dynamic
  dynamic getDynamic(String key, {required Object defValue}) {
    return prefs.get(key) ?? defValue;
  }

  // have key
  bool haveKey(String key) {
    return prefs.getKeys().contains(key);
  }

  // get keys
  Set<String> getKeys() {
    return prefs.getKeys();
  }

  // remove
  Future<bool> remove(String key) {
    return prefs.remove(key);
  }

  // clear
  Future<bool> clear() {
    return prefs.clear();
  }
}
