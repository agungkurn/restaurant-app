import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_submission_2/data/model/restaurant_details.dart';
import 'package:flutter_submission_2/di/api_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'restaurant_details_provider.g.dart';

@riverpod
Future<RestaurantDetails> fetchRestaurantDetails(Ref ref, String id) async {
  final apiServices = ref.read(apiServicesProvider);
  final result = await apiServices.getRestaurantDetails(id);

  if (result.error) {
    throw Exception(result.message);
  } else {
    return result.restaurant;
  }
}
