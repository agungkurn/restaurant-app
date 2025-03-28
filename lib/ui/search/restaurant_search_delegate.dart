import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_submission_2/provider/search/search_restaurant_provider.dart';

class RestaurantSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) =>
      query.isNotEmpty
          ? [
            IconButton(
              onPressed: () {
                query = "";
              },
              icon: Icon(Icons.clear),
            ),
          ]
          : null;

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    onPressed: () {
      close(context, null);
    },
    icon: Icon(Icons.arrow_back),
  );

  @override
  Widget buildSuggestions(BuildContext context) => Consumer(
    builder: (_, ref, _) {
      final state = ref.watch(searchRestaurantProvider);
      ref.read(searchRestaurantProvider.notifier).search(query);

      return state.when(
            data:
                (restaurants) =>
                ListView.builder(
              itemCount: restaurants.length,
              itemBuilder:
                  (context, i) => ListTile(
                    title: Text(restaurants[i].name),
                    subtitle: Text(restaurants[i].city),
                    onTap: () {
                      close(context, restaurants[i]);
                    },
                  ),
            ),
        error:
            (e, stack) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("An error occurred"),
                FilledButton(
                  onPressed: () {
                    ref.invalidate(searchRestaurantProvider);
                  },
                  child: Text("Retry"),
                ),
              ],
            ),
        loading: () => Center(child: CircularProgressIndicator()),
      );
    },
  );

  @override
  Widget buildResults(BuildContext context) => Consumer(
    builder: (_, ref, _) {
      final state = ref.watch(searchRestaurantProvider);

      return state.when(
        data:
            (restaurants) => ListView.builder(
              itemCount: restaurants.length,
              itemBuilder:
                  (context, i) => ListTile(
                    title: Text(restaurants[i].name),
                    subtitle: Text(restaurants[i].city),
                    onTap: () {
                      close(context, restaurants[i]);
                    },
                  ),
            ),
        error:
            (e, stack) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("An error occurred"),
                FilledButton(
                  onPressed: () {
                    ref.invalidate(searchRestaurantProvider);
                  },
                  child: Text("Retry"),
                ),
              ],
            ),
        loading: () => Center(child: CircularProgressIndicator()),
      );
    },
  );
}
