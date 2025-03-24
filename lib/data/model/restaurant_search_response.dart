import 'dart:convert';

import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';

class RestaurantSearchResponse {
  final bool error;
  final int count;
  final List<RestaurantListItem> restaurants;

  RestaurantSearchResponse({
    required this.error,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantSearchResponse.fromRawJson(String str) =>
      RestaurantSearchResponse.fromJson(json.decode(str));

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantSearchResponse(
        error: json["error"],
        count: json["founded"],
        restaurants: List<RestaurantListItem>.from(
          json["restaurants"].map((x) => RestaurantListItem.fromJson(x)),
        ),
      );
}
