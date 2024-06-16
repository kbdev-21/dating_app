import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  Future<void> write(String key, String content) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, content);
  }

  Future<String> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key) ?? 'error';
  }

  Future<void> delete(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  Future<void> deleteAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
