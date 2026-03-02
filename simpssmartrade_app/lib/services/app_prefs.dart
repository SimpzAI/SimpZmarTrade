import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static const _kBackendUrl = 'backendUrl';
  static const _kRemindersEnabled = 'remindersEnabled';

  static Future<String?> getBackendUrl() async {
    final p = await SharedPreferences.getInstance();
    return p.getString(_kBackendUrl);
  }

  static Future<void> setBackendUrl(String? url) async {
    final p = await SharedPreferences.getInstance();
    if (url == null) {
      await p.remove(_kBackendUrl);
    } else {
      await p.setString(_kBackendUrl, url);
    }
  }

  static Future<bool> getRemindersEnabled() async {
    final p = await SharedPreferences.getInstance();
    return p.getBool(_kRemindersEnabled) ?? true;
  }

  static Future<void> setRemindersEnabled(bool v) async {
    final p = await SharedPreferences.getInstance();
    await p.setBool(_kRemindersEnabled, v);
  }
}
