import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';
import 'package:flutter_submission_2/di/api_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'restaurant_list_provider.g.dart';

@riverpod
Future<List<RestaurantListItem>> fetchRestaurantList(Ref ref) async {
  final apiServices = ref.read(apiServicesProvider);

  final result = await apiServices.getRestaurantList();
  if (result.error) {
    throw Exception(result.message);
  } else {
    return result.restaurants;
  }
}
