import 'package:flutter/material.dart';

import '../../data/model/restaurant_list_item.dart';
import '../../static/navigation_route.dart';
import '../search/restaurant_search_delegate.dart';

AppBar HomeScreenAppBar(BuildContext context) => AppBar(
  title: Text("Home"),
  actions: [
    IconButton(
      onPressed: () async {
        final restaurant = await showSearch(
          context: context,
          delegate: RestaurantSearchDelegate(),
        );
        if (restaurant is RestaurantListItem && context.mounted) {
          Navigator.of(
            context,
          ).pushNamed(NavigationRoute.details.routeName, arguments: restaurant);
        }
      },
      icon: Icon(Icons.search),
    ),
  ],
);
