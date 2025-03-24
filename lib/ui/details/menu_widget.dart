import 'package:flutter/material.dart';
import 'package:flutter_submission_2/data/model/restaurant_menu.dart';

class RestaurantMenuWidget extends StatelessWidget {
  final RestaurantMenu restaurantMenu;

  const RestaurantMenuWidget({super.key, required this.restaurantMenu});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Foods (${restaurantMenu.foods.length})",
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          ...restaurantMenu.foods.map((e) => Text(e.name)),
          SizedBox(height: 16),
          Text(
            "Beverages (${restaurantMenu.drinks.length})",
            style: Theme.of(
              context,
            ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
          ),
          ...restaurantMenu.drinks.map((e) => Text(e.name)),
        ],
      ),
    );
  }
}
