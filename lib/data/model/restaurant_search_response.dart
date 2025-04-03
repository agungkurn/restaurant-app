import 'dart:convert';

import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_search_response.freezed.dart';
part 'restaurant_search_response.g.dart';

@freezed
abstract class RestaurantSearchResponse with _$RestaurantSearchResponse {
  factory RestaurantSearchResponse({
    required bool error,
    @JsonKey(name: "founded") required int count,
    required List<RestaurantListItem> restaurants,
  }) = _RestaurantSearchResponse;

  factory RestaurantSearchResponse.fromRawJson(String str) =>
      RestaurantSearchResponse.fromJson(json.decode(str));

  factory RestaurantSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantSearchResponseFromJson(json);
}
