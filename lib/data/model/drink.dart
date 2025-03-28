import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'drink.freezed.dart';
part 'drink.g.dart';

@freezed
abstract class Drink with _$Drink {
  factory Drink({required String name}) = _Drink;

  factory Drink.fromRawJson(String str) => Drink.fromJson(json.decode(str));

  factory Drink.fromJson(Map<String, dynamic> json) => _$DrinkFromJson(json);
}
