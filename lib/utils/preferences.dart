import 'package:ercomerce_app/configs/preferences.dart';

class UtilPreferences {
  static Future<bool> clear() {
    return Preferences.instance!.clear();
  }

  static bool containsKey(String key) {
    return Preferences.instance!.containsKey(key);
  }

  static dynamic get(String key) {
    return Preferences.instance!.get(key);
  }

  static bool getBool(String key) {
    final value = Preferences.instance!.getBool(key);
    if (value == null) {
      return false;
    } else {
      return value;
    }
  }

  static bool getBoolDef(String key, bool def) {
    final value = Preferences.instance!.getBool(key);
    if (value == null) {
      return def;
    } else {
      return value;
    }
  }

  static double? getDouble(String key) {
    return Preferences.instance!.getDouble(key);
  }

  static int? getInt(String key) {
    return Preferences.instance!.getInt(key);
  }

  static Set<String> getKeys() {
    return Preferences.instance!.getKeys();
  }

  static String? getString(String key) {
    try {
      return Preferences.instance!.getString(key);
    } catch (e) {
      print('GET STRING ERROR $e');
      return null;
    }
  }

  static List<String>? getStringList(String key) {
    return Preferences.instance!.getStringList(key);
  }

  static Future<void> reload() {
    return Preferences.instance!.reload();
  }

  static Future<bool> remove(String key) {
    return Preferences.instance!.remove(key);
  }

  static Future<bool> setBool(String key, bool value) {
    return Preferences.instance!.setBool(key, value);
  }

  static Future<bool> setDouble(String key, double value) {
    return Preferences.instance!.setDouble(key, value);
  }

  static Future<bool> setInt(String key, int value) {
    return Preferences.instance!.setInt(key, value);
  }

  static Future<bool> setString(String key, String value) {
    return Preferences.instance!.setString(key, value);
  }

  static Future<bool> setStringList(String key, List<String> value) {
    return Preferences.instance!.setStringList(key, value);
  }

  ///Singleton factory
  static final _instance = UtilPreferences._internal();

  factory UtilPreferences() {
    return _instance;
  }

  UtilPreferences._internal();
}
