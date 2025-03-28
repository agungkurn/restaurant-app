import 'package:flutter_submission_2/data/local/local_database_services.dart';
import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';
import 'package:flutter_submission_2/di/local_database_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'go_to_list_provider.g.dart';

@riverpod
class GoToList extends _$GoToList {
  LocalDatabaseServices get _db => ref.read(databaseServicesProvider);

  @override
  Future<List<RestaurantListItem>> build() async {
    return _db.getAllItems();
  }

  Future<void> addToList(RestaurantListItem item) async {
    try {
      final id = await _db.insert(item);
      if (id == 0) print("error saving ${item.name}");
    } catch (e) {
      print(e.toString());
    }

    state = await AsyncValue.guard(() => _db.getAllItems());
  }

  Future<void> removeFromList(String id) async {
    try {
      await _db.remove(id);
    } catch (e, stack) {
      print(stack);
    }

    state = await AsyncValue.guard(() => _db.getAllItems());
  }

  Future<void> removeFromListByIndices(List<int> indices) async {
    try {
      for (var i in indices) {
        final id = state.value?.elementAtOrNull(i)?.id;
        if (id != null) await _db.remove(id);
      }
    } catch (e, stack) {
      print(stack);
    }

    state = await AsyncValue.guard(() => _db.getAllItems());
  }
}
