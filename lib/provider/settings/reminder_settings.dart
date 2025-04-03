import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/local/settings_preferences.dart';
import '../../di/local_database_provider.dart';

part 'reminder_settings.g.dart';

@riverpod
class ReminderSettings extends _$ReminderSettings {
  SettingsPreferences get _settingsPreferences =>
      ref.watch(settingsPreferencesProvider);

  Future<bool> build() async {
    return await _settingsPreferences.reminderEnabled();
  }

  Future<void> toggle() async {
    final current = state.value == true;
    _settingsPreferences.enableReminder(!current);

    state = await AsyncValue.guard(
      () => _settingsPreferences.reminderEnabled(),
    );
  }
}
