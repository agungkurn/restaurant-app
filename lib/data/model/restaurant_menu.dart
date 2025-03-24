import 'dart:convert';

import 'drink.dart';
import 'food.dart';

class RestaurantMenu {
  final List<Food> foods;
  final List<Drink> drinks;

  RestaurantMenu({required this.foods, required this.drinks});

  factory RestaurantMenu.fromRawJson(String str) =>
      RestaurantMenu.fromJson(json.decode(str));

  factory RestaurantMenu.fromJson(Map<String, dynamic> json) => RestaurantMenu(
    foods: List<Food>.from(json["foods"].map((x) => Food.fromJson(x))),
    drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
  );
}
