import 'package:flutter/material.dart';

enum ThemeOptions {
  system("system", "System default", ThemeMode.system),
  dark("dark", "Dark", ThemeMode.dark),
  light("light", "Light", ThemeMode.light);

  const ThemeOptions(this.name, this.displayName, this.themeMode);

  final String name;
  final String displayName;
  final ThemeMode themeMode;

  static List<ThemeOptions> getAll() => List.unmodifiable([
    ThemeOptions.system,
    ThemeOptions.dark,
    ThemeOptions.light,
  ]);

  static ThemeOptions find(String name) => ThemeOptions.values.firstWhere(
    (element) => element.name == name,
    orElse: () => ThemeOptions.system,
  );
}
