import 'package:flutter_submission_2/constants/base_url_constants.dart';
import 'package:flutter_submission_2/data/model/restaurant_details_response.dart';
import 'package:flutter_submission_2/data/model/restaurant_search_response.dart';
import 'package:http/http.dart' as http;

import '../model/restaurant_list_response.dart';

class ApiServices {
  Future<RestaurantListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("${Constants.baseUrl}/list"));

    if (response.statusCode == 200) {
      return RestaurantListResponse.fromRawJson(response.body);
    } else {
      throw Exception("Failed to load");
    }
  }

  Future<RestaurantSearchResponse> searchRestaurant(String query) async {
    final response = await http.get(
      Uri.parse("${Constants.baseUrl}/search?q=$query"),
    );

    if (response.statusCode == 200) {
      return RestaurantSearchResponse.fromRawJson(response.body);
    } else {
      throw Exception("Failed to load");
    }
  }

  Future<RestaurantDetailsResponse> getRestaurantDetails(String id) async {
    final response = await http.get(
      Uri.parse("${Constants.baseUrl}/detail/$id"),
    );

    if (response.statusCode == 200) {
      return RestaurantDetailsResponse.fromRawJson(response.body);
    } else {
      throw Exception("Failed to load");
    }
  }
}
