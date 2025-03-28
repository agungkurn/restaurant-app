import 'package:flutter_submission_2/constants/base_url_constants.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'restaurant_list_item.freezed.dart';
part 'restaurant_list_item.g.dart';

@freezed
abstract class RestaurantListItem with _$RestaurantListItem {
  factory RestaurantListItem({
    required String id,
    required String name,
    required String description,
    @JsonKey(name: "pictureId", fromJson: _imageFromJson, toJson: _imageToJson)
    required String picture,
    required String city,
    required double rating,
  }) = _RestaurantListItem;

  factory RestaurantListItem.fromJson(Map<String, dynamic> json) =>
      _$RestaurantListItemFromJson(json);
}

String _imageFromJson(String pictureId) =>
    "${Constants.baseImageSmallUrl}$pictureId";

String _imageToJson(String pictureUrl) {
  return pictureUrl.startsWith(Constants.baseImageSmallUrl)
      ? pictureUrl.substring(Constants.baseImageSmallUrl.length)
      : pictureUrl;
}
