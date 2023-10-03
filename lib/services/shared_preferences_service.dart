import 'package:shared_preferences/shared_preferences.dart';

enum STORAGE_KEYS {
  USERNAME_KEY,
  ALTURA_KEY
}

class SharedPreferencesService {
  Future<void> setUsername(String value) async {
    await _setString(STORAGE_KEYS.USERNAME_KEY.toString(), value);
  }

  Future<String> getUsername() async {
    return _getString(STORAGE_KEYS.USERNAME_KEY.toString());
  }

  Future<void> setAltura(double value) async {
    await _setDouble(STORAGE_KEYS.ALTURA_KEY.toString(), value);
  }

  Future<double> getAltura() async {
    return _getDouble(STORAGE_KEYS.ALTURA_KEY.toString());
  }

  Future<void> _setString(String key, String value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setString(key, value);
  }

  Future<String> _getString(String key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(key) ?? "";
  }

  Future<void> _setDouble(String key, double value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setDouble(key, value);
  }

  Future<double> _getDouble(String key) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getDouble(key) ?? 0;
  }
}