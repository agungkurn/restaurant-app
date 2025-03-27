import 'package:flutter/foundation.dart';
import 'package:flutter_submission_2/data/local/local_database_services.dart';
import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';

class GoToListProvider extends ChangeNotifier {
  final LocalDatabaseServices _databaseServices;

  GoToListProvider(this._databaseServices);

  List<RestaurantListItem> _restaurants = [];

  List<RestaurantListItem> get restaurants => _restaurants;

  bool isInList(String id) {
    return restaurants.any((element) => element.id == id);
  }

  Future<void> getGoToList() async {
    try {
      _restaurants = await _databaseServices.getAllItems();
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future<void> addToList(RestaurantListItem item) async {
    try {
      final id = await _databaseServices.insert(item);
      if (id == 0) print("error saving ${item.name}");
    } catch (e) {
      print(e.toString());
    }

    await getGoToList();
  }

  Future<void> removeFromList(String id) async {
    try {
      await _databaseServices.remove(id);
    } catch (e) {
      print(e.toString());
    }

    await getGoToList();
  }
}
