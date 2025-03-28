import 'dart:convert';

import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_list_response.freezed.dart';
part 'restaurant_list_response.g.dart';

@freezed
abstract class RestaurantListResponse with _$RestaurantListResponse {
  factory RestaurantListResponse({
    required bool error,
    required String message,
    required int count,
    required List<RestaurantListItem> restaurants,
  }) = _RestaurantListResponse;

  factory RestaurantListResponse.fromRawJson(String str) =>
      RestaurantListResponse.fromJson(json.decode(str));

  factory RestaurantListResponse.fromJson(Map<String, dynamic> json) =>
      _$RestaurantListResponseFromJson(json);
}
