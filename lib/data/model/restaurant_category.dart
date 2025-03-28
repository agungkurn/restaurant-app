import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_category.freezed.dart';
part 'restaurant_category.g.dart';

@freezed
abstract class RestaurantCategory with _$RestaurantCategory {
  factory RestaurantCategory({required String name}) = _RestaurantCategory;

  factory RestaurantCategory.fromRawJson(String str) =>
      RestaurantCategory.fromJson(json.decode(str));

  factory RestaurantCategory.fromJson(Map<String, dynamic> json) =>
      _$RestaurantCategoryFromJson(json);
}
