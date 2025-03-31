import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_submission_2/ui/home/home_screen_app_bar.dart';
import 'package:flutter_submission_2/ui/saved_places/saved_places_app_bar.dart';
import 'package:flutter_submission_2/ui/settings/settings_app_bar.dart';

import '../../provider/main/navigation_bar_index.dart';
import '../home/home_screen.dart';
import '../saved_places/saved_places.dart';
import '../settings/settings_screen.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationBarIndex = ref.watch(navigationBarIndexProvider);
    final navigationBarIndexNotifier = ref.read(
      navigationBarIndexProvider.notifier,
    );

    return Scaffold(
      appBar: switch (navigationBarIndex) {
        0 => HomeScreenAppBar(context),
        1 => SavedPlacesAppBar(context, ref),
        2 => SettingsAppBar(),
        _ => null,
      },
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationBarIndex,
        onDestinationSelected: (i) {
          navigationBarIndexNotifier.move(i);
        },
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(
            icon: Icon(Icons.location_pin),
            label: "Saved Places",
          ),
          NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
      body: switch (navigationBarIndex) {
        0 => HomeScreen(),
        1 => SavedPlacesScreen(),
        2 => SettingsScreen(),
        _ => Placeholder(),
      },
    );
  }
}
