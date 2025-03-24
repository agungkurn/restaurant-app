import 'dart:convert';

import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';

class RestaurantListResponse {
  final bool error;
  final String message;
  final int count;
  final List<RestaurantListItem> restaurants;

  RestaurantListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestaurantListResponse.fromRawJson(String str) =>
      RestaurantListResponse.fromJson(json.decode(str));

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantListResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<RestaurantListItem>.from(
          json["restaurants"].map((x) => RestaurantListItem.fromJson(x)),
        ),
      );
}
