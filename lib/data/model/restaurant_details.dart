import 'dart:convert';

import 'package:flutter_submission_2/constants/base_url_constants.dart';
import 'package:flutter_submission_2/data/model/restaurant_category.dart';
import 'package:flutter_submission_2/data/model/restaurant_menu.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'customer_review.dart';

part 'restaurant_details.freezed.dart';
part 'restaurant_details.g.dart';

@freezed
abstract class RestaurantDetails with _$RestaurantDetails {
  factory RestaurantDetails({
    required String id,
    required String name,
    required String description,
    required String city,
    required String address,
    @JsonKey(name: "pictureId", fromJson: _imageFromJson, toJson: _imageToJson)
    required String picture,
    required List<RestaurantCategory> categories,
    required RestaurantMenu menus,
    required double rating,
    required List<CustomerReview> customerReviews,
  }) = _RestaurantDetails;

  factory RestaurantDetails.fromRawJson(String str) =>
      RestaurantDetails.fromJson(json.decode(str));

  factory RestaurantDetails.fromJson(Map<String, dynamic> json) =>
      _$RestaurantDetailsFromJson(json);
}

String _imageFromJson(String pictureId) =>
    "${Constants.baseImageSmallUrl}$pictureId";

String _imageToJson(String pictureUrl) {
  return pictureUrl.startsWith(Constants.baseImageSmallUrl)
      ? pictureUrl.substring(Constants.baseImageSmallUrl.length)
      : pictureUrl;
}
