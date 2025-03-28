import 'dart:async';

import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';
import 'package:flutter_submission_2/di/api_service_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_restaurant_provider.g.dart';

@riverpod
class SearchRestaurant extends _$SearchRestaurant {
  String _lastQuery = "";
  Timer? _debounce;

  Future<List<RestaurantListItem>> build() async {
    return [];
  }

  Future<void> search(String query) async {
    if (query.trim().isEmpty || query.trim() == _lastQuery) return;

    _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: 300), () async {
      state = AsyncValue.loading();

      // using try-catch instead of Async.guard()
      // to prevent race condition
      try {
        final apiService = ref.read(apiServicesProvider);
        final result = await apiService.searchRestaurant(query);

        if (query == _lastQuery) {
          state = AsyncValue.data(result.restaurants);
        }
      } catch (e, stack) {
        state = AsyncValue.error(e, stack);
      }
    });

    _lastQuery = query;
  }
}
