import 'package:shared_preferences/shared_preferences.dart';
class Preference {
  SharedPreferences? prefs;

  Preference(this.prefs);

  Future setString(String key, String value) async {
    await prefs?.setString(key, value);
  }

  Future<void> setInt(String key, int value) async {
    await prefs?.setInt(key, value);
  }

  Future<void> setDouble(String key, double value) async {
    await prefs?.setDouble(key, value);
  }

  Future<void> setBool(String key, bool value) async {
    await prefs?.setBool(key, value);
  }

  String? getString(String key, {String? def}) {
    String? val;
    val ??= prefs?.getString(key);
    val ??= def;
    return val;
  }

  int? getInt(String key, {int? def}) {
    int? val;
    val ??= prefs?.getInt(key);
    val ??= def;
    return val;
  }

  double? getDouble(String key, {double? def}) {
    double? val;
    val ??= prefs?.getDouble(key);
    val ??= def;
    return val;
  }

  bool? getBool(String key) {
    bool? val;
    val = prefs?.getBool(key);
    return val;
  }

  Future<bool> remove(String key) async {
    await prefs?.remove(key);
    return true;
  }

  Future<bool> clear() async {
    await prefs?.clear();
    return true;
  }
}
