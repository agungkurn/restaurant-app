import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_submission_2/data/api/api_services.dart';
import 'package:flutter_submission_2/static/ui_state.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  SearchRestaurantProvider(this._apiServices);

  Timer? _debounce;
  UiState _uiState = Idle();
  String lastQuery = "";

  UiState get uiState => _uiState;

  void resetState() {
    _uiState = Idle();
    _debounce = null;
    lastQuery = "";
  }

  Future<void> fetch(String query) async {
    _debounce?.cancel();

    if (query.trim().isEmpty) return;
    if (query == lastQuery) return;

    lastQuery = query;

    _debounce = Timer(Duration(milliseconds: 300), () async {
      try {
        _uiState = Loading();
        notifyListeners();

        final result = await _apiServices.searchRestaurant(query);

        if (result.error) {
          _uiState = Error("");
          notifyListeners();
        } else {
          _uiState = Success(result.restaurants);
          notifyListeners();
        }
      } on Exception catch (e) {
        _uiState = Error(e.toString());
        notifyListeners();
      }
    });
  }
}
