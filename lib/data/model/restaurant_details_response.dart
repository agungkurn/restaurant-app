import 'dart:convert';

import 'package:flutter_submission_2/data/model/restaurant_details.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_details_response.freezed.dart';
part 'restaurant_details_response.g.dart';

@freezed
abstract class RestaurantDetailsResponse with _$RestaurantDetailsResponse {
  factory RestaurantDetailsResponse({
    required bool error,
    required String message,
    required RestaurantDetails restaurant,
  }) = _RestaurantDetailsResponse;

  factory RestaurantDetailsResponse.fromRawJson(String str) =>
      RestaurantDetailsResponse.fromJson(json.decode(str));

  factory RestaurantDetailsResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailsResponseFromJson(json);
}
