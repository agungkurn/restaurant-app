import 'package:flutter_submission_2/data/local/settings_preferences.dart';
import 'package:flutter_submission_2/data/local/theme_options.dart';
import 'package:flutter_submission_2/di/local_database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_settings.g.dart';

@riverpod
class ThemeSettings extends _$ThemeSettings {
  SettingsPreferences get _settingsPreferences =>
      ref.watch(settingsPreferencesProvider);

  Future<ThemeOptions> build() async {
    return await _settingsPreferences.getTheme();
  }

  Future<void> setTheme(ThemeOptions value) async {
    _settingsPreferences.setTheme(value);
    state = await AsyncValue.guard(() => _settingsPreferences.getTheme());
  }

  List<ThemeOptions> getAllThemes() {
    return ThemeOptions.getAll();
  }
}
