import 'dart:convert';

import 'package:flutter_submission_2/data/model/restaurant_details.dart';

class RestaurantDetailsResponse {
  final bool error;
  final String message;
  final RestaurantDetails restaurant;

  RestaurantDetailsResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestaurantDetailsResponse.fromRawJson(String str) =>
      RestaurantDetailsResponse.fromJson(json.decode(str));

  factory RestaurantDetailsResponse.fromJson(Map<String, dynamic> json) =>
      RestaurantDetailsResponse(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantDetails.fromJson(json["restaurant"]),
      );
}
