import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_submission_2/data/local/theme_options.dart';
import 'package:flutter_submission_2/provider/settings/reminder_settings.dart';
import 'package:flutter_submission_2/provider/settings/theme_settings.dart';

import '../../provider/notification/local_notification.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        AppThemeSettings(context, ref),
        ReminderSettings(context, ref),
      ],
    );
  }

  ListTile AppThemeSettings(BuildContext context, WidgetRef ref) {
    final themeOptions = ref
        .watch(themeSettingsProvider)
        .maybeWhen(
          data: (selectedTheme) => selectedTheme,
          orElse: () => ThemeOptions.system,
        );
    final providerNotifier = ref.read(themeSettingsProvider.notifier);

    return ListTile(
      title: Text("App theme"),
      subtitle: Text(themeOptions.displayName),
      onTap: () async {
        final newTheme = await showDialog<ThemeOptions>(
          context: context,
          builder:
              (context) => SimpleDialog(
                title: Text("App theme"),
                children:
                    providerNotifier
                        .getAllThemes()
                        .map(
                          (element) => SimpleDialogOption(
                            child: Text(element.displayName),
                            onPressed: () {
                              Navigator.pop(context, element);
                            },
                          ),
                        )
                        .toList(),
              ),
        );
        if (newTheme != null) await providerNotifier.setTheme(newTheme);
      },
    );
  }

  SwitchListTile ReminderSettings(BuildContext context, WidgetRef ref) {
    final reminderProvider = ref.watch(reminderSettingsProvider);
    final reminderEnabled = reminderProvider.maybeWhen(
      data: (enabled) => enabled,
      orElse: () => false,
    );
    final reminderSettingsNotifier = ref.read(
      reminderSettingsProvider.notifier,
    );

    return SwitchListTile(
      value: reminderEnabled,
      onChanged: (enabled) async {
        await reminderSettingsNotifier.toggle();

        if (enabled) {
          ref.read(localNotificationProvider.notifier).scheduleNotification();
        } else {
          ref.read(localNotificationProvider.notifier).cancelNotification();
        }
      },
      title: Text("Daily Reminder"),
      subtitle: Text(
        reminderEnabled
            ? "You will get daily reminder on 11:00"
            : "Daily reminder turned off",
      ),
    );
  }
}
