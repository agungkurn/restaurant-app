import 'dart:convert';

class RestaurantCategory {
  final String name;

  RestaurantCategory({required this.name});

  factory RestaurantCategory.fromRawJson(String str) =>
      RestaurantCategory.fromJson(json.decode(str));

  factory RestaurantCategory.fromJson(Map<String, dynamic> json) =>
      RestaurantCategory(name: json["name"]);
}
