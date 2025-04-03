import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'food.freezed.dart';
part 'food.g.dart';

@freezed
abstract class Food with _$Food {
  factory Food({required String name}) = _Food;

  factory Food.fromRawJson(String str) => Food.fromJson(json.decode(str));

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
}
