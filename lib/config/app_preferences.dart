import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  late SharedPreferences _prefs;

  AppPreferences() {
    init();
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> setString(String key, String value) {
    return _prefs.setString(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  Future<void> setInt(String key, int value) {
    return _prefs.setInt(key, value);
  }

  Future<void> clean() async {
    await _prefs.clear();
  }
}