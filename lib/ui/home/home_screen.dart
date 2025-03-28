import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';
import 'package:flutter_submission_2/provider/list/restaurant_list_provider.dart';
import 'package:flutter_submission_2/static/navigation_route.dart';
import 'package:flutter_submission_2/ui/search/restaurant_search_delegate.dart';

import '../restaurant_item_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(fetchRestaurantListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant"),
        actions: [
          IconButton(
            onPressed: () async {
              final restaurant = await showSearch(
                context: context,
                delegate: RestaurantSearchDelegate(),
              );
              if (restaurant is RestaurantListItem && context.mounted) {
                Navigator.of(context).pushNamed(
                  NavigationRoute.details.routeName,
                  arguments: restaurant,
                );
              }
            },
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.of(
                context,
              ).pushNamed(NavigationRoute.goToList.routeName);
            },
            icon: Icon(Icons.playlist_play),
          ),
        ],
      ),
      body: state.when(
        data:
            (restaurants) => ListView.builder(
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
        error: (error, stackTrace) {
          print(stackTrace);

          return Center(
            child: FilledButton(
              onPressed: () {
                ref.invalidate(fetchRestaurantListProvider);
              },
              child: Text("Retry"),
            ),
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
