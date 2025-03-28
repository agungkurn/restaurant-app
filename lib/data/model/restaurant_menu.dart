import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'drink.dart';
import 'food.dart';

part 'restaurant_menu.freezed.dart';
part 'restaurant_menu.g.dart';

@freezed
abstract class RestaurantMenu with _$RestaurantMenu {
  factory RestaurantMenu({
    required List<Food> foods,
    required List<Drink> drinks,
  }) = _RestaurantMenu;

  factory RestaurantMenu.fromRawJson(String str) =>
      RestaurantMenu.fromJson(json.decode(str));

  factory RestaurantMenu.fromJson(Map<String, dynamic> json) =>
      _$RestaurantMenuFromJson(json);
}
