import 'package:flutter/material.dart';
import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';
import 'package:flutter_submission_2/provider/restaurant_list_provider.dart';
import 'package:flutter_submission_2/static/navigation_route.dart';
import 'package:flutter_submission_2/static/ui_state.dart';
import 'package:flutter_submission_2/ui/search/restaurant_search_delegate.dart';
import 'package:provider/provider.dart';

import '../../provider/search_restaurant_provider.dart';
import '../restaurant_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<RestaurantListProvider>().fetch();
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text("Restaurant"),
      actions: [
        IconButton(
          onPressed: () async {
            context.read<SearchRestaurantProvider>().resetState();

            final restaurant = await showSearch(
              context: context,
              delegate: RestaurantSearchDelegate(),
            );
            if (restaurant is RestaurantListItem && context.mounted) {
              Navigator.of(context).pushNamed(
                NavigationRoute.details.routeName,
                arguments: restaurant.id,
              );
            }
          },
          icon: Icon(Icons.search),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context).pushNamed(NavigationRoute.goToList.routeName);
          },
          icon: Icon(Icons.playlist_play),
        ),
      ],
    ),
    body: Column(
      children: [
        Consumer<RestaurantListProvider>(
          builder:
              (context, value, child) => switch (value.uiState) {
                Loading() => Expanded(
                  child: Center(child: CircularProgressIndicator()),
                ),
                Success<List<RestaurantListItem>>(data: var restaurants) =>
                  Expanded(
                    child: ListView.builder(
                      itemCount: restaurants.length,
                      itemBuilder:
                          (context, i) =>
                              RestaurantItemWidget(context, restaurants[i], () {
                                Navigator.of(context).pushNamed(
                                  NavigationRoute.details.routeName,
                                  arguments: restaurants[i],
                                );
                              }),
                    ),
                  ),
                Error(errorMessage: var msg) => Expanded(
                  child: Center(child: Text(msg)),
                ),
                _ => SizedBox(),
              },
        ),
      ],
    ),
  );
}
