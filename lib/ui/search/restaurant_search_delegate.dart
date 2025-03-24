import 'package:flutter/material.dart';
import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';
import 'package:flutter_submission_2/provider/search_restaurant_provider.dart';
import 'package:flutter_submission_2/static/ui_state.dart';
import 'package:provider/provider.dart';

class RestaurantSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear),
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider = context.read<SearchRestaurantProvider>();

    Future.microtask(() {
      provider.fetch(query);
    });

    return Consumer<SearchRestaurantProvider>(
      builder: (context, provider, child) {
        return switch (provider.uiState) {
          Loading() => Center(child: CircularProgressIndicator()),
          Success<List<RestaurantListItem>>(data: var restaurants) =>
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
          Error(errorMessage: var msg) => Center(child: Text(msg)),
          _ => SizedBox(),
        };
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Consumer<SearchRestaurantProvider>(
      builder:
          (context, value, child) => switch (value.uiState) {
            Loading() => Center(child: CircularProgressIndicator()),
            Success<List<RestaurantListItem>>(data: var restaurants) =>
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
            Error(errorMessage: var msg) => Center(child: Text(msg)),
            _ => SizedBox(),
          },
    );
  }
}
