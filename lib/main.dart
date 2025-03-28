import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';
import 'package:flutter_submission_2/static/navigation_route.dart';
import 'package:flutter_submission_2/style/theme/restaurant_theme.dart';
import 'package:flutter_submission_2/ui/details/details_screen.dart';
import 'package:flutter_submission_2/ui/go_to_list/go_to_list_screen.dart';
import 'package:flutter_submission_2/ui/home/home_screen.dart';

void main() {
  runApp(ProviderScope(child: const RestaurantApp()));
}

class RestaurantApp extends StatelessWidget {
  const RestaurantApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant',
      theme: RestaurantTheme.lightTheme,
      darkTheme: RestaurantTheme.darkTheme,
      themeMode: ThemeMode.system,
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
      },
    );
  }
}
