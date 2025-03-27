import 'package:flutter/material.dart';
import 'package:flutter_submission_2/data/api/api_services.dart';
import 'package:flutter_submission_2/data/local/local_database_services.dart';
import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';
import 'package:flutter_submission_2/provider/go_to_list_provider.dart';
import 'package:flutter_submission_2/provider/restaurant_details_provider.dart';
import 'package:flutter_submission_2/provider/restaurant_list_provider.dart';
import 'package:flutter_submission_2/provider/search_restaurant_provider.dart';
import 'package:flutter_submission_2/static/navigation_route.dart';
import 'package:flutter_submission_2/style/theme/restaurant_theme.dart';
import 'package:flutter_submission_2/ui/details/details_screen.dart';
import 'package:flutter_submission_2/ui/go_to_list/go_to_list_screen.dart';
import 'package:flutter_submission_2/ui/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => ApiServices()),
        Provider(create: (context) => LocalDatabaseServices()),
        ChangeNotifierProvider(
          create:
              (context) => RestaurantListProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create:
              (context) =>
                  RestaurantDetailsProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create:
              (context) =>
                  SearchRestaurantProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create:
              (context) =>
                  GoToListProvider(context.read<LocalDatabaseServices>()),
        ),
      ],
      child: const RestaurantApp(),
    ),
  );
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
