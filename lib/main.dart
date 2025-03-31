import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';
import 'package:flutter_submission_2/provider/settings/theme_settings.dart';
import 'package:flutter_submission_2/static/navigation_route.dart';
import 'package:flutter_submission_2/style/theme/restaurant_theme.dart';
import 'package:flutter_submission_2/ui/details/details_screen.dart';
import 'package:flutter_submission_2/ui/go_to_list/go_to_list_screen.dart';
import 'package:flutter_submission_2/ui/home/home_screen.dart';
import 'package:flutter_submission_2/ui/settings/settings_screen.dart';

void main() {
  runApp(ProviderScope(child: const RestaurantApp()));
}

class RestaurantApp extends ConsumerWidget {
  const RestaurantApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref
        .watch(themeSettingsProvider)
        .maybeWhen(
          data: (themeOptions) => themeOptions.themeMode,
          orElse: () => ThemeMode.system,
        );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final systemNavigationBarColor = switch (themeMode) {
        ThemeMode.system =>
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Colors.black
              : Colors.white,
        ThemeMode.light => Colors.white,
        ThemeMode.dark => Colors.black,
      };
      final systemNavigationBarIconBrightness = switch (themeMode) {
        ThemeMode.system =>
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? Brightness.light
              : Brightness.dark,
        ThemeMode.light => Brightness.dark,
        ThemeMode.dark => Brightness.light,
      };

      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarColor: systemNavigationBarColor,
          systemNavigationBarIconBrightness: systemNavigationBarIconBrightness,
        ),
      );
    });

    return MaterialApp(
      title: 'Restaurant',
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode: themeMode,
      initialRoute: NavigationRoute.home.routeName,
      routes: {
        NavigationRoute.home.routeName: (context) => const HomeScreen(),
        NavigationRoute.details.routeName:
            (context) => DetailsScreen(
              restaurantListItem:
                  ModalRoute.of(context)?.settings.arguments
                      as RestaurantListItem,
            ),
        NavigationRoute.goToList.routeName: (context) => const GoToListScreen(),
        NavigationRoute.settings.routeName: (context) => const SettingsScreen(),
      },
    );
  }
}
