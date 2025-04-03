import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_submission_2/data/api/api_services.dart';
import 'package:flutter_submission_2/data/model/restaurant_list_item.dart';
import 'package:flutter_submission_2/data/model/restaurant_list_response.dart';
import 'package:flutter_submission_2/di/api_service_provider.dart';
import 'package:flutter_submission_2/provider/list/restaurant_list_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApiServices extends Mock implements ApiServices {}

void main() {
  late MockApiServices mockApiServices;
  late ProviderContainer container;

  setUp(() {
    mockApiServices = MockApiServices();
    container = ProviderContainer(
      overrides: [apiServicesProvider.overrideWithValue(mockApiServices)],
    );
  });

  tearDown(() {
    container.dispose();
  });

  test("initial state is loading", () async {
    final mockResponse = RestaurantListResponse(
      error: false,
      message: "success",
      count: 1,
      restaurants: [
        RestaurantListItem(
          id: "id",
          name: "name",
          description: "description",
          picture: "picture",
          city: "city",
          rating: 1.0,
        ),
      ],
    );
    when(() => mockApiServices.getRestaurantList()).thenAnswer((_) async {
      Future.delayed(Duration(seconds: 1));
      return mockResponse;
    });

    final actual = await container.read(fetchRestaurantListProvider);
    expect(actual, isA<AsyncLoading>());
  });

  test("fetch list success", () async {
    final mockResponse = RestaurantListResponse(
      error: false,
      message: "success",
      count: 1,
      restaurants: [
        RestaurantListItem(
          id: "id",
          name: "name",
          description: "description",
          picture: "picture",
          city: "city",
          rating: 1.0,
        ),
      ],
    );

    when(
      () => mockApiServices.getRestaurantList(),
    ).thenAnswer((_) async => mockResponse);

    final actual = await container.read(fetchRestaurantListProvider.future);
    expect(actual, isNotEmpty);
  });

  test("fetch list failed", () async {
    when(() => mockApiServices.getRestaurantList()).thenThrow(Exception());

    expect(
      () async => await container.read(fetchRestaurantListProvider.future),
      throwsException,
    );
  });
}
