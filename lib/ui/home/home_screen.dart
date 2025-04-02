import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_submission_2/provider/list/restaurant_list_provider.dart';
import 'package:flutter_submission_2/static/navigation_route.dart';

import '../restaurant_item_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(fetchRestaurantListProvider);

    return state.when(
      data:
          (restaurants) => ListView.builder(
            itemCount: restaurants.length,
            itemBuilder:
                (listContext, i) =>
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("An error occurred"),
              FilledButton(
                onPressed: () {
                  ref.invalidate(fetchRestaurantListProvider);
                },
                child: Text("Retry"),
              ),
            ],
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
