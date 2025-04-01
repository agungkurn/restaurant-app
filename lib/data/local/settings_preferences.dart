import 'package:flutter_submission_2/data/local/theme_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPreferences {
  final _asyncPref = SharedPreferencesAsync();

  Future<ThemeOptions> getTheme() async {
    final name = await _asyncPref.getString(KEY_THEME);
    return name == null ? ThemeOptions.system : ThemeOptions.find(name);
  }

  Future<void> setTheme(ThemeOptions value) async {
    await _asyncPref.setString(KEY_THEME, value.name);
  }

  Future<bool> reminderEnabled() async {
    return await _asyncPref.getBool(KEY_REMINDER) == true;
  }

  Future<void> enableReminder(bool value) async {
    await _asyncPref.setBool(KEY_REMINDER, value);
  }

  static const KEY_THEME = "pref:theme";
  static const KEY_REMINDER = "pref:reminder";
}
