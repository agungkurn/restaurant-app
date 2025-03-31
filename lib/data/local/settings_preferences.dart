import 'package:flutter_submission_2/data/local/theme_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPreferences {
  final _asyncPref = SharedPreferencesAsync();

  Future<ThemeOptions> getTheme() async {
    final name = await _asyncPref.getString(KEY_THEME);
    return name == null ? ThemeOptions.system : ThemeOptions.find(name);
  }

  void setTheme(ThemeOptions value) async {
    await _asyncPref.setString(KEY_THEME, value.name);
  }

  static const KEY_THEME = "pref:theme";
}
