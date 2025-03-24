import 'package:flutter/foundation.dart';
import 'package:flutter_submission_2/data/api/api_services.dart';
import 'package:flutter_submission_2/static/ui_state.dart';

class RestaurantDetailsProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantDetailsProvider(this._apiServices);

  UiState _uiState = Idle();

  UiState get uiState => _uiState;

  Future<void> fetch(String id) async {
    try {
      _uiState = Loading();
      notifyListeners();

      final result = await _apiServices.getRestaurantDetails(id);

      if (result.error) {
        _uiState = Error(result.message);
        notifyListeners();
      } else {
        _uiState = Success(result.restaurant);
        notifyListeners();
      }
    } on Exception catch (e) {
      _uiState = Error(e.toString());
      notifyListeners();
    }
  }
}
