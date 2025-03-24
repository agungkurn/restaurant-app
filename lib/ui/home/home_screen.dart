import 'package:flutter/material.dart';
import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';
import 'package:flutter_submission_2/provider/restaurant_list_provider.dart';
import 'package:flutter_submission_2/static/navigation_route.dart';
import 'package:flutter_submission_2/static/ui_state.dart';
import 'package:provider/provider.dart';

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Restaurant"),
                  Text(
                    "Find your own taste",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ],
              ),
              titlePadding: EdgeInsets.symmetric(vertical: 16),
            ),
          ),
          Consumer<RestaurantListProvider>(
            builder:
                (context, value, child) => switch (value.uiState) {
                  Loading() => SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  Success<List<RestaurantListItem>>(data: var restaurants) =>
                    SliverList.builder(
                      itemCount: restaurants.length,
                      itemBuilder:
                          (context, i) =>
                              RestaurantItem(context, restaurants[i], () {
                                Navigator.of(context).pushNamed(
                                  NavigationRoute.details.deeplink,
                                  arguments: restaurants[i].id,
                                );
                              }),
                    ),
                  Error(errorMessage: var msg) => SliverFillRemaining(
                    child: Center(child: Text(msg)),
                  ),
                  _ => SliverFillRemaining(),
                },
          ),
          SliverPadding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
          ),
        ],
      ),
    );
  }

  Widget RestaurantItem(
    BuildContext context,
    RestaurantListItem item,
    Function() onClick,
  ) => InkWell(
    onTap: onClick,
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            height: 80,
            margin: EdgeInsets.only(right: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(item.picture, fit: BoxFit.cover),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.location_pin, color: Colors.black54),
                    Text(
                      item.city,
                      maxLines: 1,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black54),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange),
                    Text(
                      item.rating.toString(),
                      style: Theme.of(
                        context,
                      ).textTheme.labelSmall?.copyWith(color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
