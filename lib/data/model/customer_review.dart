import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_review.freezed.dart';
part 'customer_review.g.dart';

@freezed
abstract class CustomerReview with _$CustomerReview {
  factory CustomerReview({
    required String name,
    required String review,
    required String date,
  }) = _CustomerReview;

  factory CustomerReview.fromRawJson(String str) =>
      CustomerReview.fromJson(json.decode(str));

  factory CustomerReview.fromJson(Map<String, dynamic> json) =>
      _$CustomerReviewFromJson(json);
}
