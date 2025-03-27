import 'dart:convert';

import 'package:flutter_submission_2/constants/base_url_constants.dart';

class RestaurantListItem {
  final String id;
  final String name;
  final String description;
  final String picture;
  final String city;
  final double rating;

  RestaurantListItem({
    required this.id,
    required this.name,
    required this.description,
    required this.picture,
    required this.city,
    required this.rating,
  });

  factory RestaurantListItem.fromRawJson(String str) =>
      RestaurantListItem.fromJson(json.decode(str));

  factory RestaurantListItem.fromJson(Map<String, dynamic> json) =>
      RestaurantListItem(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        picture: "${Constants.baseImageSmallUrl}${json["pictureId"]}",
        city: json["city"],
        rating: json["rating"]?.toDouble(),
      );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'pictureId':
          picture.startsWith(Constants.baseImageSmallUrl)
              ? picture.substring(Constants.baseImageSmallUrl.length)
              : picture,
      'city': city,
      'rating': rating,
    };
  }
}
