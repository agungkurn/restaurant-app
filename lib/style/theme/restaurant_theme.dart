import 'package:flutter/material.dart';

import '../typography/restaurant_text_styles.dart';

class RestaurantTheme {
  static TextTheme get _textTheme => TextTheme(
    displayLarge: RestaurantTextStyles.displayLarge,
    displayMedium: RestaurantTextStyles.displayMedium,
    displaySmall: RestaurantTextStyles.displaySmall,
    headlineLarge: RestaurantTextStyles.headlineLarge,
    headlineMedium: RestaurantTextStyles.headlineMedium,
    headlineSmall: RestaurantTextStyles.headlineSmall,
    titleLarge: RestaurantTextStyles.titleLarge,
    titleMedium: RestaurantTextStyles.titleMedium,
    titleSmall: RestaurantTextStyles.titleSmall,
    bodyLarge: RestaurantTextStyles.bodyLargeBold,
    bodyMedium: RestaurantTextStyles.bodyLargeMedium,
    bodySmall: RestaurantTextStyles.bodyLargeRegular,
    labelLarge: RestaurantTextStyles.labelLarge,
    labelMedium: RestaurantTextStyles.labelMedium,
    labelSmall: RestaurantTextStyles.labelSmall,
  );

  static AppBarTheme get _appBarTheme => AppBarTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomRight: Radius.circular(16),
        bottomLeft: Radius.circular(16),
      ),
    ),
  );

  static ThemeData get lightTheme => ThemeData(
    colorSchemeSeed: Colors.red,
    appBarTheme: _appBarTheme,
    brightness: Brightness.light,
    useMaterial3: true,
    textTheme: _textTheme,
  );

  static ThemeData get darkTheme => ThemeData(
    colorSchemeSeed: Colors.red,
    appBarTheme: _appBarTheme,
    brightness: Brightness.dark,
    useMaterial3: true,
    textTheme: _textTheme,
  );
}
