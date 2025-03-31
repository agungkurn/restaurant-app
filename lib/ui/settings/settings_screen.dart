import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_submission_2/data/local/theme_options.dart';
import 'package:flutter_submission_2/provider/settings/theme_settings.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeOptions = ref
        .watch(themeSettingsProvider)
        .maybeWhen(
          data: (selectedTheme) => selectedTheme,
          orElse: () => ThemeOptions.system,
        );
    final providerNotifier = ref.read(themeSettingsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: ListView(
        children: [
          ListTile(
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
          ),
        ],
      ),
    );
  }

  Widget RadioSettings<T>(
    T value,
    T selectedValue,
    String label,
    Function() onSelected,
  ) => ListTile(
    leading: Radio(
      value: value,
      groupValue: selectedValue,
      onChanged: (value) {
        if (value != null) onSelected();
      },
    ),
    title: Text(label),
    onTap: onSelected,
  );
}
