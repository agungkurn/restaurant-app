import 'package:flutter/material.dart';
import 'package:flutter_submission_2/data/api/api_services.dart';
import 'package:flutter_submission_2/provider/restaurant_details_provider.dart';
import 'package:flutter_submission_2/provider/restaurant_list_provider.dart';
import 'package:flutter_submission_2/static/navigation_route.dart';
import 'package:flutter_submission_2/style/theme/restaurant_theme.dart';
import 'package:flutter_submission_2/ui/details/details_screen.dart';
import 'package:flutter_submission_2/ui/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => ApiServices()),
        ChangeNotifierProvider(
          create:
              (context) => RestaurantListProvider(context.read<ApiServices>()),
        ),
        ChangeNotifierProvider(
          create:
              (context) =>
                  RestaurantDetailsProvider(context.read<ApiServices>()),
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
      initialRoute: NavigationRoute.home.deeplink,
      routes: {
        NavigationRoute.home.deeplink: (context) => const HomeScreen(),
        NavigationRoute.details.deeplink:
            (context) => DetailsScreen(
              id: ModalRoute.of(context)?.settings.arguments as String,
            ),
      },
    );
  }
}
