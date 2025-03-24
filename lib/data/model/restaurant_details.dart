import 'dart:convert';

import 'package:flutter_submission_2/constants/base_url_constants.dart';
import 'package:flutter_submission_2/data/model/restaurant_category.dart';
import 'package:flutter_submission_2/data/model/restaurant_menu.dart';

import 'customer_review.dart';

class RestaurantDetails {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String picture;
  final List<RestaurantCategory> categories;
  final RestaurantMenu menus;
  final double rating;
  final List<CustomerReview> customerReviews;

  RestaurantDetails({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.picture,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  factory RestaurantDetails.fromRawJson(String str) =>
      RestaurantDetails.fromJson(json.decode(str));

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) =>
      RestaurantDetails(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        picture: "${Constants.baseImageLargeUrl}${json["pictureId"]}",
        categories: List<RestaurantCategory>.from(
          json["categories"].map((x) => RestaurantCategory.fromJson(x)),
        ),
        menus: RestaurantMenu.fromJson(json["menus"]),
        rating: json["rating"]?.toDouble(),
        customerReviews: List<CustomerReview>.from(
          json["customerReviews"].map((x) => CustomerReview.fromJson(x)),
        ),
      );
}
